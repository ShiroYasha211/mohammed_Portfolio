import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/colors.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  final List<Map<String, dynamic>> _programmingLanguages = [
    {
      'name': 'Dart',
      'level': 90,
      'icon': FontAwesomeIcons.code,
      'color': AppColors.primary,
      'experience': '2+ years',
    },
    {
      'name': 'JavaScript',
      'level': 85,
      'icon': FontAwesomeIcons.js,
      'color': const Color(0xFFF7DF1E),
      'experience': '3+ years',
    },
    {
      'name': 'Python',
      'level': 75,
      'icon': FontAwesomeIcons.python,
      'color': const Color(0xFF3776AB),
      'experience': '2+ years',
    },
    {
      'name': 'C++',
      'level': 70,
      'icon': FontAwesomeIcons.code,
      'color': const Color(0xFF00599C),
      'experience': '2+ years',
    },
    {
      'name': 'C#',
      'level': 65,
      'icon': FontAwesomeIcons.microsoft,
      'color': const Color(0xFF239120),
      'experience': '1+ years',
    },
    {
      'name': 'SQL',
      'level': 80,
      'icon': FontAwesomeIcons.database,
      'color': AppColors.secondary,
      'experience': '3+ years',
    },
  ];

  final List<Map<String, dynamic>> _frameworks = [
    {
      'name': 'Flutter',
      'level': 90,
      'icon': FontAwesomeIcons.mobile,
      'color': const Color(0xFF02569B),
      'description': 'Cross-platform mobile & web development',
    },
    {
      'name': 'Laravel',
      'level': 70,
      'icon': FontAwesomeIcons.laravel,
      'color': const Color(0xFFFF2D20),
      'description': 'Backend API development',
    },
    {
      'name': 'Firebase',
      'level': 85,
      'icon': FontAwesomeIcons.fire,
      'color': const Color(0xFFFFCA28),
      'description': 'Real-time database & authentication',
    },
    {
      'name': 'Supabase',
      'level': 75,
      'icon': FontAwesomeIcons.database,
      'color': const Color(0xFF3ECF8E),
      'description': 'Open-source Firebase alternative',
    },
  ];

  final List<Map<String, dynamic>> _tools = [
    {
      'name': 'Git/GitHub',
      'icon': FontAwesomeIcons.github,
      'color': AppColors.github,
    },
    {
      'name': 'Android Studio',
      'icon': FontAwesomeIcons.android,
      'color': const Color(0xFF3DDC84),
    },
    {
      'name': 'VS Code',
      'icon': FontAwesomeIcons.code,
      'color': const Color(0xFF007ACC),
    },
    {
      'name': 'MySQL',
      'icon': FontAwesomeIcons.database,
      'color': const Color(0xFF4479A1),
    },
    {
      'name': 'Oracle',
      'icon': FontAwesomeIcons.server,
      'color': const Color(0xFFF80000),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
      key: const Key('skills-section'),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.surface.withOpacity(0.3),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildSectionHeader(),
            const SizedBox(height: 60),
            _buildProgrammingLanguages(),
            const SizedBox(height: 60),
            _buildFrameworksAndTools(),
            const SizedBox(height: 60),
            _buildToolsGrid(),
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
            'Skills & Technologies',
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
            'Technologies I work with and my proficiency levels',
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

  Widget _buildProgrammingLanguages() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Programming Languages',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 30),
            MediaQuery.of(context).size.width < 768
              ? _buildMobileLanguageGrid()
              : _buildDesktopLanguageGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLanguageGrid() {
    return Column(
      children: [
        for (int i = 0; i < _programmingLanguages.length; i += 2) ...[
          Row(
            children: [
              Expanded(child: _buildLanguageCard(_programmingLanguages[i], i)),
              if (i + 1 < _programmingLanguages.length) ...[
                const SizedBox(width: 20),
                Expanded(child: _buildLanguageCard(_programmingLanguages[i + 1], i + 1)),
              ],
            ],
          ),
          if (i + 2 < _programmingLanguages.length) const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildDesktopLanguageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.2,
      ),
      itemCount: _programmingLanguages.length,
      itemBuilder: (context, index) {
        return _buildLanguageCard(_programmingLanguages[index], index);
      },
    );
  }

  Widget _buildLanguageCard(Map<String, dynamic> language, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final delayedValue = (_animationController.value - (index * 0.1)).clamp(0.0, 1.0);
        return Transform.scale(
          scale: 0.8 + (delayedValue * 0.2),
          child: Opacity(
            opacity: delayedValue,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: (language['color'] as Color).withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (language['color'] as Color).withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    language['icon'],
                    color: language['color'],
                    size: 40,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    language['name'],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    language['experience'],
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildProgressBar(language['level'], language['color']),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressBar(int level, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Proficiency',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '$level%',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: _animationController.value * (level / 100),
              backgroundColor: AppColors.surface,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFrameworksAndTools() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frameworks & Technologies',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 30),
            MediaQuery.of(context).size.width < 768
              ? _buildMobileFrameworksList()
              : _buildDesktopFrameworksList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileFrameworksList() {
    return Column(
      children: _frameworks.map((framework) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildFrameworkCard(framework),
        ),
      ).toList(),
    );
  }

  Widget _buildDesktopFrameworksList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 2.5,
      ),
      itemCount: _frameworks.length,
      itemBuilder: (context, index) {
        return _buildFrameworkCard(_frameworks[index]);
      },
    );
  }

  Widget _buildFrameworkCard(Map<String, dynamic> framework) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: (framework['color'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: (framework['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FaIcon(
              framework['icon'],
              color: framework['color'],
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  framework['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  framework['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                _buildProgressBar(framework['level'], framework['color']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolsGrid() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tools & Databases',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: _tools.map((tool) => _buildToolChip(tool)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolChip(Map<String, dynamic> tool) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (_animationController.value * 0.2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: (tool['color'] as Color).withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  tool['icon'],
                  color: tool['color'],
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  tool['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}