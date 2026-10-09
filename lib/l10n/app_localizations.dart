import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('cs'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In cs, this message translates to:
  /// **'SwypeKids'**
  String get appTitle;

  /// No description provided for @menuSyllabary.
  ///
  /// In cs, this message translates to:
  /// **'Slabikář (Swype)'**
  String get menuSyllabary;

  /// No description provided for @menuSentence.
  ///
  /// In cs, this message translates to:
  /// **'Skládej větu'**
  String get menuSentence;

  /// No description provided for @menuZoo.
  ///
  /// In cs, this message translates to:
  /// **'Zvěřinec'**
  String get menuZoo;

  /// No description provided for @menuBook.
  ///
  /// In cs, this message translates to:
  /// **'Má knížka'**
  String get menuBook;

  /// No description provided for @menuParents.
  ///
  /// In cs, this message translates to:
  /// **'Pro rodiče'**
  String get menuParents;

  /// No description provided for @practiceTitle.
  ///
  /// In cs, this message translates to:
  /// **'Procvičování'**
  String get practiceTitle;

  /// No description provided for @bedtimeText.
  ///
  /// In cs, this message translates to:
  /// **'{guide} už spí. Zítra zase!'**
  String bedtimeText(String guide);

  /// No description provided for @typeListen.
  ///
  /// In cs, this message translates to:
  /// **'POSLECH'**
  String get typeListen;

  /// No description provided for @typePicture.
  ///
  /// In cs, this message translates to:
  /// **'OBRÁZEK'**
  String get typePicture;

  /// No description provided for @typeGap.
  ///
  /// In cs, this message translates to:
  /// **'DOPLŇ'**
  String get typeGap;

  /// No description provided for @typeReview.
  ///
  /// In cs, this message translates to:
  /// **'OPAKOVÁNÍ'**
  String get typeReview;

  /// No description provided for @typeWord.
  ///
  /// In cs, this message translates to:
  /// **'SLOVO'**
  String get typeWord;

  /// No description provided for @typeSyllable.
  ///
  /// In cs, this message translates to:
  /// **'SLABIKA'**
  String get typeSyllable;

  /// No description provided for @promptListen.
  ///
  /// In cs, this message translates to:
  /// **'Poslouchej a přejeď, co slyšíš'**
  String get promptListen;

  /// No description provided for @promptPicture.
  ///
  /// In cs, this message translates to:
  /// **'Co je na obrázku? Napiš to'**
  String get promptPicture;

  /// No description provided for @promptGap.
  ///
  /// In cs, this message translates to:
  /// **'Které písmenko chybí? Přejeď celé slovo'**
  String get promptGap;

  /// No description provided for @promptSwipeTouch.
  ///
  /// In cs, this message translates to:
  /// **'Přejeď prstem přes obrázky'**
  String get promptSwipeTouch;

  /// No description provided for @promptSwipeTrackpad.
  ///
  /// In cs, this message translates to:
  /// **'Přejeď dvěma prsty přes obrázky'**
  String get promptSwipeTrackpad;

  /// No description provided for @successText.
  ///
  /// In cs, this message translates to:
  /// **'Výborně!'**
  String get successText;

  /// No description provided for @errorText.
  ///
  /// In cs, this message translates to:
  /// **'Zkus to znovu!'**
  String get errorText;

  /// No description provided for @newSticker.
  ///
  /// In cs, this message translates to:
  /// **'Máš novou nálepku!'**
  String get newSticker;

  /// No description provided for @starsGained.
  ///
  /// In cs, this message translates to:
  /// **'+{count} hvězdiček'**
  String starsGained(int count);

  /// No description provided for @backToMap.
  ///
  /// In cs, this message translates to:
  /// **'Zpět na mapu'**
  String get backToMap;

  /// No description provided for @winTitle.
  ///
  /// In cs, this message translates to:
  /// **'Hotovo!\nJsi šampion!'**
  String get winTitle;

  /// No description provided for @winStars.
  ///
  /// In cs, this message translates to:
  /// **'Získal jsi {count} hvězdiček!'**
  String winStars(int count);

  /// No description provided for @playAgain.
  ///
  /// In cs, this message translates to:
  /// **'Hrát znovu'**
  String get playAgain;

  /// No description provided for @builderBadge.
  ///
  /// In cs, this message translates to:
  /// **'VĚTA'**
  String get builderBadge;

  /// No description provided for @who.
  ///
  /// In cs, this message translates to:
  /// **'KDO'**
  String get who;

  /// No description provided for @whatDoes.
  ///
  /// In cs, this message translates to:
  /// **'CO DĚLÁ'**
  String get whatDoes;

  /// No description provided for @whatWhere.
  ///
  /// In cs, this message translates to:
  /// **'CO / KAM'**
  String get whatWhere;

  /// No description provided for @newLabel.
  ///
  /// In cs, this message translates to:
  /// **'NOVÉ'**
  String get newLabel;

  /// No description provided for @clear.
  ///
  /// In cs, this message translates to:
  /// **'Smazat'**
  String get clear;

  /// No description provided for @bookTitle.
  ///
  /// In cs, this message translates to:
  /// **'Má knížka'**
  String get bookTitle;

  /// No description provided for @bookEmptyHint.
  ///
  /// In cs, this message translates to:
  /// **'Slož větu a ulož ji do knížky'**
  String get bookEmptyHint;

  /// No description provided for @zooTitle.
  ///
  /// In cs, this message translates to:
  /// **'Zvěřinec'**
  String get zooTitle;

  /// No description provided for @badgesTitle.
  ///
  /// In cs, this message translates to:
  /// **'Odznaky {earned}/{total}'**
  String badgesTitle(int earned, int total);

  /// No description provided for @badgeFirstSwype.
  ///
  /// In cs, this message translates to:
  /// **'První tah'**
  String get badgeFirstSwype;

  /// No description provided for @badgeFirstSwypeHow.
  ///
  /// In cs, this message translates to:
  /// **'První správný swype'**
  String get badgeFirstSwypeHow;

  /// No description provided for @badgeNoMistake.
  ///
  /// In cs, this message translates to:
  /// **'Bez chyby'**
  String get badgeNoMistake;

  /// No description provided for @badgeNoMistakeHow.
  ///
  /// In cs, this message translates to:
  /// **'Celá jednotka na samé tři hvězdy'**
  String get badgeNoMistakeHow;

  /// No description provided for @badgeExplorer.
  ///
  /// In cs, this message translates to:
  /// **'Objevitel'**
  String get badgeExplorer;

  /// No description provided for @badgeExplorerHow.
  ///
  /// In cs, this message translates to:
  /// **'První nálepka'**
  String get badgeExplorerHow;

  /// No description provided for @badgeCollectorHalf.
  ///
  /// In cs, this message translates to:
  /// **'Sběratel'**
  String get badgeCollectorHalf;

  /// No description provided for @badgeCollectorHalfHow.
  ///
  /// In cs, this message translates to:
  /// **'Polovina Zvěřince'**
  String get badgeCollectorHalfHow;

  /// No description provided for @badgeCollectorAll.
  ///
  /// In cs, this message translates to:
  /// **'Velký sběratel'**
  String get badgeCollectorAll;

  /// No description provided for @badgeCollectorAllHow.
  ///
  /// In cs, this message translates to:
  /// **'Celý Zvěřinec'**
  String get badgeCollectorAllHow;

  /// No description provided for @badgeNightOwl.
  ///
  /// In cs, this message translates to:
  /// **'Noční sova'**
  String get badgeNightOwl;

  /// No description provided for @badgeNightOwlHow.
  ///
  /// In cs, this message translates to:
  /// **'Hrálo v noci'**
  String get badgeNightOwlHow;

  /// No description provided for @badgeEarlyBird.
  ///
  /// In cs, this message translates to:
  /// **'Ranní ptáče'**
  String get badgeEarlyBird;

  /// No description provided for @badgeEarlyBirdHow.
  ///
  /// In cs, this message translates to:
  /// **'Hrálo ráno'**
  String get badgeEarlyBirdHow;

  /// No description provided for @badgeFourSeasons.
  ///
  /// In cs, this message translates to:
  /// **'Čtyři roční období'**
  String get badgeFourSeasons;

  /// No description provided for @badgeFourSeasonsHow.
  ///
  /// In cs, this message translates to:
  /// **'Hrálo v každém období'**
  String get badgeFourSeasonsHow;

  /// No description provided for @badgeWordsmith10.
  ///
  /// In cs, this message translates to:
  /// **'Slovíčkář'**
  String get badgeWordsmith10;

  /// No description provided for @badgeWordsmith10How.
  ///
  /// In cs, this message translates to:
  /// **'10 slov v batohu'**
  String get badgeWordsmith10How;

  /// No description provided for @badgeWordsmith25.
  ///
  /// In cs, this message translates to:
  /// **'Velký slovíčkář'**
  String get badgeWordsmith25;

  /// No description provided for @badgeWordsmith25How.
  ///
  /// In cs, this message translates to:
  /// **'25 slov v batohu'**
  String get badgeWordsmith25How;

  /// No description provided for @badgeWordsmith50.
  ///
  /// In cs, this message translates to:
  /// **'Mistr slov'**
  String get badgeWordsmith50;

  /// No description provided for @badgeWordsmith50How.
  ///
  /// In cs, this message translates to:
  /// **'50 slov v batohu'**
  String get badgeWordsmith50How;

  /// No description provided for @badgePoet.
  ///
  /// In cs, this message translates to:
  /// **'Básník'**
  String get badgePoet;

  /// No description provided for @badgePoetHow.
  ///
  /// In cs, this message translates to:
  /// **'10 vět v Mé knížce'**
  String get badgePoetHow;

  /// No description provided for @badgeListener.
  ///
  /// In cs, this message translates to:
  /// **'Posluchač'**
  String get badgeListener;

  /// No description provided for @badgeListenerHow.
  ///
  /// In cs, this message translates to:
  /// **'10 poslechových kol na tři hvězdy'**
  String get badgeListenerHow;

  /// No description provided for @badgePersistent.
  ///
  /// In cs, this message translates to:
  /// **'Vytrvalec'**
  String get badgePersistent;

  /// No description provided for @badgePersistentHow.
  ///
  /// In cs, this message translates to:
  /// **'7 hracích dnů'**
  String get badgePersistentHow;

  /// No description provided for @parentTitle.
  ///
  /// In cs, this message translates to:
  /// **'Pro rodiče'**
  String get parentTitle;

  /// No description provided for @gateQuestion.
  ///
  /// In cs, this message translates to:
  /// **'Kolik je {a} × {b}?'**
  String gateQuestion(int a, int b);

  /// No description provided for @backToGame.
  ///
  /// In cs, this message translates to:
  /// **'Zpět ke hře'**
  String get backToGame;

  /// No description provided for @sectionOverview.
  ///
  /// In cs, this message translates to:
  /// **'Přehled'**
  String get sectionOverview;

  /// No description provided for @sectionLetters.
  ///
  /// In cs, this message translates to:
  /// **'Písmena'**
  String get sectionLetters;

  /// No description provided for @sectionTips.
  ///
  /// In cs, this message translates to:
  /// **'Doporučení pro doma'**
  String get sectionTips;

  /// No description provided for @sectionMethod.
  ///
  /// In cs, this message translates to:
  /// **'Jak appka učí'**
  String get sectionMethod;

  /// No description provided for @sectionSettings.
  ///
  /// In cs, this message translates to:
  /// **'Nastavení'**
  String get sectionSettings;

  /// No description provided for @statProfile.
  ///
  /// In cs, this message translates to:
  /// **'profil'**
  String get statProfile;

  /// No description provided for @statPlayDays.
  ///
  /// In cs, this message translates to:
  /// **'hracích dnů'**
  String get statPlayDays;

  /// No description provided for @statLessons.
  ///
  /// In cs, this message translates to:
  /// **'lekcí'**
  String get statLessons;

  /// No description provided for @statStars.
  ///
  /// In cs, this message translates to:
  /// **'hvězd'**
  String get statStars;

  /// No description provided for @statWords.
  ///
  /// In cs, this message translates to:
  /// **'slov v batohu'**
  String get statWords;

  /// No description provided for @statSentences.
  ///
  /// In cs, this message translates to:
  /// **'vět v Mé knížce'**
  String get statSentences;

  /// No description provided for @statBadges.
  ///
  /// In cs, this message translates to:
  /// **'odznaků'**
  String get statBadges;

  /// No description provided for @lettersLegend.
  ///
  /// In cs, this message translates to:
  /// **'🟢 zvládnuté · 🟡 procvičuje · ⚪ ještě nepotkalo'**
  String get lettersLegend;

  /// No description provided for @troubleWords.
  ///
  /// In cs, this message translates to:
  /// **'Slova s {letter}, která se pletou: {words}'**
  String troubleWords(String letter, String words);

  /// No description provided for @tipNoData.
  ///
  /// In cs, this message translates to:
  /// **'Zatím není co procvičovat — po pár lekcích se tu objeví tipy.'**
  String get tipNoData;

  /// No description provided for @tipWeakest.
  ///
  /// In cs, this message translates to:
  /// **'Nejslabší slova: {words}. Zkuste je doma vytleskat po slabikách a hledat, co jimi začíná.'**
  String tipWeakest(String words);

  /// No description provided for @tipLetter.
  ///
  /// In cs, this message translates to:
  /// **'Písmeno {letter} ještě sedá: hledejte spolu doma věci, které začínají na {letter}.'**
  String tipLetter(String letter);

  /// No description provided for @tipLongPress.
  ///
  /// In cs, this message translates to:
  /// **'Dlouhý stisk lekce na mapě ukáže, co se v ní procvičuje a proč.'**
  String get tipLongPress;

  /// No description provided for @methodLabel.
  ///
  /// In cs, this message translates to:
  /// **'Metoda: {method}'**
  String methodLabel(String method);

  /// No description provided for @methodText.
  ///
  /// In cs, this message translates to:
  /// **'Dítě přejíždí prstem po písmenech v pořadí, jak slabiku nebo slovo slyší. Nejdřív otevřené slabiky (MA, TA), pak celá slova, poslechová kola bez textu, doplňovačky a opakování nejslabších slov. Chyba nikdy neblokuje postup — karta se jen zatřese a napoví. Naučená slova dítě hned použije ve větě (builder vět) a může si je uložit do Mé knížky.'**
  String get methodText;

  /// No description provided for @settingSounds.
  ///
  /// In cs, this message translates to:
  /// **'Zvuky'**
  String get settingSounds;

  /// No description provided for @settingAmbient.
  ///
  /// In cs, this message translates to:
  /// **'Zvuky světa'**
  String get settingAmbient;

  /// No description provided for @settingMusic.
  ///
  /// In cs, this message translates to:
  /// **'Hudba'**
  String get settingMusic;

  /// No description provided for @settingLeftHanded.
  ///
  /// In cs, this message translates to:
  /// **'Levák (zrcadlená klávesnice)'**
  String get settingLeftHanded;

  /// No description provided for @settingDyslexiaFont.
  ///
  /// In cs, this message translates to:
  /// **'Písmo pro dyslektiky (OpenDyslexic)'**
  String get settingDyslexiaFont;

  /// No description provided for @settingSeason.
  ///
  /// In cs, this message translates to:
  /// **'Roční období na mapě'**
  String get settingSeason;

  /// No description provided for @seasonAuto.
  ///
  /// In cs, this message translates to:
  /// **'podle kalendáře'**
  String get seasonAuto;

  /// No description provided for @seasonSpring.
  ///
  /// In cs, this message translates to:
  /// **'jaro'**
  String get seasonSpring;

  /// No description provided for @seasonSummer.
  ///
  /// In cs, this message translates to:
  /// **'léto'**
  String get seasonSummer;

  /// No description provided for @seasonAutumn.
  ///
  /// In cs, this message translates to:
  /// **'podzim'**
  String get seasonAutumn;

  /// No description provided for @seasonWinter.
  ///
  /// In cs, this message translates to:
  /// **'zima'**
  String get seasonWinter;

  /// No description provided for @settingTimeLimit.
  ///
  /// In cs, this message translates to:
  /// **'Časový limit hraní za den'**
  String get settingTimeLimit;

  /// No description provided for @noLimit.
  ///
  /// In cs, this message translates to:
  /// **'bez limitu'**
  String get noLimit;

  /// No description provided for @minutes.
  ///
  /// In cs, this message translates to:
  /// **'{n} min'**
  String minutes(int n);

  /// No description provided for @playedToday.
  ///
  /// In cs, this message translates to:
  /// **'Dnes odehráno {played} min'**
  String playedToday(int played);

  /// No description provided for @playedTodayOf.
  ///
  /// In cs, this message translates to:
  /// **'Dnes odehráno {played} z {limit} min'**
  String playedTodayOf(int played, int limit);

  /// No description provided for @guideAsleep.
  ///
  /// In cs, this message translates to:
  /// **' — průvodce už spí'**
  String get guideAsleep;

  /// No description provided for @extendToday.
  ///
  /// In cs, this message translates to:
  /// **'Prodloužit dnešek o {n} min'**
  String extendToday(int n);

  /// No description provided for @profilesTitle.
  ///
  /// In cs, this message translates to:
  /// **'Profily'**
  String get profilesTitle;

  /// No description provided for @deleteProfileTitle.
  ///
  /// In cs, this message translates to:
  /// **'Smazat profil {name}?'**
  String deleteProfileTitle(String name);

  /// No description provided for @deleteProfileBody.
  ///
  /// In cs, this message translates to:
  /// **'Smaže se i celý postup, nálepky a knížka. Nejde to vrátit.'**
  String get deleteProfileBody;

  /// No description provided for @cancel.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In cs, this message translates to:
  /// **'Smazat'**
  String get delete;

  /// No description provided for @statMinutesToday.
  ///
  /// In cs, this message translates to:
  /// **'minut dnes'**
  String get statMinutesToday;

  /// No description provided for @statMinutesWeek.
  ///
  /// In cs, this message translates to:
  /// **'minut tento týden'**
  String get statMinutesWeek;

  /// No description provided for @letterMastered.
  ///
  /// In cs, this message translates to:
  /// **'zvládnuté'**
  String get letterMastered;

  /// No description provided for @letterPracticing.
  ///
  /// In cs, this message translates to:
  /// **'procvičuje'**
  String get letterPracticing;

  /// No description provided for @letterUnseen.
  ///
  /// In cs, this message translates to:
  /// **'ještě nepotkalo'**
  String get letterUnseen;

  /// No description provided for @typeHunt.
  ///
  /// In cs, this message translates to:
  /// **'HLÁSKA'**
  String get typeHunt;

  /// No description provided for @typeJoin.
  ///
  /// In cs, this message translates to:
  /// **'SLABIKY'**
  String get typeJoin;

  /// No description provided for @typeRhyme.
  ///
  /// In cs, this message translates to:
  /// **'RÝM'**
  String get typeRhyme;

  /// No description provided for @promptHunt.
  ///
  /// In cs, this message translates to:
  /// **'Které písmenko slyšíš? Ťukni na něj'**
  String get promptHunt;

  /// No description provided for @promptJoin.
  ///
  /// In cs, this message translates to:
  /// **'Spoj slabiky — přejeď celé slovo'**
  String get promptJoin;

  /// No description provided for @promptRhyme.
  ///
  /// In cs, this message translates to:
  /// **'Co se rýmuje? Ťukni na obrázek'**
  String get promptRhyme;

  /// No description provided for @expeditionTitle.
  ///
  /// In cs, this message translates to:
  /// **'Výprava za opakováním'**
  String get expeditionTitle;

  /// No description provided for @badgeExpedition.
  ///
  /// In cs, this message translates to:
  /// **'Výpravník'**
  String get badgeExpedition;

  /// No description provided for @badgeExpeditionHow.
  ///
  /// In cs, this message translates to:
  /// **'První týdenní výprava za opakováním'**
  String get badgeExpeditionHow;

  /// No description provided for @seasonStickersTitle.
  ///
  /// In cs, this message translates to:
  /// **'Nálepky ročních období'**
  String get seasonStickersTitle;

  /// No description provided for @mapLoadFailed.
  ///
  /// In cs, this message translates to:
  /// **'Mapu se nepodařilo načíst'**
  String get mapLoadFailed;

  /// No description provided for @retry.
  ///
  /// In cs, this message translates to:
  /// **'Zkusit znovu'**
  String get retry;

  /// No description provided for @vocativeLabel.
  ///
  /// In cs, this message translates to:
  /// **'Oslovení v češtině (5. pád)'**
  String get vocativeLabel;

  /// No description provided for @vocativeHint.
  ///
  /// In cs, this message translates to:
  /// **'např. Lauro'**
  String get vocativeHint;

  /// No description provided for @guideTitle.
  ///
  /// In cs, this message translates to:
  /// **'Tvůj průvodce'**
  String get guideTitle;

  /// No description provided for @petPlay.
  ///
  /// In cs, this message translates to:
  /// **'Pojď si hrát'**
  String get petPlay;

  /// No description provided for @badgeHost.
  ///
  /// In cs, this message translates to:
  /// **'Hostitel'**
  String get badgeHost;

  /// No description provided for @badgeHostHow.
  ///
  /// In cs, this message translates to:
  /// **'10 dárků zvířátkům'**
  String get badgeHostHow;

  /// No description provided for @badgeCuddler.
  ///
  /// In cs, this message translates to:
  /// **'Mazlík'**
  String get badgeCuddler;

  /// No description provided for @badgeCuddlerHow.
  ///
  /// In cs, this message translates to:
  /// **'Pohladil(a) 5 zvířátek'**
  String get badgeCuddlerHow;

  /// No description provided for @badgeWishMaker.
  ///
  /// In cs, this message translates to:
  /// **'Splněné přání'**
  String get badgeWishMaker;

  /// No description provided for @badgeWishMakerHow.
  ///
  /// In cs, this message translates to:
  /// **'10 splněných přání'**
  String get badgeWishMakerHow;

  /// No description provided for @badgeFriendOfAll.
  ///
  /// In cs, this message translates to:
  /// **'Kamarád všech'**
  String get badgeFriendOfAll;

  /// No description provided for @badgeFriendOfAllHow.
  ///
  /// In cs, this message translates to:
  /// **'Každé zvířátko dostalo dárek'**
  String get badgeFriendOfAllHow;

  /// No description provided for @settingPetRounds.
  ///
  /// In cs, this message translates to:
  /// **'Dárky zvířátkům: nejdřív napsat slovo'**
  String get settingPetRounds;

  /// No description provided for @petBowlFood.
  ///
  /// In cs, this message translates to:
  /// **'miska'**
  String get petBowlFood;

  /// No description provided for @petBowlWater.
  ///
  /// In cs, this message translates to:
  /// **'voda'**
  String get petBowlWater;

  /// No description provided for @storeIslandA.
  ///
  /// In cs, this message translates to:
  /// **'Ostrov písmenek'**
  String get storeIslandA;

  /// No description provided for @storeIslandB.
  ///
  /// In cs, this message translates to:
  /// **'Ostrov slov'**
  String get storeIslandB;

  /// No description provided for @storeIslandC.
  ///
  /// In cs, this message translates to:
  /// **'Ostrov vět'**
  String get storeIslandC;

  /// No description provided for @storeProductIsland.
  ///
  /// In cs, this message translates to:
  /// **'{island} – {language}'**
  String storeProductIsland(String island, String language);

  /// No description provided for @storeProductIslandDesc.
  ///
  /// In cs, this message translates to:
  /// **'Nové jednotky, nálepky a obyvatelé světa zvířátka. Jazyk: {language}.'**
  String storeProductIslandDesc(String language);

  /// No description provided for @storeProductLanguage.
  ///
  /// In cs, this message translates to:
  /// **'Další jazyk – {language}'**
  String storeProductLanguage(String language);

  /// No description provided for @storeProductLanguageDesc.
  ///
  /// In cs, this message translates to:
  /// **'{island} v dalším jazyce: {language}.'**
  String storeProductLanguageDesc(String island, String language);

  /// No description provided for @storeProductBundle.
  ///
  /// In cs, this message translates to:
  /// **'Vše napořád'**
  String get storeProductBundle;

  /// No description provided for @storeProductBundleDesc.
  ///
  /// In cs, this message translates to:
  /// **'Všechny ostrovy a jazyky, i ty, které teprve přibudou.'**
  String get storeProductBundleDesc;

  /// No description provided for @storeProductParent.
  ///
  /// In cs, this message translates to:
  /// **'Balíček pro rodiče'**
  String get storeProductParent;

  /// No description provided for @storeProductParentDesc.
  ///
  /// In cs, this message translates to:
  /// **'Pracovní listy, tisk Mé knížky, týdenní přehled a přenos postupu.'**
  String get storeProductParentDesc;

  /// No description provided for @storeStateFree.
  ///
  /// In cs, this message translates to:
  /// **'zdarma'**
  String get storeStateFree;

  /// No description provided for @storeStateOwned.
  ///
  /// In cs, this message translates to:
  /// **'máte'**
  String get storeStateOwned;

  /// No description provided for @storeBuy.
  ///
  /// In cs, this message translates to:
  /// **'Koupit za {price}'**
  String storeBuy(String price);

  /// No description provided for @storeRestore.
  ///
  /// In cs, this message translates to:
  /// **'Obnovit nákupy'**
  String get storeRestore;

  /// No description provided for @storeDebugTitle.
  ///
  /// In cs, this message translates to:
  /// **'Obchod (ladění)'**
  String get storeDebugTitle;

  /// No description provided for @storeDebugEnable.
  ///
  /// In cs, this message translates to:
  /// **'Simulovat zapnutý obchod'**
  String get storeDebugEnable;

  /// No description provided for @storeDebugForget.
  ///
  /// In cs, this message translates to:
  /// **'Zapomenout nákupy'**
  String get storeDebugForget;

  /// No description provided for @homeLanguageLabel.
  ///
  /// In cs, this message translates to:
  /// **'Jazyk rodiny (menu a nápověda)'**
  String get homeLanguageLabel;

  /// No description provided for @homeLanguageSame.
  ///
  /// In cs, this message translates to:
  /// **'Stejný jako jazyk hry'**
  String get homeLanguageSame;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'cs',
        'de',
        'en',
        'es',
        'fr',
        'it',
        'ja',
        'pt',
        'ru',
        'uk',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs':
      return AppLocalizationsCs();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
