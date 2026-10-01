import 'package:flutter/widgets.dart';

import '../data/lessons.dart';
import '../l10n/app_localizations.dart';
import '../services/achievement_service.dart';
import '../world/world_clock.dart';

export '../l10n/app_localizations.dart';

/// Jazyk UI = jazyk packu, který dítě hraje (německé dítě vidí německé
/// menu). HomeShell ho mění spolu s jazykem; MaterialApp ho poslouchá.
class AppLanguage extends ValueNotifier<Language> {
  AppLanguage._() : super(Language.en);
  static final AppLanguage instance = AppLanguage._();

  Locale get locale => Locale(value.name);
}

extension L10nContext on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this);
}

/// Název a podmínka odznaku v jazyce UI.
extension GameBadgeL10n on GameBadge {
  String title(AppLocalizations l) => switch (this) {
        GameBadge.firstSwype => l.badgeFirstSwype,
        GameBadge.noMistake => l.badgeNoMistake,
        GameBadge.explorer => l.badgeExplorer,
        GameBadge.collectorHalf => l.badgeCollectorHalf,
        GameBadge.collectorAll => l.badgeCollectorAll,
        GameBadge.nightOwl => l.badgeNightOwl,
        GameBadge.earlyBird => l.badgeEarlyBird,
        GameBadge.fourSeasons => l.badgeFourSeasons,
        GameBadge.wordsmith10 => l.badgeWordsmith10,
        GameBadge.wordsmith25 => l.badgeWordsmith25,
        GameBadge.wordsmith50 => l.badgeWordsmith50,
        GameBadge.poet => l.badgePoet,
        GameBadge.listener => l.badgeListener,
        GameBadge.persistent => l.badgePersistent,
      };

  String condition(AppLocalizations l) => switch (this) {
        GameBadge.firstSwype => l.badgeFirstSwypeHow,
        GameBadge.noMistake => l.badgeNoMistakeHow,
        GameBadge.explorer => l.badgeExplorerHow,
        GameBadge.collectorHalf => l.badgeCollectorHalfHow,
        GameBadge.collectorAll => l.badgeCollectorAllHow,
        GameBadge.nightOwl => l.badgeNightOwlHow,
        GameBadge.earlyBird => l.badgeEarlyBirdHow,
        GameBadge.fourSeasons => l.badgeFourSeasonsHow,
        GameBadge.wordsmith10 => l.badgeWordsmith10How,
        GameBadge.wordsmith25 => l.badgeWordsmith25How,
        GameBadge.wordsmith50 => l.badgeWordsmith50How,
        GameBadge.poet => l.badgePoetHow,
        GameBadge.listener => l.badgeListenerHow,
        GameBadge.persistent => l.badgePersistentHow,
      };
}

extension SeasonL10n on Season {
  String label(AppLocalizations l) => switch (this) {
        Season.spring => l.seasonSpring,
        Season.summer => l.seasonSummer,
        Season.autumn => l.seasonAutumn,
        Season.winter => l.seasonWinter,
      };
}
