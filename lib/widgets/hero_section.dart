import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactPressed;
  const HeroSection({super.key, required this.onContactPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _scrollIndicatorController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _bounceAnimation;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    // تحكم منفصل لمؤشر التمرير
    _scrollIndicatorController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scrollIndicatorController,
      curve: Curves.easeInOut,
    ));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _scrollIndicatorController,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 1000), () {
      _scrollIndicatorController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollIndicatorController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width < 1024;

    return Container(
      height: screenSize.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
      ),
      child: Stack(
        children: [
          // Background Animation Particles
          ..._buildBackgroundParticles(),

          // Main Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile
                    ? 20
                    : isTablet
                        ? 60
                        : 120,
              ),
              child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
            ),
          ),

          // Scroll Down Indicator
          Positioned(
            bottom: isMobile ? -14 : 40,
            left: 0,
            right: 0,
            child: _buildScrollIndicator(),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProfileImage(120),
            const SizedBox(height: 30),
            _buildIntroText(),
            const SizedBox(height: 30),
            _buildAnimatedRole(),
            const SizedBox(height: 40),
            _buildDescription(),
            const SizedBox(height: 40),
            _buildActionButtons(),
            const SizedBox(height: 30),
            _buildSocialLinks(),
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
          children: [
            // Left Side - Text Content
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIntroText(),
                  const SizedBox(height: 20),
                  _buildAnimatedRole(),
                  const SizedBox(height: 30),
                  _buildDescription(),
                  const SizedBox(height: 40),
                  _buildActionButtons(),
                  const SizedBox(height: 30),
                  _buildSocialLinks(),
                ],
              ),
            ),

            const SizedBox(width: 60),

            // Right Side - Profile Image
            Expanded(
              flex: 2,
              child: Center(
                child: _buildProfileImage(300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.surface,
          image: DecorationImage(
            image: AssetImage('assets/images/profile.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Text(
      'heroHello'.tr(),
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width < 768 ? 20 : 24,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildAnimatedRole() {
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: MediaQuery.of(context).size.width < 768
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            'heroName'.tr(),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width < 768 ? 28 : 48,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'heroRole1'.tr(),
                textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 768 ? 18 : 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'heroRole2'.tr(),
                textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 768 ? 18 : 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'heroRole3'.tr(),
                textStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 768 ? 18 : 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'heroDescription'.tr(),
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width < 768 ? 14 : 16,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
      textAlign: MediaQuery.of(context).size.width < 768
          ? TextAlign.center
          : TextAlign.left,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MediaQuery.of(context).size.width < 768
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            // TODO: Download CV
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.download),
              const SizedBox(width: 8),
              Text(
                'downloadCV'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          onPressed: () {
            widget.onContactPressed();
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'contactMe'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MediaQuery.of(context).size.width < 768
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        _buildSocialIcon(
          FontAwesomeIcons.github,
          AppColors.github,
          'https://github.com/ShiroYasha211',
        ),
        const SizedBox(width: 15),
        _buildSocialIcon(
          FontAwesomeIcons.linkedin,
          AppColors.linkedin,
          'https://www.linkedin.com/in/mohammed-alhemyari-bb0352248/',
        ),
        const SizedBox(width: 15),
        _buildSocialIcon(
          FontAwesomeIcons.whatsapp,
          AppColors.whatsapp,
          'https://wa.me/967773468708',
        ),
        const SizedBox(
          width: 15,
        ),
        _buildSocialIcon(
          FontAwesomeIcons.facebook,
          AppColors.linkedin,
          "https://www.facebook.com/profile.php?id=61582091684308",
        ),
        const SizedBox(width: 15),
        _buildSocialIcon(
          FontAwesomeIcons.envelope,
          AppColors.email,
          'mailto:alhemyarimohammed211@gmail.com',
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, String url) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: FaIcon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return FadeTransition(
      opacity: _pulseAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'scrollDown'.tr(),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_bounceAnimation.value),
                child: child,
              );
            },
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBackgroundParticles() {
    return List.generate(40, (index) {
      return Positioned(
        left: (index * 50.0) % MediaQuery.of(context).size.width,
        top: (index * 80.0) % MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                (index % 2 == 0 ? -1 : 1) * _controller.value * 20,
              ),
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
