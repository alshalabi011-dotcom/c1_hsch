// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'C1 Hochschule';

  @override
  String get sectionsTitle => 'Abschnitte';

  @override
  String get modelsTitle => 'Modelle';

  @override
  String blankCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get translateBtn => 'Text übersetzen';

  @override
  String get hideTranslateBtn => 'Übersetzung ausblenden';

  @override
  String sheetTitle(int n) {
    return 'Lücke $n — Wähle den Satz';
  }

  @override
  String get feedbackCorrect => '✓ Richtig!';

  @override
  String feedbackWrong(String key) {
    return '✗ Richtige Antwort: $key';
  }

  @override
  String get resultsTitle => 'Ergebnis';

  @override
  String get correctAnswers => 'Richtige Antworten';

  @override
  String get retryBtn => 'Nochmal versuchen';

  @override
  String get lockedSection => 'Noch nicht verfügbar';

  @override
  String get newBadge => 'Neu';
}
