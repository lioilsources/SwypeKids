import 'package:cute_kid_fonts/cute_kid_fonts.dart';

import '../services/settings_service.dart';

/// Rodina písma pro celou appku: baculatý DynaPuff z CuteKidFonts (sdílená
/// dětská typografie, OFL) — všude, i v rodičovském koutku. Rodič může
/// v koutku zapnout OpenDyslexic (SIL OFL, `fonts/OpenDyslexic-OFL.txt`) —
/// písmo s těžkým spodkem písmen, které některým dětem s dyslexií usnadňuje
/// čtení.
String get kFont =>
    SettingsService.instance.dyslexiaFont ? 'OpenDyslexic' : KidFonts.dynaPuff;

/// Nadpisy a písmena, která dítě čte — dnes totéž co [kFont].
String get kDisplayFont => kFont;

/// Záloha pro znaky, které DynaPuff nemá (pinyin s tóny); patří ke každému
/// stylu s [kFont].
const kFontFallback = [KidFonts.baloo2, KidFonts.nunito];
