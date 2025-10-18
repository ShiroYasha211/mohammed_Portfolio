import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../constants/colors.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  final List<Map<String, dynamic>> _stats = [
    {
      'number': '5+',
      'label': 'yearsExperience'.tr(),
      'icon': Icons.code,
      'color': AppColors.primary,
    },
    {
      'number': '10+',
      'label': 'projectsCompleted'.tr(),
      'icon': Icons.laptop_mac,
      'color': AppColors.secondary,
    },
    {
      'number': '2+',
      'label': 'yearsInFlutter'.tr(),
      'icon': Icons.mobile_friendly,
      'color': AppColors.accent,
    },
    {
      'number': '5+',
      'label': 'toolsFrameworks'.tr(),
      'icon': Icons.settings,
      'color': AppColors.success,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_isVisible) {
      _isVisible = true;
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width < 1024;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3) {
          _startAnimation();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppTheme.sectionPadding,
          horizontal: isMobile
              ? 20
              : isTablet
                  ? 60
                  : 120,
        ),
        color: AppColors.background,
        child: Column(
          children: [
            _buildSectionHeader(),
            const SizedBox(height: 60),
            isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
            const SizedBox(height: 60),
            _buildStatsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Text(
            'aboutTitle'.tr(),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width < 768 ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 100,
            height: 4,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'aboutSubtitle'.tr(),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 40),
            _buildAboutContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildProfileCard(),
            ),
            const SizedBox(width: 60),
            Expanded(
              flex: 3,
              child: _buildAboutContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Image Placeholder
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: AppColors.primaryGradient,
              image: const DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'heroName'.tr(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Text(
              'flutterDeveloper'.tr(),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        _buildContactItem(Icons.email, 'samehing211@gmail.com'),
        const SizedBox(height: 10),
        _buildContactItem(Icons.phone, '+967773468708'),
        const SizedBox(height: 10),
        _buildContactItem(Icons.work, 'freelancer'.tr()),
        const SizedBox(height: 10),
        _buildContactItem(Icons.language, 'languages'.tr()),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'myStory'.tr(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        _buildParagraph(
          "aboutParagraph1".tr(),
        ),
        const SizedBox(height: 20),
        _buildParagraph(
          "aboutParagraph2".tr(),
        ),
        const SizedBox(height: 20),
        _buildParagraph(
          "aboutParagraph3".tr(),
        ),
        const SizedBox(height: 30),
        _buildSkillHighlights(),
      ],
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildSkillHighlights() {
    final highlights = [
      'uiuxDesign'.tr(),
      'backendIntegration'.tr(),
      'apiDevelopment'.tr(),
      'databaseManagement'.tr(),
      'crossPlatformDev'.tr(),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'whatIDo'.tr(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 15),
        ...highlights.map((highlight) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    highlight,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: MediaQuery.of(context).size.width < 768
          ? _buildMobileStats()
          : _buildDesktopStats(),
    );
  }

  Widget _buildMobileStats() {
    return Column(
      children: [
        for (int i = 0; i < _stats.length; i += 2) ...[
          Row(
            children: [
              Expanded(child: _buildStatCard(_stats[i])),
              if (i + 1 < _stats.length) ...[
                const SizedBox(width: 20),
                Expanded(child: _buildStatCard(_stats[i + 1])),
              ],
            ],
          ),
          if (i + 2 < _stats.length) const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildDesktopStats() {
    return Row(
      children: _stats.map((stat) {
        return Expanded(
          child: _buildStatCard(stat),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.5 + (_animationController.value * 0.5),
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: (stat['color'] as Color).withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  stat['icon'],
                  color: stat['color'],
                  size: 40,
                ),
                const SizedBox(height: 15),
                Text(
                  stat['number'],
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: stat['color'],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  stat['label'.tr()],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
