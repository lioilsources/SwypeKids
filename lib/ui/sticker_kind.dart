/// Druh nálepky podle emoji — podle něj nálepka reaguje na dotyk a ve
/// světě zvířátka určuje, jestli je dárek jídlo, pití nebo hračka.
/// Sada emoji, ne jazyk: platí pro všech 9 packů.
enum StickerKind {
  animal,
  food,
  drink,
  other;

  static StickerKind of(String emoji) {
    final e = emoji.replaceAll('\u{FE0F}', '');
    if (_drink.contains(e)) return drink;
    if (_food.contains(e)) return food;
    if (_animal.contains(e)) return animal;
    return other;
  }

  /// Jeden znak = jedno emoji (kódový bod, bez FE0F).
  static Set<String> _set(String all) =>
      {for (final r in all.runes) String.fromCharCode(r)};

  static final Set<String> _animal = _set('🐀🐂🐉🐊🐋🐌🐍🐑🐓🐔🐕🐘🐙🐛🐝🐟🐢🐤🐦🐧🐨🐬🐭🐮🐯🐰🐱🐳🐴🐵🐶🐷🐸🐺🐻🐼🐿🦀🦁🦅🦆🦇🦉🦊🦋🦍🦑🦒🦓🦔🦕🦘🦛🦞🦢🕊🐄🐒🐞🐣🦜🧸');

  static final Set<String> _food = _set('🍅🍇🍈🍉🍊🍋🍌🍍🍎🍐🍑🍓🍕🍖🍙🍚🍝🍞🍟🍠🍦🍩🍪🍫🍬🍲🍿🎂🥑🥒🥔🥕🥗🥚🥜🥟🥣🥧🥫🥬🧀🧅🌭🍄🦴🧂🍽🍴');

  static final Set<String> _drink = _set('🥛🧃🥤🍵☕🍼💧🚰');
}
