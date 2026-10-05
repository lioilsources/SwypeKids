import '../data/lessons.dart';

/// Průvodci, ze kterých si dítě vybírá (v profilu). Každý má obrázky
/// všech stavů v `assets/characters/<name>/` a jméno = zdrobnělina zvířete
/// v jazyce packu.
enum Guide {
  panda('🐼', {
    Language.cs: 'Pandička',
    Language.en: 'Pandy',
    Language.de: 'Pandi',
    Language.es: 'Pandita',
    Language.it: 'Pandina',
    Language.fr: 'Pandou',
    Language.pt: 'Pandinha',
    Language.zh: '熊猫宝宝',
    Language.ja: 'パンダちゃん',
  }),
  capybara('🦫', {
    Language.cs: 'Kapybárka',
    Language.en: 'Cappy',
    Language.de: 'Capy',
    Language.es: 'Capibarita',
    Language.it: 'Capibarina',
    Language.fr: 'Capybarette',
    Language.pt: 'Capivarinha',
    Language.zh: '水豚宝宝',
    Language.ja: 'カピバラちゃん',
  }),
  giraffe('🦒', {
    Language.cs: 'Žirafka',
    Language.en: 'Raffie',
    Language.de: 'Giraffchen',
    Language.es: 'Jirafita',
    Language.it: 'Giraffina',
    Language.fr: 'Girafon',
    Language.pt: 'Girafinha',
    Language.zh: '长颈鹿宝宝',
    Language.ja: 'キリンちゃん',
  }),
  cheetah('🐆', {
    Language.cs: 'Gepardíček',
    Language.en: 'Cheetie',
    Language.de: 'Gepardchen',
    Language.es: 'Guepardito',
    Language.it: 'Ghepardino',
    Language.fr: 'Guépardeau',
    Language.pt: 'Guepardinho',
    Language.zh: '猎豹宝宝',
    Language.ja: 'チーターちゃん',
  });

  /// Emoji jen jako záloha, kdyby obrázek chyběl.
  final String emoji;
  final Map<Language, String> names;

  const Guide(this.emoji, this.names);

  String nameIn(Language lang) => names[lang] ?? names[Language.en]!;

  String get assetDir => 'assets/characters/$name';

  static Guide fromName(String? s) =>
      Guide.values.where((g) => g.name == s).firstOrNull ?? Guide.panda;
}
