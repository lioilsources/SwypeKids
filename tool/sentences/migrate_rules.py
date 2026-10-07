#!/usr/bin/env python3
"""Jednorázová migrace `pack.sentence` na pravidla (docs/PLAN_VETY_KVALITA.md §3.1):
druh podmětu, štítky a výslovné tvary předmětů, co sloveso bere, pojmenovací věta,
`reward.kind` a vlastní slovesa věcí. Tvary jsou autorské — po změně vždy
`UPDATE_SENTENCES=1 flutter test test/sentence_corpus_test.dart` a korektura."""
import json, collections, sys
OD = collections.OrderedDict

PERSON = set('👧👦👨👩👶👵👴🧒🧍🧚🤖🤡')
ANIMAL = set('🐀🐂🐉🐊🐋🐌🐍🐑🐓🐔🐕🐘🐙🐛🐝🐟🐢🐤🐦🐧🐨🐬🐭🐮🐯🐰🐱🐳🐴🐵🐶🐷🐸🐺🐻🐼🐿🦀🦁🦅🦆🦇🦉🦊🦋🦍🦑🦒🦓🦔🦕🦘🦛🦞🦢🕊🐄🐒🐞🐣🦜🧸')
def kind(e):
    e = e.replace('️', '')
    return 'person' if e in PERSON else 'animal' if e in ANIMAL else 'thing'

# Co sloveso bere (stejné ve všech jazycích; ids v1…v6 jsou společná).
VERBS = {
    'v1': (['food', 'drink', 'toy', 'vehicle', 'thing'], 'acc'),
    'v2': (['food'], 'acc'),
    'v3': (['drink'], 'acc'),
    'v4': (['place'], 'loc'),
    'v5': (['place'], 'dir'),
    'v6': (['toy', 'vehicle'], 'instr'),
}
WHO = ['person', 'animal']

def F(tags, nom=None, **forms):
    return (tags.split(), nom, forms)

# id → (štítky, 1. pád pro pojmenovací větu, tvary pro rámce). Tvar pro
# rámec existuje jen tam, kde věta dává smysl.
OBJ = {
 'cs': {
  'mleko': F('drink', 'mléko', acc='mléko'),
  'o2': F('food', 'jablko', acc='jablko'),
  'hracka': F('toy', 'hračka', acc='hračku', instr='s hračkou'),
  'auto': F('vehicle place', 'auto', acc='auto', instr='s autem', loc='v autě', dir='do auta'),
  'o5': F('place', None, loc='venku', dir='ven'),
  'o6': F('place', 'dům', loc='doma', dir='domů'),
  'o7': F('place', 'postýlka', loc='v postýlce', dir='do postýlky'),
  'o8': F('place', 'nočník', dir='na nočník'),
  'kolo': F('vehicle', 'kolo', acc='kolo', instr='s kolem'),
  'les': F('place', 'les', loc='v lese', dir='do lesa'),
  'nos': F('body', 'nos'),
  'miska': F('thing', 'miska', acc='misku'),
  'voda': F('drink', 'voda', acc='vodu'),
  'vlak': F('vehicle place', 'vlak', acc='vlak', instr='s vlakem', loc='ve vlaku', dir='do vlaku'),
  'fotbal': F('thing', 'fotbal'),
  'banan': F('food', 'banán', acc='banán'),
  'kniha': F('thing', 'kniha', acc='knihu'),
  'skola': F('place', 'škola', dir='do školy'),
 },
 'en': {
  'o1': F('drink', 'milk', acc='milk'),
  'o2': F('food', 'an apple', acc='an apple'),
  'o3': F('toy', 'a toy', acc='a toy', instr='with a toy'),
  'o4': F('vehicle place', 'the car', acc='the car', instr='with the car', loc='in the car', dir='to the car'),
  'o5': F('place', None, loc='outside', dir='outside'),
  'home': F('place', 'home', loc='at home', dir='home'),
  'o7': F('place', 'the bed', loc='in bed', dir='to bed'),
  'o8': F('place', 'the potty', dir='to the potty'),
  'cup': F('thing', 'a cup', acc='a cup'),
  'cap': F('thing', 'a cap', acc='a cap'),
  'pot': F('thing', 'a pot', acc='a pot'),
  'cot': F('place', 'the cot', loc='in the cot', dir='to the cot'),
  'sun': F('place', 'the sun', loc='in the sun'),
  'hat': F('thing', 'a hat', acc='a hat'),
  'bus': F('vehicle place', 'the bus', acc='the bus', instr='with the bus', loc='on the bus', dir='to the bus'),
  'drum': F('toy', 'a drum', acc='a drum', instr='with a drum'),
  'star': F('thing', 'a star', acc='a star'),
  'cake': F('food', 'cake', acc='cake'),
  'bike': F('vehicle', 'a bike', acc='a bike'),
 },
 'de': {
  'o1': F('drink', 'Milch', acc='Milch'),
  'o2': F('food', 'ein Apfel', acc='einen Apfel'),
  'o3': F('toy', 'ein Spielzeug', acc='ein Spielzeug', instr='mit einem Spielzeug'),
  'o4': F('vehicle place', 'das Auto', acc='das Auto', instr='mit dem Auto', loc='im Auto'),
  'o5': F('place', None, loc='draußen', dir='raus'),
  'o6': F('place', None, loc='zu Hause', dir='heim'),
  'o7': F('place', 'das Bett', loc='im Bett', dir='ins Bett'),
  'o8': F('place', 'das Töpfchen', dir='aufs Töpfchen'),
  'ball': F('toy', 'der Ball', acc='den Ball', instr='mit dem Ball'),
  'brot': F('food', 'Brot', acc='Brot'),
  'keks': F('food', 'ein Keks', acc='einen Keks'),
  'banane': F('food', 'eine Banane', acc='eine Banane'),
  'melone': F('food', 'eine Melone', acc='eine Melone'),
 },
 'es': {
  'o1': F('drink', 'leche', acc='leche'),
  'o2': F('food', 'una manzana', acc='una manzana'),
  'o3': F('toy', 'un juguete', acc='un juguete', instr='con un juguete'),
  'o4': F('vehicle place', 'el coche', acc='el coche', instr='con el coche', loc='en el coche', dir='al coche'),
  'o5': F('place', None, loc='fuera', dir='fuera'),
  'casa': F('place', 'la casa', loc='en casa', dir='a casa'),
  'cama': F('place', 'la cama', loc='en la cama', dir='a la cama'),
  'o8': F('place', 'el baño', dir='al baño'),
  'luna': F('place', 'la luna', dir='a la luna'),
  'galleta': F('food', 'una galleta', acc='una galleta'),
  'platano': F('food', 'un plátano', acc='un plátano'),
  'zapato': F('thing', 'un zapato', acc='un zapato'),
  'manzana': F('food', 'una manzana', acc='una manzana'),
 },
 'it': {
  'o1': F('drink', 'il latte', acc='il latte'),
  'mela': F('food', 'una mela', acc='una mela'),
  'o3': F('toy', 'un giocattolo', acc='un giocattolo', instr='con un giocattolo'),
  'o4': F('vehicle place', 'la macchina', acc='la macchina', instr='con la macchina', loc='in macchina', dir='in macchina'),
  'o5': F('place', None, loc='fuori', dir='fuori'),
  'casa': F('place', 'la casa', loc='a casa', dir='a casa'),
  'o7': F('place', 'il letto', loc='a letto', dir='a letto'),
  'o8': F('place', 'il vasino', dir='sul vasino'),
  'sole': F('place', 'il sole', loc='al sole'),
  'luna': F('place', 'la luna', dir='sulla luna'),
  'torta': F('food', 'la torta', acc='la torta'),
  'banana': F('food', 'una banana', acc='una banana'),
  'gelato': F('food', 'un gelato', acc='un gelato'),
  'pizza': F('food', 'la pizza', acc='la pizza'),
  'fragola': F('food', 'una fragola', acc='una fragola'),
 },
 'fr': {
  'o1': F('drink', 'du lait', acc='du lait'),
  'pomme': F('food', 'une pomme', acc='une pomme'),
  'o3': F('toy', 'un jouet', acc='un jouet', instr='avec un jouet'),
  'o4': F('vehicle place', 'la voiture', acc='la voiture', instr='avec la voiture', loc='dans la voiture', dir='en voiture'),
  'o5': F('place', None, loc='dehors', dir='dehors'),
  'maison': F('place', 'la maison', loc='à la maison', dir='à la maison'),
  'o7': F('place', 'le lit', loc='au lit', dir='au lit'),
  'o8': F('place', 'le pot', dir='au pot'),
  'lune': F('place', 'la lune', dir='sur la lune'),
  'soupe': F('food', 'de la soupe', acc='de la soupe'),
  'carotte': F('food', 'une carotte', acc='une carotte'),
  'banane': F('food', 'une banane', acc='une banane'),
  'ballon': F('toy', 'un ballon', acc='un ballon', instr='avec un ballon'),
  'fraise': F('food', 'une fraise', acc='une fraise'),
 },
 'pt': {
  'o1': F('drink', 'leite', acc='leite'),
  'o2': F('food', 'uma maçã', acc='uma maçã'),
  'o3': F('toy', 'um brinquedo', acc='um brinquedo', instr='com um brinquedo'),
  'o4': F('vehicle place', 'o carro', acc='o carro', instr='com o carro', loc='no carro', dir='de carro'),
  'o5': F('place', None, loc='lá fora', dir='para fora'),
  'casa': F('place', 'a casa', loc='em casa', dir='para casa'),
  'cama': F('place', 'a cama', loc='na cama', dir='para a cama'),
  'o8': F('place', 'o peniquinho', dir='no peniquinho'),
  'lua': F('place', 'a lua', dir='para a lua'),
  'uva': F('food', 'uva', acc='uva'),
  'tomate': F('food', 'tomate', acc='tomate'),
  'sopa': F('food', 'sopa', acc='sopa'),
  'bola': F('toy', 'a bola', acc='a bola', instr='com a bola'),
  'pipoca': F('food', 'pipoca', acc='pipoca'),
  'escola': F('place', 'a escola', dir='para a escola'),
  'morango': F('food', 'morango', acc='morango'),
  'queijo': F('food', 'queijo', acc='queijo'),
  'suco': F('drink', 'suco', acc='suco'),
  'pao': F('food', 'pão', acc='pão'),
  'praia': F('place', 'a praia', loc='na praia', dir='para a praia'),
  'bicicleta': F('vehicle', 'a bicicleta', acc='a bicicleta'),
  'livro': F('thing', 'um livro', acc='um livro'),
 },
 # Čínština: bez pádů; místo po „睡" nese „在…上/里" samo, pořadí zůstává.
 'zh': {
  'niunai': F('drink', '牛奶', acc='牛奶'),
  'pingguo': F('food', '苹果', acc='苹果'),
  'o3': F('toy', '玩具', acc='玩具', instr='玩具'),
  'o4': F('vehicle place', '车车', acc='车车', instr='车车', loc='在车车里'),
  'o5': F('place', None, loc='在外面', dir='外面'),
  'o6': F('place', '家', loc='在家里'),
  'o7': F('place', '床', loc='在床上'),
  'o8': F('place', None, dir='上厕所'),
  'tang': F('food', '糖', acc='糖'),
  'dangao': F('food', '蛋糕', acc='蛋糕'),
  'mianbao': F('food', '面包', acc='面包'),
  'putao': F('food', '葡萄', acc='葡萄'),
  'xigua': F('food', '西瓜', acc='西瓜'),
  'qiqiu': F('toy', '气球', acc='气球', instr='气球'),
  'caomei': F('food', '草莓', acc='草莓'),
  'rou': F('food', '肉', acc='肉'),
  'mifan': F('food', '米饭', acc='米饭'),
  'xiangjiao': F('food', '香蕉', acc='香蕉'),
 },
 # Japonština: částice jsou součást tvaru; „ほしい" bere が (rámec `ga`).
 'ja': {
  'o1': F('drink', 'ぎゅうにゅう', ga='ぎゅうにゅうが', acc='ぎゅうにゅうを'),
  'o2': F('food', 'りんご', ga='りんごが', acc='りんごを'),
  'o3': F('toy', 'おもちゃ', ga='おもちゃが', instr='おもちゃで'),
  'kuruma': F('vehicle place', 'くるま', ga='くるまが', instr='くるまで', loc='くるまで', dir='くるまに'),
  'o5': F('place', None, loc='そとで', dir='そとへ'),
  'o6': F('place', 'おうち', loc='おうちで', dir='おうちへ'),
  'o7': F('place', 'ベッド', loc='ベッドで', dir='ベッドへ'),
  'o8': F('place', 'おまる', dir='おまるへ'),
  'kome': F('food', 'こめ', ga='こめが', acc='こめを'),
  'sakana': F('food', 'さかな', ga='さかなが', acc='さかなを'),
  'mikan': F('food', 'みかん', ga='みかんが', acc='みかんを'),
  'momo': F('food', 'もも', ga='ももが', acc='ももを'),
  'yama': F('place', 'やま', dir='やまへ'),
  'hon': F('thing', 'ほん', ga='ほんが'),
  'tamago': F('food', 'たまご', ga='たまごが', acc='たまごを'),
  'banana': F('food', 'バナナ', ga='バナナが', acc='バナナを'),
  'ichigo': F('food', 'いちご', ga='いちごが', acc='いちごを'),
  'pan': F('food', 'パン', ga='パンが', acc='パンを'),
  'ocha': F('drink', 'おちゃ', ga='おちゃが', acc='おちゃを'),
  'densha': F('vehicle', 'でんしゃ', ga='でんしゃが', instr='でんしゃで'),
  'boushi': F('thing', 'ぼうし', ga='ぼうしが'),
 },
}
FRAME_OVERRIDE = {'ja': {'v1': 'ga'}, 'zh': {'v6': 'instr'}}
TEXT_OVERRIDE = {'en': {'bike': 'a bike'}, 'it': {'o3': 'un giocattolo'}}
# Podměty se členem — holé „Dog wants milk" / „Pato quiere" není věta.
SUBJECT_TEXT = {
 'en': {'dog': 'The dog', 'cat': 'The cat', 'pig': 'The pig', 'hen': 'The hen',
        'bug': 'The bug', 'frog': 'The frog', 'fish': 'The fish', 'chick': 'The chick'},
 'es': {'s5': 'El perrito', 'pato': 'El pato', 'raton': 'El ratón', 'gato': 'El gato',
        'tortuga': 'La tortuga', 'vaca': 'La vaca'},
 'it': {'s5': 'Il cucciolo', 'topo': 'Il topo', 'cane': 'Il cane', 'gatto': 'Il gatto',
        'volpe': 'La volpe'},
 'pt': {'s5': 'O cachorrinho', 'leao': 'O leão', 'pato': 'O pato', 'sapo': 'O sapo',
        'vaca': 'A vaca', 'macaco': 'O macaco', 'gato': 'O gato', 'jacare': 'O jacaré',
        'peixe': 'O peixe', 'galinha': 'A galinha'},
}
NAMING = {'cs': 'To je {nom}.', 'en': 'This is {nom}.', 'de': 'Das ist {nom}.',
          'es': 'Esto es {nom}.', 'it': 'Ecco {nom}.', 'fr': "C'est {nom}.",
          'pt': 'Isto é {nom}.', 'zh': '这是{nom}。', 'ja': '{nom}です。'}
# Vlastní slovesa věcí ve světě zvířátka: emoji nálepky → sloveso (tvar ve
# větě), obrázek, rámec předmětu a štítky, se kterými dává smysl.
REWARD_VERB = {
 'cs': {'👁️': ('se dívá na', '👀', 'acc', ['food', 'drink', 'toy', 'vehicle', 'thing']),
        '👂': ('slyší', '👂', 'acc', ['vehicle']),
        '☀️': ('svítí na', '☀️', 'acc', ['toy', 'vehicle', 'thing']),
        '🚗': ('veze', '🚗', 'acc', ['food', 'drink', 'toy', 'thing'])},
 'en': {'☀️': ('shines on', '☀️', 'acc', ['toy', 'vehicle', 'thing'])},
 'de': {'👃': ('riecht', '👃', 'acc', ['food'])},
 'it': {'👃': ('annusa', '👃', 'acc', ['food'])},
}

# Druhý nápoj tam, kde by „pít" mělo jedinou větu (T7: aspoň 2 na sloveso).
WATER = {'en': ('water', 'water', {'acc': 'water'}),
         'de': ('Wasser', 'Wasser', {'acc': 'Wasser'}),
         'es': ('agua', 'agua', {'acc': 'agua'}),
         'it': ("l'acqua", "l'acqua", {'acc': "l'acqua"}),
         'fr': ("de l'eau", "de l'eau", {'acc': "de l'eau"}),
         'pt': ('água', 'água', {'acc': 'água'}),
         'zh': ('水', '水', {'acc': '水'}),
         'ja': ('みず', 'みず', {'ga': 'みずが', 'acc': 'みずを'})}
for lang, (text, nom, forms) in WATER.items():
    OBJ[lang]['o9'] = (['drink'], nom, forms)

for lang, objs in OBJ.items():
    p = f'assets/packs/{lang}.json'
    d = json.loads(open(p).read(), object_pairs_hook=OD)
    s = d['sentence']
    if lang in WATER and not any(o['id'] == 'o9' for o in s['objects']):
        s['objects'].append(OD([('id', 'o9'), ('emoji', '💧'), ('text', WATER[lang][0]),
                                ('unlockedBy', 'always')]))
    assert set(o['id'] for o in s['objects']) == set(objs), (lang, set(o['id'] for o in s['objects']) ^ set(objs))
    for x in s['subjects']:
        x['kind'] = kind(x['emoji'])
        if x['id'] in SUBJECT_TEXT.get(lang, {}):
            x['text'] = SUBJECT_TEXT[lang][x['id']]
        if lang == 'zh':
            x.pop('person', None)  # slovesa nemají tvary podle osoby
        if lang == 'ja':
            # „ほしいです" jde říct jen o sobě (3. osoba: ほしがっています) →
            # v1 má tvar jen pro 1. osobu a pravidla ho jinde nenabídnou.
            x['person'] = '1sg' if x['id'] == 's1' else '3sg'
    for v in s['verbs']:
        tags, frame = VERBS[v['id']]
        v['frame'] = FRAME_OVERRIDE.get(lang, {}).get(v['id'], frame)
        v['subject'] = WHO
        v['object'] = tags
        if lang == 'ja':
            if v['id'] == 'v1':
                v['forms'] = OD([('1sg', v['text'])])
            else:
                v['forms'] = OD([('1sg', v['text']), ('3sg', v['text'])])
    for o in s['objects']:
        tags, nom, forms = objs[o['id']]
        if o['id'] in TEXT_OVERRIDE.get(lang, {}):
            o['text'] = TEXT_OVERRIDE[lang][o['id']]
        o['tags'] = tags
        f = OD()
        if nom:
            f['nom'] = nom
        for k in ('ga', 'acc', 'instr', 'loc', 'dir'):
            if k in forms:
                f[k] = forms[k]
        o['forms'] = f
    new = OD()
    for k, v in s.items():
        if k == 'naming':
            continue
        new[k] = v
        if k in ('order', 'joiner') and 'naming' not in new and (k == 'order' or 'order' not in s):
            new['naming'] = NAMING[lang]
    d['sentence'] = new
    for u in d['units']:
        r = u['reward']
        r['kind'] = kind(r['emoji'])
        rv = REWARD_VERB.get(lang, {}).get(r['emoji'])
        if rv:
            r['verb'] = OD([('text', rv[0]), ('emoji', rv[1]), ('frame', rv[2]), ('object', rv[3])])
    open(p, 'w').write(json.dumps(d, ensure_ascii=False, indent=2) + '\n')
    print(lang, 'ok', len(objs))
