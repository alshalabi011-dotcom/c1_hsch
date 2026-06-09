import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ar'),
    Locale('de')
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'C1 Hsch'**
  String get appName;

  /// No description provided for @sectionsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأقسام'**
  String get sectionsTitle;

  /// No description provided for @modelsTitle.
  ///
  /// In ar, this message translates to:
  /// **'النماذج'**
  String get modelsTitle;

  /// No description provided for @blankCounter.
  ///
  /// In ar, this message translates to:
  /// **'{current} / {total}'**
  String blankCounter(int current, int total);

  /// No description provided for @translateBtn.
  ///
  /// In ar, this message translates to:
  /// **'ترجمة النص والأجوبة'**
  String get translateBtn;

  /// No description provided for @hideTranslateBtn.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء الترجمة'**
  String get hideTranslateBtn;

  /// No description provided for @sheetTitle.
  ///
  /// In ar, this message translates to:
  /// **'فراغ {n} — اختر الجملة المناسبة'**
  String sheetTitle(int n);

  /// No description provided for @feedbackCorrect.
  ///
  /// In ar, this message translates to:
  /// **'✓ ممتاز! إجابة صحيحة'**
  String get feedbackCorrect;

  /// No description provided for @feedbackWrong.
  ///
  /// In ar, this message translates to:
  /// **'✗ الجواب الصحيح: {key}'**
  String feedbackWrong(String key);

  /// No description provided for @resultsTitle.
  ///
  /// In ar, this message translates to:
  /// **'النتيجة'**
  String get resultsTitle;

  /// No description provided for @correctAnswers.
  ///
  /// In ar, this message translates to:
  /// **'إجابات صحيحة'**
  String get correctAnswers;

  /// No description provided for @retryBtn.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retryBtn;

  /// No description provided for @lockedSection.
  ///
  /// In ar, this message translates to:
  /// **'غير متاح بعد'**
  String get lockedSection;

  /// No description provided for @newBadge.
  ///
  /// In ar, this message translates to:
  /// **'جديد'**
  String get newBadge;

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'C1 Hsch'**
  String get appTitle;

  /// No description provided for @loginButton.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get loginButton;

  /// No description provided for @welcomeMessage.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك في التطبيق!'**
  String get welcomeMessage;

  /// No description provided for @academicSections.
  ///
  /// In ar, this message translates to:
  /// **'الأقسام الدراسية'**
  String get academicSections;

  /// No description provided for @sectionsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر قسماً أكاديمياً لتبدأ رحلة التعلم والتدريب.'**
  String get sectionsSubtitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بكم في تطبيق C1 Hsch'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'استعد لامتحان C1 من خلال نصوص القراءة الأكاديمية.'**
  String get welcomeSubtitle;

  /// No description provided for @startButton.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ'**
  String get startButton;

  /// No description provided for @lerneinheitenTitle.
  ///
  /// In ar, this message translates to:
  /// **'الوحدات الدراسية'**
  String get lerneinheitenTitle;

  /// No description provided for @modelsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'استعد لهذا القسم من خلال التدرب على قراءة وفهم النصوص الأكاديمية التالية.'**
  String get modelsSubtitle;

  /// No description provided for @academicCourse.
  ///
  /// In ar, this message translates to:
  /// **'مساق أكاديمي'**
  String get academicCourse;

  /// No description provided for @c1Level.
  ///
  /// In ar, this message translates to:
  /// **'مستوى C1'**
  String get c1Level;

  /// No description provided for @progressValue.
  ///
  /// In ar, this message translates to:
  /// **'التقدم: {percentage}%'**
  String progressValue(int percentage);

  /// No description provided for @homeLink.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get homeLink;

  /// No description provided for @myCoursesLink.
  ///
  /// In ar, this message translates to:
  /// **'دوراتي'**
  String get myCoursesLink;

  /// No description provided for @grammarLink.
  ///
  /// In ar, this message translates to:
  /// **'القواعد'**
  String get grammarLink;

  /// No description provided for @dictionaryLink.
  ///
  /// In ar, this message translates to:
  /// **'القاموس'**
  String get dictionaryLink;

  /// No description provided for @settingsLink.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settingsLink;

  /// No description provided for @breakdownTitle.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل'**
  String get breakdownTitle;

  /// No description provided for @instructionsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعليمات'**
  String get instructionsTitle;

  /// No description provided for @instructionsBody.
  ///
  /// In ar, this message translates to:
  /// **'اضغط على الفراغات الموجودة داخل النص لإظهار الخيارات المتاحة واختيار الإجابة الصحيحة.'**
  String get instructionsBody;

  /// No description provided for @verstandenBtn.
  ///
  /// In ar, this message translates to:
  /// **'فهمت'**
  String get verstandenBtn;

  /// No description provided for @resultsScreenTitle.
  ///
  /// In ar, this message translates to:
  /// **'النتيجة'**
  String get resultsScreenTitle;

  /// No description provided for @sectionNumber.
  ///
  /// In ar, this message translates to:
  /// **'القسم {number}'**
  String sectionNumber(int number);

  /// No description provided for @updateTitle.
  ///
  /// In ar, this message translates to:
  /// **'تحديث جديد متوفر! 🚀'**
  String get updateTitle;

  /// No description provided for @newVersionLabel.
  ///
  /// In ar, this message translates to:
  /// **'النسخة الجديدة: {version}'**
  String newVersionLabel(String version);

  /// No description provided for @whatsNew.
  ///
  /// In ar, this message translates to:
  /// **'ما الجديد في هذا التحديث:'**
  String get whatsNew;

  /// No description provided for @updateNowBtn.
  ///
  /// In ar, this message translates to:
  /// **'تحديث الآن'**
  String get updateNowBtn;

  /// No description provided for @laterBtn.
  ///
  /// In ar, this message translates to:
  /// **'لاحقاً'**
  String get laterBtn;

  /// No description provided for @downloadingUpdate.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل وتثبيت التحديث...'**
  String get downloadingUpdate;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
