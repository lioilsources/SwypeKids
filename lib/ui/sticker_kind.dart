/// Druh nálepky podle emoji — podle něj nálepka reaguje na dotyk a ve
/// světě zvířátka určuje, jestli je dárek jídlo, pití nebo hračka.
/// Sada emoji, ne jazyk: platí pro všech 9 packů.
enum StickerKind {
  animal,
  person,
  food,
  drink,
  toy,
  other;

  /// Může jíst a pít (zvířátko, člověk); věci si jen hrají.
  bool get eats => this == animal || this == person;

  /// Dá se dát jako dárek (jídlo, pití, hračka).
  bool get giftable => this == food || this == drink || this == toy;

  static StickerKind of(String emoji) {
    final e = emoji.replaceAll('\u{FE0F}', '');
    if (_drink.contains(e)) return drink;
    if (_food.contains(e)) return food;
    if (_animal.contains(e)) return animal;
    if (_person.contains(e)) return person;
    if (_toy.contains(e)) return toy;
    return other;
  }

  /// Jeden znak = jedno emoji (kódový bod, bez FE0F).
  static Set<String> _set(String all) =>
      {for (final r in all.runes) String.fromCharCode(r)};

  static final Set<String> _animal = _set('🐀🐂🐉🐊🐋🐌🐍🐑🐓🐔🐕🐘🐙🐛🐝🐟🐢🐤🐦🐧🐨🐬🐭🐮🐯🐰🐱🐳🐴🐵🐶🐷🐸🐺🐻🐼🐿🦀🦁🦅🦆🦇🦉🦊🦋🦍🦑🦒🦓🦔🦕🦘🦛🦞🦢🕊🐄🐒🐞🐣🦜');

  static final Set<String> _food = _set('🍅🍇🍈🍉🍊🍋🍌🍍🍎🍐🍑🍓🍕🍖🍙🍚🍝🍞🍟🍠🍦🍩🍪🍫🍬🍲🍿🎂🥑🥒🥔🥕🥗🥚🥜🥟🥣🥧🥫🥬🧀🧅🌭🍄🦴🧂🍽🍴');

  static final Set<String> _person = _set('👧👦👨👩👶👵👴🧒🧍🧚🤖🤡');

  static final Set<String> _toy =
      _set('🧸⚽🏀🎲🪁🎈🪀🚗🚂🚲📖🎸🥁🎻🪕🎹🧶🎁⛵✈️🚌🚚🏍');

  static final Set<String> _drink = _set('🥛🧃🥤🍵☕🍼💧🚰');
}
