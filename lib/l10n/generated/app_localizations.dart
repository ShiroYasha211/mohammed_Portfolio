import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('en')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Mohammed Alhemyari - Portfolio'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @navSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get navSkills;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navCertificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get navCertificates;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get changeLanguage;

  /// No description provided for @heroHello.
  ///
  /// In en, this message translates to:
  /// **'Hello, I\'m'**
  String get heroHello;

  /// No description provided for @heroName.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Alhemyari'**
  String get heroName;

  /// No description provided for @heroRole1.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get heroRole1;

  /// No description provided for @heroRole2.
  ///
  /// In en, this message translates to:
  /// **'Mobile App Developer'**
  String get heroRole2;

  /// No description provided for @heroRole3.
  ///
  /// In en, this message translates to:
  /// **'Web Developer'**
  String get heroRole3;

  /// No description provided for @heroDescription.
  ///
  /// In en, this message translates to:
  /// **'Bachelor in Computer Information Systems, passionate about developing mobile and web applications using Flutter. I have practical experience in building diverse applications like forums, delivery systems, portfolios, and dashboards etc...'**
  String get heroDescription;

  /// No description provided for @scrollDown.
  ///
  /// In en, this message translates to:
  /// **'Scroll Down'**
  String get scrollDown;

  /// No description provided for @downloadCV.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get downloadCV;

  /// No description provided for @contactMe.
  ///
  /// In en, this message translates to:
  /// **'Contact Me'**
  String get contactMe;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutTitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get to know more about me and my journey'**
  String get aboutSubtitle;

  /// No description provided for @myStory.
  ///
  /// In en, this message translates to:
  /// **'My Story'**
  String get myStory;

  /// No description provided for @aboutParagraph1.
  ///
  /// In en, this message translates to:
  /// **'I am a passionate software developer with a Bachelor\'s degree in Computer Information Systems and several years of hands-on programming experience. I specialize in building modern, high-performance Flutter applications that deliver exceptional user experiences and real-world impact.'**
  String get aboutParagraph1;

  /// No description provided for @aboutParagraph2.
  ///
  /// In en, this message translates to:
  /// **'Throughout my journey, I have developed a wide range of applications — including forum platforms, food delivery systems, e-commerce dashboards, portfolio websites, and online store apps. My focus is on crafting seamless, user-centric experiences that solve practical business challenges across mobile and web platforms.'**
  String get aboutParagraph2;

  /// No description provided for @aboutParagraph3.
  ///
  /// In en, this message translates to:
  /// **'As a freelance developer, I\'m driven by the challenge of turning complex ideas into elegant, fully functional solutions. My full-stack expertise spans from designing intuitive UI/UX with Flutter to building robust backends using Laravel, and managing APIs and databases for scalable, maintainable performance.'**
  String get aboutParagraph3;

  /// No description provided for @whatIDo.
  ///
  /// In en, this message translates to:
  /// **'What I Do'**
  String get whatIDo;

  /// No description provided for @uiuxDesign.
  ///
  /// In en, this message translates to:
  /// **'UI/UX Design with Flutter'**
  String get uiuxDesign;

  /// No description provided for @backendIntegration.
  ///
  /// In en, this message translates to:
  /// **'Backend Integration'**
  String get backendIntegration;

  /// No description provided for @apiDevelopment.
  ///
  /// In en, this message translates to:
  /// **'API Development'**
  String get apiDevelopment;

  /// No description provided for @databaseManagement.
  ///
  /// In en, this message translates to:
  /// **'Database Management'**
  String get databaseManagement;

  /// No description provided for @crossPlatformDev.
  ///
  /// In en, this message translates to:
  /// **'Cross-platform Development'**
  String get crossPlatformDev;

  /// No description provided for @yearsExperience.
  ///
  /// In en, this message translates to:
  /// **'Years Experience'**
  String get yearsExperience;

  /// No description provided for @projectsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Projects Completed'**
  String get projectsCompleted;

  /// No description provided for @yearsInFlutter.
  ///
  /// In en, this message translates to:
  /// **'Years in Flutter'**
  String get yearsInFlutter;

  /// No description provided for @toolsFrameworks.
  ///
  /// In en, this message translates to:
  /// **'Tools & Frameworks'**
  String get toolsFrameworks;

  /// No description provided for @flutterDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get flutterDeveloper;

  /// No description provided for @freelancer.
  ///
  /// In en, this message translates to:
  /// **'Freelancer'**
  String get freelancer;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Arabic, English'**
  String get languages;

  /// No description provided for @skillsTitle.
  ///
  /// In en, this message translates to:
  /// **'Skills & Technologies'**
  String get skillsTitle;

  /// No description provided for @skillsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Technologies I work with and my proficiency levels'**
  String get skillsSubtitle;

  /// No description provided for @programmingLanguages.
  ///
  /// In en, this message translates to:
  /// **'Programming Languages'**
  String get programmingLanguages;

  /// No description provided for @frameworksTechnologies.
  ///
  /// In en, this message translates to:
  /// **'Frameworks & Technologies'**
  String get frameworksTechnologies;

  /// No description provided for @toolsDatabases.
  ///
  /// In en, this message translates to:
  /// **'Tools & Databases'**
  String get toolsDatabases;

  /// No description provided for @proficiency.
  ///
  /// In en, this message translates to:
  /// **'Proficiency'**
  String get proficiency;

  /// No description provided for @flutterDescription.
  ///
  /// In en, this message translates to:
  /// **'Cross-platform mobile & web development'**
  String get flutterDescription;

  /// No description provided for @laravelDescription.
  ///
  /// In en, this message translates to:
  /// **'Powerful backend framework for RESTful APIs'**
  String get laravelDescription;

  /// No description provided for @firebaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Real-time database & authentication'**
  String get firebaseDescription;

  /// No description provided for @supabaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Open-source Firebase alternative'**
  String get supabaseDescription;

  /// No description provided for @dartExperience.
  ///
  /// In en, this message translates to:
  /// **'2+ years'**
  String get dartExperience;

  /// No description provided for @jsExperience.
  ///
  /// In en, this message translates to:
  /// **'1+ years'**
  String get jsExperience;

  /// No description provided for @pythonExperience.
  ///
  /// In en, this message translates to:
  /// **'1+ years'**
  String get pythonExperience;

  /// No description provided for @cppExperience.
  ///
  /// In en, this message translates to:
  /// **'2+ years'**
  String get cppExperience;

  /// No description provided for @csharpExperience.
  ///
  /// In en, this message translates to:
  /// **'1+ years'**
  String get csharpExperience;

  /// No description provided for @phpExperience.
  ///
  /// In en, this message translates to:
  /// **'1+ years'**
  String get phpExperience;

  /// No description provided for @kotlinExperience.
  ///
  /// In en, this message translates to:
  /// **'Less than 1 year'**
  String get kotlinExperience;

  /// No description provided for @sqlExperience.
  ///
  /// In en, this message translates to:
  /// **'3+ years'**
  String get sqlExperience;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Projects'**
  String get projectsTitle;

  /// No description provided for @projectsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A showcase of my recent work and personal projects'**
  String get projectsSubtitle;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @mobileApp.
  ///
  /// In en, this message translates to:
  /// **'Mobile App'**
  String get mobileApp;

  /// No description provided for @webApp.
  ///
  /// In en, this message translates to:
  /// **'Web App'**
  String get webApp;

  /// No description provided for @backend.
  ///
  /// In en, this message translates to:
  /// **'Backend'**
  String get backend;

  /// No description provided for @app.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get app;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @liveDemo.
  ///
  /// In en, this message translates to:
  /// **'Live Demo'**
  String get liveDemo;

  /// No description provided for @technologies.
  ///
  /// In en, this message translates to:
  /// **'Technologies'**
  String get technologies;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @certificatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificates & Education'**
  String get certificatesTitle;

  /// No description provided for @certificatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'My professional certifications and educational achievements'**
  String get certificatesSubtitle;

  /// No description provided for @viewPDF.
  ///
  /// In en, this message translates to:
  /// **'View PDF'**
  String get viewPDF;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @programming.
  ///
  /// In en, this message translates to:
  /// **'Programming'**
  String get programming;

  /// No description provided for @design.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get design;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch'**
  String get contactTitle;

  /// No description provided for @contactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s discuss your project or just say hello!'**
  String get contactSubtitle;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @contactDescription.
  ///
  /// In en, this message translates to:
  /// **'Feel free to reach out through any of these channels'**
  String get contactDescription;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @sendMessageDescription.
  ///
  /// In en, this message translates to:
  /// **'Have a project in mind? Let\'s discuss it!'**
  String get sendMessageDescription;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your Name'**
  String get enterName;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email'**
  String get enterEmail;

  /// No description provided for @enterSubject.
  ///
  /// In en, this message translates to:
  /// **'Enter your Subject'**
  String get enterSubject;

  /// No description provided for @enterMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter your Message'**
  String get enterMessage;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @subjectRequired.
  ///
  /// In en, this message translates to:
  /// **'Subject is required'**
  String get subjectRequired;

  /// No description provided for @messageRequired.
  ///
  /// In en, this message translates to:
  /// **'Message is required'**
  String get messageRequired;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get validEmail;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @sendMessageButton.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessageButton;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @availabilityStatus.
  ///
  /// In en, this message translates to:
  /// **'Available for freelance work'**
  String get availabilityStatus;

  /// No description provided for @responseTime.
  ///
  /// In en, this message translates to:
  /// **'Within 24 hours'**
  String get responseTime;

  /// No description provided for @timeZone.
  ///
  /// In en, this message translates to:
  /// **'GMT+3 (Yemen)'**
  String get timeZone;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @linkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedin;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @copyRight.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Mohammed Alhemyari. All rights reserved.'**
  String get copyRight;

  /// No description provided for @builtWith.
  ///
  /// In en, this message translates to:
  /// **'Built using Flutter'**
  String get builtWith;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
