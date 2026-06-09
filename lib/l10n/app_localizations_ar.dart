// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'C1 Hsch';

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

  @override
  String get appTitle => 'C1 Hsch';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get welcomeMessage => 'مرحباً بك في التطبيق!';

  @override
  String get academicSections => 'الأقسام الدراسية';

  @override
  String get sectionsSubtitle =>
      'اختر قسماً أكاديمياً لتبدأ رحلة التعلم والتدريب.';

  @override
  String get welcomeTitle => 'مرحباً بكم في تطبيق C1 Hsch';

  @override
  String get welcomeSubtitle =>
      'استعد لامتحان C1 من خلال نصوص القراءة الأكاديمية.';

  @override
  String get startButton => 'ابدأ';

  @override
  String get lerneinheitenTitle => 'الوحدات الدراسية';

  @override
  String get modelsSubtitle =>
      'استعد لهذا القسم من خلال التدرب على قراءة وفهم النصوص الأكاديمية التالية.';

  @override
  String get academicCourse => 'مساق أكاديمي';

  @override
  String get c1Level => 'مستوى C1';

  @override
  String progressValue(int percentage) {
    return 'التقدم: $percentage%';
  }

  @override
  String get homeLink => 'الرئيسية';

  @override
  String get myCoursesLink => 'دوراتي';

  @override
  String get grammarLink => 'القواعد';

  @override
  String get dictionaryLink => 'القاموس';

  @override
  String get settingsLink => 'الإعدادات';

  @override
  String get breakdownTitle => 'التفاصيل';

  @override
  String get instructionsTitle => 'تعليمات';

  @override
  String get instructionsBody =>
      'اضغط على الفراغات الموجودة داخل النص لإظهار الخيارات المتاحة واختيار الإجابة الصحيحة.';

  @override
  String get verstandenBtn => 'فهمت';

  @override
  String get resultsScreenTitle => 'النتيجة';

  @override
  String sectionNumber(int number) {
    return 'القسم $number';
  }

  @override
  String get updateTitle => 'تحديث جديد متوفر! 🚀';

  @override
  String newVersionLabel(String version) {
    return 'النسخة الجديدة: $version';
  }

  @override
  String get whatsNew => 'ما الجديد في هذا التحديث:';

  @override
  String get updateNowBtn => 'تحديث الآن';

  @override
  String get laterBtn => 'لاحقاً';

  @override
  String get downloadingUpdate => 'جاري تحميل وتثبيت التحديث...';
}
