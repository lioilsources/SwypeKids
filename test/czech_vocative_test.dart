import 'package:flutter_test/flutter_test.dart';
import 'package:swype_kids/data/czech_vocative.dart';

void main() {
  test('5. pád běžných jmen', () {
    const cases = {
      'Laura': 'Lauro', 'Ema': 'Emo', 'Anna': 'Anno', 'Kuba': 'Kubo',
      'Marie': 'Marie', 'Jiří': 'Jiří', 'Zoe': 'Zoe', 'Hugo': 'Hugo',
      'Tomáš': 'Tomáši', 'Lukáš': 'Lukáši', 'Ondřej': 'Ondřeji', 'Matěj': 'Matěji',
      'Petr': 'Petře', 'Viktor': 'Viktore', 'Marek': 'Marku', 'Zdeněk': 'Zdeňku',
      'Pavel': 'Pavle', 'Karel': 'Karle', 'Daniel': 'Danieli', 'Michal': 'Michale',
      'Dominik': 'Dominiku', 'Vojtěch': 'Vojtěchu', 'Adam': 'Adame',
      'Jakub': 'Jakube', 'David': 'Davide', 'Martin': 'Martine', 'Jan': 'Jane',
      'Filip': 'Filipe', 'Kryštof': 'Kryštofe', 'Max': 'Maxi', 'Mikuláš': 'Mikuláši',
    };
    cases.forEach((name, vocative) =>
        expect(czechVocative(name), vocative, reason: name));
  });

  test('prázdné a jednopísmenné jméno se nemění', () {
    expect(czechVocative(''), '');
    expect(czechVocative(' E '), 'E');
  });
}
