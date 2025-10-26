import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/certificates_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/navbar.dart';
import 'constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Mohammed Alhemyari - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: context.locale.languageCode == 'ar' ? 'Cairo' : 'Poppins',
        // إزالة platform لإصلاح مشاكل التخطيط
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'certificates': GlobalKey(),
    'contact': GlobalKey(),
  };
  bool _showFAB = false;

  void scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key != null && key.currentContext != null) {
      // تحسين التمرير وإضافة تأخير بسيط
      Future.delayed(const Duration(milliseconds: 100), () {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          alignment: 0.05, // تقليل alignment
        );
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _handleScroll() {
    final scrollPosition = _scrollController.position;

    if (scrollPosition.pixels > 300 && !_showFAB) {
      setState(() {
        _showFAB = true;
      });
    } else if (scrollPosition.pixels <= 300 && _showFAB) {
      setState(() {
        _showFAB = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // إضافة listener بعد تأخير بسيط
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_handleScroll);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomNavBar(
              onNavigate: scrollToSection,
              sectionKeys: _sectionKeys,
              scrollController: _scrollController,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  HeroSection(
                    key: _sectionKeys['home'],
                    onContactPressed: () => scrollToSection("contact"),
                  ),
                  AboutSection(key: _sectionKeys['about']),
                  SkillsSection(key: _sectionKeys['skills']),
                  ProjectsSection(key: _sectionKeys['projects']),
                  CertificatesSection(key: _sectionKeys['certificates']),
                  ContactSection(key: _sectionKeys['contact']),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showFAB
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              mini: true,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
