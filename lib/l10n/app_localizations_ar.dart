// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'C1 Hochschule';

  @override
  String get sectionsTitle => 'الأقسام';

  @override
  String get modelsTitle => 'النماذج';

  @override
  String blankCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get translateBtn => 'ترجمة النص والأجوبة';

  @override
  String get hideTranslateBtn => 'إخفاء الترجمة';

  @override
  String sheetTitle(int n) {
    return 'فراغ $n — اختر الجملة المناسبة';
  }

  @override
  String get feedbackCorrect => '✓ ممتاز! إجابة صحيحة';

  @override
  String feedbackWrong(String key) {
    return '✗ الجواب الصحيح: $key';
  }

  @override
  String get resultsTitle => 'النتيجة';

  @override
  String get correctAnswers => 'إجابات صحيحة';

  @override
  String get retryBtn => 'إعادة المحاولة';

  @override
  String get lockedSection => 'غير متاح بعد';

  @override
  String get newBadge => 'جديد';
}
