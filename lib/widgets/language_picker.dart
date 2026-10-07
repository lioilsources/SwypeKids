import 'package:flutter/material.dart';
import '../data/lessons.dart';
import '../services/entitlement_service.dart';
import '../ui/app_font.dart';

const Map<Language, String> kLanguageFlag = {
  Language.cs: '🇨🇿',
  Language.en: '🇬🇧',
  Language.de: '🇩🇪',
  Language.es: '🇪🇸',
  Language.it: '🇮🇹',
  Language.fr: '🇫🇷',
  Language.zh: '🇨🇳',
  Language.ja: '🇯🇵',
  Language.pt: '🇧🇷',
};

/// Jméno jazyka v něm samém (nepřekládá se) — názvy produktů v koutku.
const Map<Language, String> kLanguageName = {
  Language.cs: 'Čeština',
  Language.en: 'English',
  Language.de: 'Deutsch',
  Language.es: 'Español',
  Language.it: 'Italiano',
  Language.fr: 'Français',
  Language.zh: '中文',
  Language.ja: '日本語',
  Language.pt: 'Português',
};

/// Vlajky pro dítě: jen jazyky s odemčeným Ostrovem písmenek
/// ([EntitlementService.childLanguages]; bez obchodu všechny). Další jazyk
/// přidává rodič v koutku — tady o nákupu není nic.
class LanguagePicker extends StatelessWidget {
  final Language value;
  final ValueChanged<Language> onChanged;

  const LanguagePicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final offered = EntitlementService.instance.childLanguages;
    // Právě hraný jazyk v nabídce vždy je (DropdownButton to vyžaduje).
    final languages = [
      for (final l in Language.values)
        if (l == value || offered.contains(l)) l,
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(99),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Language>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down,
              size: 18, color: Color(0xFFA0C4FF)),
          dropdownColor: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(12),
          items: languages
              .map((l) => DropdownMenuItem(
                    value: l,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(kLanguageFlag[l] ?? '🏳️',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 6),
                        Text(
                          l.name.toUpperCase(),
                          style: TextStyle(
                            fontFamily: kFont,
                            fontFamilyFallback: kFontFallback,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFA0C4FF),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (_) => languages
              .map((l) => Center(
                    child: Text(
                      kLanguageFlag[l] ?? '🏳️',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ))
              .toList(),
          onChanged: (l) {
            if (l != null && l != value) onChanged(l);
          },
        ),
      ),
    );
  }
}
