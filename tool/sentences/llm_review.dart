// Strojová korektura vět (docs/PLAN_VETY_KVALITA.md §3.6).
//
//   dart run tool/sentences/llm_review.dart [--lang de] [--limit 200] [--dry-run]
//
// Vezme z `review/sentences_<lang>.tsv` řádky, které stroj ještě neviděl
// (prázdné `llm` — změněná věta se tam vrací sama přes otisk textu), po
// dávkách je pošle Claude jako korektorovi dětské čítanky a zapíše verdikt
// `ok` / `flag` s poznámkou. Nic neopravuje: opravy se dělají v packu,
// člověk má poslední slovo (`human: ok` přehlasuje `flag`).
//
// Běží jen na vývojářském stroji; appka zůstává offline. Klíč se čte
// z prostředí (`ANTHROPIC_API_KEY`, nebo `ANTHROPIC_AUTH_TOKEN`), nikdy
// z repozitáře. Dart nemá oficiální Anthropic SDK → přímé HTTP volání
// Messages API se strukturovaným výstupem.
import 'dart:convert';
import 'dart:io';

import 'review_rows.dart';

const _model = 'claude-opus-5-5';
const _batch = 60;
const _languages = {
  'cs': 'Czech',
  'en': 'English (British, as spoken to a young child)',
  'de': 'German',
  'es': 'Spanish',
  'it': 'Italian',
  'fr': 'French',
  'pt': 'Brazilian Portuguese',
  'zh': 'Mandarin Chinese (simplified)',
  'ja': 'Japanese (hiragana, as written for young children)',
};

String _system(String language) => '''
You are a native-speaker proofreader of a first reader for children aged 5–9, working in $language.

A learning app composes short sentences from picture tiles (who + does what + with what / where) and reads them aloud. Children learn to read from these sentences, so every sentence the app can offer must be something a caring adult would actually say to a child.

For each sentence decide:
- "ok": grammatically correct (word order, case, agreement, articles, particles, reflexives), natural, and it makes sense — a child could picture it. Playful is fine (an animal eating an apple, an eye looking at a bike).
- "flag": anything else — a grammar mistake, an unnatural or stilted phrase, a wrong article or particle, or a sentence that is nonsense for a child (eating a potty, drinking an apple).

When you flag, the note must say what is wrong in one short sentence and give the corrected sentence if one exists (or "remove" if the combination should not be offered). Leave the note empty for "ok". Judge every sentence on its own; do not flag a sentence only because it is simple or repetitive. Write notes in English.''';

Map<String, Object?> _schema() => {
      'type': 'object',
      'properties': {
        'results': {
          'type': 'array',
          'items': {
            'type': 'object',
            'properties': {
              'id': {'type': 'string'},
              'verdict': {
                'type': 'string',
                'enum': ['ok', 'flag']
              },
              'note': {'type': 'string'},
            },
            'required': ['id', 'verdict', 'note'],
            'additionalProperties': false,
          },
        },
      },
      'required': ['results'],
      'additionalProperties': false,
    };

Future<Map<String, (String, String)>> _review(
    HttpClient http, String lang, List<ReviewRow> rows) async {
  final env = Platform.environment;
  final apiKey = env['ANTHROPIC_API_KEY'];
  final token = env['ANTHROPIC_AUTH_TOKEN'];
  final request =
      await http.postUrl(Uri.parse('https://api.anthropic.com/v1/messages'));
  request.headers
    ..set('content-type', 'application/json')
    ..set('anthropic-version', '2023-06-01');
  // Odmítnutí bezpečnostním filtrem se zkusí na záložním modelu (beta).
  final betas = ['server-side-fallback-2026-07-01'];
  if (apiKey != null && apiKey.isNotEmpty) {
    request.headers.set('x-api-key', apiKey);
  } else {
    request.headers.set('authorization', 'Bearer $token');
    betas.add('oauth-2025-04-20');
  }
  request.headers.set('anthropic-beta', betas.join(','));
  request.add(utf8.encode(jsonEncode({
    'model': _model,
    'max_tokens': 16000,
    'fallbacks': 'default',
    'system': _system(_languages[lang]!),
    'output_config': {
      'effort': 'medium',
      'format': {'type': 'json_schema', 'schema': _schema()},
    },
    'messages': [
      {
        'role': 'user',
        'content': 'Review these ${rows.length} sentences. Return one result '
            'per id.\n\n${[for (final r in rows) '${r.id}\t${r.text}'].join('\n')}',
      }
    ],
  })));
  final response = await request.close();
  final body = await utf8.decodeStream(response);
  if (response.statusCode != 200) {
    // 429 / 5xx stojí za opakování později; 4xx je chyba požadavku.
    throw HttpException('Claude API ${response.statusCode}: $body');
  }
  final message = jsonDecode(body) as Map<String, dynamic>;
  final stop = message['stop_reason'];
  if (stop == 'refusal' || stop == 'max_tokens') {
    throw StateError('dávka nedokončena (stop_reason: $stop) — zmenšit dávku');
  }
  final text = [
    for (final block in message['content'] as List)
      if ((block as Map)['type'] == 'text') block['text'] as String,
  ].join();
  final results = (jsonDecode(text) as Map)['results'] as List;
  return {
    for (final r in results)
      (r as Map)['id'] as String: (r['verdict'] as String, r['note'] as String),
  };
}

Future<void> main(List<String> args) async {
  String? opt(String name) {
    final i = args.indexOf(name);
    return i >= 0 && i + 1 < args.length ? args[i + 1] : null;
  }

  final only = opt('--lang');
  final limit = int.tryParse(opt('--limit') ?? '');
  final dryRun = args.contains('--dry-run');
  final env = Platform.environment;
  if (!dryRun &&
      (env['ANTHROPIC_API_KEY'] ?? '').isEmpty &&
      (env['ANTHROPIC_AUTH_TOKEN'] ?? '').isEmpty) {
    stderr.writeln('Chybí ANTHROPIC_API_KEY (nebo ANTHROPIC_AUTH_TOKEN) '
        'v prostředí. Nic se neposlalo.');
    exitCode = 2;
    return;
  }

  final http = HttpClient()..connectionTimeout = const Duration(seconds: 30);
  try {
    for (final lang in _languages.keys) {
      if (only != null && only != lang) continue;
      final rows = ReviewRows.read(lang);
      var todo = rows.values.where((r) => r.llm.isEmpty).toList();
      if (limit != null && todo.length > limit) todo = todo.sublist(0, limit);
      stdout.writeln('$lang: ${todo.length} vět ke korektuře '
          '(z ${rows.length})');
      if (dryRun) continue;
      var flagged = 0;
      for (var i = 0; i < todo.length; i += _batch) {
        final part = todo.sublist(i, (i + _batch).clamp(0, todo.length));
        final verdicts = await _review(http, lang, part);
        for (final r in part) {
          final v = verdicts[r.id];
          if (v == null) continue; // model řádek vynechal → zkusí se příště
          r.llm = v.$1;
          r.llmNote = v.$2;
          if (v.$1 == 'flag') flagged++;
        }
        // Zápis po každé dávce: přerušený běh nic neztratí.
        ReviewRows.write(lang, rows.values);
        stdout.writeln('  ${i + part.length}/${todo.length}');
      }
      stdout.writeln('$lang: označeno $flagged');
    }
  } finally {
    http.close();
  }
}
