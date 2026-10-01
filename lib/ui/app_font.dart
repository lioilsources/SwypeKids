import '../services/settings_service.dart';

/// Rodina písma pro celou appku. Default Nunito; rodič může v koutku
/// zapnout OpenDyslexic (SIL OFL, `fonts/OpenDyslexic-OFL.txt`) — písmo
/// s těžkým spodkem písmen, které některým dětem s dyslexií usnadňuje čtení.
String get kFont =>
    SettingsService.instance.dyslexiaFont ? 'OpenDyslexic' : 'Nunito';
