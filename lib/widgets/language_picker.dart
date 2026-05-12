import 'package:flutter/material.dart';
import '../data/lessons.dart';

const Map<Language, String> kLanguageFlag = {
  Language.cs: '🇨🇿',
  Language.en: '🇬🇧',
  Language.de: '🇩🇪',
  Language.es: '🇪🇸',
  Language.it: '🇮🇹',
  Language.fr: '🇫🇷',
  Language.zh: '🇨🇳',
};

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
          items: Language.values
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
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFA0C4FF),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (_) => Language.values
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
