import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      'number': '4+',
      'label': 'Years Experience',
      'icon': Icons.code,
      'color': AppColors.primary,
    },
    {
      'number': '15+',
      'label': 'Projects Completed',
      'icon': Icons.laptop_mac,
      'color': AppColors.secondary,
    },
    {
      'number': '2+',
      'label': 'Years with Flutter',
      'icon': Icons.mobile_friendly,
      'color': AppColors.accent,
    },
    {
      'number': '3+',
      'label': 'Technologies Mastered',
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
          horizontal: isMobile ? 20 : isTablet ? 60 : 120,
        ),
        color: AppColors.background,
        child: Column(
          children: [
            _buildSectionHeader(),
            const SizedBox(height: 60),
            isMobile 
              ? _buildMobileLayout()
              : _buildDesktopLayout(),
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
            'About Me',
            style: GoogleFonts.poppins(
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
            'Get to know more about me and my journey',
            style: GoogleFonts.poppins(
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
              // TODO: Replace with actual image
              // image: DecorationImage(
              //   image: AssetImage('assets/images/profile_about.jpg'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: const Icon(
              Icons.person,
              size: 100,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Mohammed Alhemyari',
            style: GoogleFonts.poppins(
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
              'Flutter Developer',
              style: GoogleFonts.poppins(
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
        _buildContactItem(Icons.work, 'Freelancer'),
        const SizedBox(height: 10),
        _buildContactItem(Icons.language, 'Arabic, English'),
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
            style: GoogleFonts.poppins(
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
          'My Story',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        _buildParagraph(
          'I am a passionate software developer with a Bachelor\'s degree in Computer Information Systems. My journey in programming started 4 years ago, and I have been specializing in Flutter development for the past 2 years.',
        ),
        const SizedBox(height: 20),
        _buildParagraph(
          'I have practical experience in building diverse applications including forums, food delivery systems, and e-commerce dashboards. My expertise spans across mobile and web development, with a strong focus on creating user-friendly and efficient applications.',
        ),
        const SizedBox(height: 20),
        _buildParagraph(
          'Currently working as a freelancer, I am passionate about turning ideas into functional applications. I specialize in UI/UX design using Flutter widgets, backend integration with Laravel and Firebase, and API integration & database management.',
        ),
        const SizedBox(height: 30),
        _buildSkillHighlights(),
      ],
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildSkillHighlights() {
    final highlights = [
      'UI/UX Design with Flutter',
      'Backend Integration',
      'API Development',
      'Database Management',
      'Cross-platform Development',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What I Do',
          style: GoogleFonts.poppins(
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
                style: GoogleFonts.poppins(
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
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: stat['color'],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  stat['label'],
                  style: GoogleFonts.poppins(
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