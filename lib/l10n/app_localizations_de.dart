// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'C1 Hsch';

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

  @override
  String get appTitle => 'C1 Hsch App';

  @override
  String get loginButton => 'Einloggen';

  @override
  String get welcomeMessage => 'Willkommen in der App!';

  @override
  String get academicSections => 'Akademische Bereiche';

  @override
  String get sectionsSubtitle =>
      'Wähle einen akademischen Bereich aus, um deine Lernreise zu beginnen.';

  @override
  String get welcomeTitle => 'Willkommen bei der C1 Hsch App';

  @override
  String get welcomeSubtitle =>
      'Bereite dich mit akademischen Lesetexten auf die C1-Prüfung vor.';

  @override
  String get startButton => 'Starten';

  @override
  String get lerneinheitenTitle => 'Lerneinheiten';

  @override
  String get modelsSubtitle =>
      'Bereite dich auf diesen Bereich vor, indem du das Lesen und Verstehen der folgenden akademischen Texte übst.';

  @override
  String get academicCourse => 'Akademischer Kurs';

  @override
  String get c1Level => 'C1 Niveau';

  @override
  String progressValue(int percentage) {
    return 'Fortschritt: $percentage%';
  }

  @override
  String get homeLink => 'Startseite';

  @override
  String get myCoursesLink => 'Meine Kurse';

  @override
  String get grammarLink => 'Grammatik';

  @override
  String get dictionaryLink => 'Wörterbuch';

  @override
  String get settingsLink => 'Einstellungen';

  @override
  String get breakdownTitle => 'Details';

  @override
  String get instructionsTitle => 'Anleitung';

  @override
  String get instructionsBody =>
      'Klicke auf die Lücken im Text, um die verfügbaren Optionen anzuzeigen und die richtige Antwort auszuwählen.';

  @override
  String get verstandenBtn => 'Verstanden';

  @override
  String get resultsScreenTitle => 'Ergebnis';

  @override
  String sectionNumber(int number) {
    return 'Abschnitt $number';
  }
}
