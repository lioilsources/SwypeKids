import 'package:cute_kid_fonts/cute_kid_fonts.dart';

import '../services/settings_service.dart';

/// Rodina písma pro celou appku: Baloo 2 z CuteKidFonts (sdílená dětská
/// typografie, OFL). Rodič může v koutku zapnout OpenDyslexic (SIL OFL,
/// `fonts/OpenDyslexic-OFL.txt`) — písmo s těžkým spodkem písmen, které
/// některým dětem s dyslexií usnadňuje čtení.
String get kFont =>
    SettingsService.instance.dyslexiaFont ? 'OpenDyslexic' : KidFonts.baloo2;

/// Baculaté písmo pro nadpisy a písmena, která dítě čte (DynaPuff).
/// OpenDyslexic má přednost i tady.
String get kDisplayFont =>
    SettingsService.instance.dyslexiaFont ? 'OpenDyslexic' : KidFonts.dynaPuff;

/// Záloha pro znaky, které DynaPuff nemá (velká písmena pinyinu s tóny).
const kFontFallback = [KidFonts.baloo2, KidFonts.nunito];
