import 'package:cute_kid_fonts/cute_kid_fonts.dart';

import '../services/settings_service.dart';
import 'l10n.dart';

/// Rodina písma pro celou appku: baculatý DynaPuff z CuteKidFonts (sdílená
/// dětská typografie, OFL) — všude, i v rodičovském koutku. Rodič může
/// v koutku zapnout OpenDyslexic (SIL OFL, `fonts/OpenDyslexic-OFL.txt`) —
/// písmo s těžkým spodkem písmen, které některým dětem s dyslexií usnadňuje
/// čtení.
String get kFont {
  if (SettingsService.instance.dyslexiaFont) return 'OpenDyslexic';
  // DynaPuff má jen část vietnamských znamének — slovo by se skládalo ze
  // dvou písem. Vietnamské rozhraní proto celé sází Baloo 2 (umí všechna).
  // Azbuku DynaPuff nemá vůbec; tu vezme záloha Nunito celou.
  return AppLanguage.instance.code == 'vi'
      ? KidFonts.baloo2
      : KidFonts.dynaPuff;
}

/// Nadpisy a písmena, která dítě čte — dnes totéž co [kFont].
String get kDisplayFont => kFont;

/// Záloha pro znaky, které DynaPuff nemá (pinyin s tóny); patří ke každému
/// stylu s [kFont].
const kFontFallback = [KidFonts.baloo2, KidFonts.nunito];
