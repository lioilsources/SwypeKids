// Balíček pro rodilého mluvčího (docs/PLAN_VETY_KVALITA.md §3.7).
//
//   dart run tool/sentences/export_review.dart --lang de [--all]
//
// Vyrobí `build/review/<lang>.html`: jednu stránku, která funguje offline
// (jde poslat e-mailem). Korektor u každé položky ťukne ✅ / ✏️ (napíše
// správně) / ❌ (nedává smysl) a stáhne odpovědi jako TSV; ty se načtou
// přes `import_review.dart`. Bez `--all` jsou na stránce jen položky, které
// ještě nikdo neposoudil (nové a změněné věty).
import 'dart:convert';
import 'dart:io';

import 'review_classes.dart';
import 'review_rows.dart';

const _intro = {
  'cs': 'U každé věty vyber: ✅ správně a přirozeně · ✏️ skoro, napiš to správně · ❌ nedává smysl, dítěti by se to neřeklo.',
  'en': 'For each sentence choose: ✅ correct and natural · ✏️ nearly, type it correctly · ❌ makes no sense, nobody would say it to a child.',
  'de': 'Wähle bei jedem Satz: ✅ richtig und natürlich · ✏️ fast, schreib ihn richtig · ❌ ergibt keinen Sinn, so würde man es einem Kind nicht sagen.',
  'es': 'En cada frase elige: ✅ correcta y natural · ✏️ casi, escríbela bien · ❌ no tiene sentido, no se le diría a un niño.',
  'it': 'Per ogni frase scegli: ✅ corretta e naturale · ✏️ quasi, scrivila giusta · ❌ non ha senso, non si direbbe a un bambino.',
  'fr': 'Pour chaque phrase, choisis : ✅ correcte et naturelle · ✏️ presque, écris-la correctement · ❌ n’a pas de sens, on ne le dirait pas à un enfant.',
  'pt': 'Em cada frase escolha: ✅ correta e natural · ✏️ quase, escreva do jeito certo · ❌ não faz sentido, ninguém diria isso a uma criança.',
  'zh': '每个句子请选择：✅ 正确、自然 · ✏️ 差不多，请写出正确的说法 · ❌ 没有意义，不会这样对孩子说。',
  'ja': 'それぞれの文について選んでください：✅ 正しく自然 · ✏️ ほぼ正しい（正しい文を書いてください） · ❌ 意味が通じない、子どもには言わない。',
};

String _esc(String s) => const HtmlEscape().convert(s);

void main(List<String> args) {
  final i = args.indexOf('--lang');
  if (i < 0 || i + 1 >= args.length || !_intro.containsKey(args[i + 1])) {
    stderr.writeln('Použití: dart run tool/sentences/export_review.dart '
        '--lang <${_intro.keys.join('|')}> [--all]');
    exitCode = 2;
    return;
  }
  final lang = args[i + 1];
  final all = args.contains('--all');
  final pack = jsonDecode(File('assets/packs/$lang.json').readAsStringSync())
      as Map<String, dynamic>;
  final sentence = pack['sentence'] as Map<String, dynamic>;
  final firstPerson = ((sentence['subjects'] as List).first as Map)['id'] as String;
  final emoji = <String, String>{
    for (final k in ['subjects', 'verbs', 'objects'])
      for (final t in sentence[k] as List)
        (t as Map)['id'] as String: t['emoji'] as String,
  };

  final rows = ReviewRows.read(lang);
  final classes = ReviewClasses.build(rows.values, firstPerson: firstPerson);
  // Položka čeká, když čeká aspoň jedna věta, které se týká.
  bool pending(List<String> ids) => ids.any((id) => rows[id]!.human == 'pending');
  final items = [
    for (final e in classes.entries)
      if (all || pending(e.value.ids)) e,
  ];

  String pictures(String key) {
    final p = key.split(':').last.split('.');
    if (key.startsWith('class:')) {
      return [emoji[p[1]], emoji[p[2]]].whereType<String>().join(' ');
    }
    if (key.startsWith('subject:')) {
      final id = key.split(':').sublist(2).join(':');
      return id.startsWith('reward:') ? id.substring(7) : (emoji[id] ?? '');
    }
    return '';
  }

  String section(String title, String prefix) {
    final part = items.where((e) => e.key.startsWith(prefix)).toList();
    if (part.isEmpty) return '';
    final b = StringBuffer('<h2>${_esc(title)} <small>${part.length}</small></h2>');
    for (final e in part) {
      b.write('<div class="item" data-key="${_esc(e.key)}">'
          '<span class="pic">${_esc(pictures(e.key))}</span>'
          '<span class="text">${_esc(e.value.example)}</span>'
          '<span class="btns">'
          '<button data-v="ok">✅</button>'
          '<button data-v="fix">✏️</button>'
          '<button data-v="nonsense">❌</button></span>'
          '<input class="note" placeholder="…" hidden></div>');
    }
    return b.toString();
  }

  final html = '''<!doctype html>
<html lang="$lang"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SwypeKids — sentences ($lang)</title>
<style>
:root{color-scheme:light dark}
body{font:17px/1.45 system-ui,sans-serif;max-width:760px;margin:0 auto;padding:16px}
h1{font-size:22px} h2{font-size:17px;margin-top:28px} small{opacity:.6;font-weight:400}
.intro{padding:12px 14px;border-radius:12px;background:rgba(127,127,127,.14)}
.item{display:grid;grid-template-columns:64px 1fr auto;gap:10px;align-items:center;padding:8px 6px;border-bottom:1px solid rgba(127,127,127,.25)}
.item .note{grid-column:2/4;font:inherit;padding:6px 8px;border-radius:8px;border:1px solid rgba(127,127,127,.5)}
.pic{font-size:22px} .text{font-size:19px}
button{font-size:20px;padding:4px 9px;border-radius:10px;border:1px solid rgba(127,127,127,.4);background:transparent;cursor:pointer}
.item[data-state=ok]{background:rgba(40,180,90,.14)} .item[data-state=fix]{background:rgba(240,180,40,.18)}
.item[data-state=nonsense]{background:rgba(230,70,70,.16)}
button.on{outline:3px solid currentColor}
#bar{position:sticky;bottom:0;padding:12px 0;background:Canvas;display:flex;gap:10px;align-items:center;flex-wrap:wrap}
#bar input{font:inherit;padding:6px 8px;border-radius:8px;border:1px solid rgba(127,127,127,.5)}
#save{font-size:17px;padding:8px 14px}
</style></head><body>
<h1>SwypeKids — ${_esc(lang)} · ${items.length}</h1>
<p class="intro">${_esc(_intro[lang]!)}<br><small>${_esc(_intro['en']!)}</small></p>
${section('Verb + object', 'class:')}
${section('Who (subject at the start of a sentence)', 'subject:')}
${section('Other sentences', 'single:')}
<div id="bar"><input id="who" placeholder="Name"> <button id="save">⬇︎ TSV</button> <span id="count"></span></div>
<script>
const LANG=${jsonEncode(lang)}, KEY='swypekids-review-'+LANG;
let state={}; try{state=JSON.parse(localStorage.getItem(KEY)||'{}')}catch(e){}
const items=[...document.querySelectorAll('.item')];
function paint(){let done=0;for(const el of items){const s=state[el.dataset.key];
 el.dataset.state=s?s.v:'';if(s)done++;
 el.querySelectorAll('button').forEach(b=>b.classList.toggle('on',!!s&&b.dataset.v===s.v));
 const n=el.querySelector('.note');n.hidden=!s||s.v==='ok';if(s&&document.activeElement!==n)n.value=s.note||'';}
 document.getElementById('count').textContent=done+' / '+items.length;
 try{localStorage.setItem(KEY,JSON.stringify(state))}catch(e){}}
for(const el of items){
 el.querySelectorAll('button').forEach(b=>b.onclick=()=>{state[el.dataset.key]={v:b.dataset.v,note:(state[el.dataset.key]||{}).note||''};paint();
  if(b.dataset.v!=='ok')el.querySelector('.note').focus();});
 el.querySelector('.note').oninput=e=>{state[el.dataset.key].note=e.target.value;try{localStorage.setItem(KEY,JSON.stringify(state))}catch(_){}};}
document.getElementById('save').onclick=()=>{
 const who=document.getElementById('who').value.trim()||'anonymous';
 const clean=s=>String(s||'').replace(/[\\t\\r\\n]+/g,' ');
 const lines=['key\\tverdict\\tnote\\treviewer'];
 for(const [k,s] of Object.entries(state))lines.push([k,s.v,clean(s.note),clean(who)].join('\\t'));
 const a=document.createElement('a');
 a.href=URL.createObjectURL(new Blob([lines.join('\\n')+'\\n'],{type:'text/tab-separated-values'}));
 a.download='swypekids-review-'+LANG+'.tsv';a.click();};
paint();
</script></body></html>
''';
  final out = File('build/review/$lang.html')..createSync(recursive: true);
  out.writeAsStringSync(html);
  stdout.writeln('${out.path}: ${items.length} položek '
      '(${rows.values.where((r) => r.human == 'pending').length} vět čeká)');
}
