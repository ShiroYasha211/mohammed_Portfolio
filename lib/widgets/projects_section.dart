import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'foodly_title'.tr(),
      'description': 'foodly_description'.tr(),
      'technologies': ['Flutter', 'Dart', 'Supabase'],
      'githubUrl': 'https://github.com/ShiroYasha211/Foodly_delivery',
      'category': 'mobileApp'.tr(),
      'status': 'completed'.tr(),
      'features': [
        'smart_cart'.tr(),
        'menu_management'.tr(),
        'cart_functionality'.tr(),
        'user_profiles'.tr(),
        'real_time_calculation'.tr(),
        'persistent_cart'.tr(),
        'invoice_generation'.tr(),
        'order_history'.tr(),
        'reorder_functionality'.tr(),
      ],
    },
    {
      'title': 'lino_title'.tr(),
      'description': 'lino_description'.tr(),
      'technologies': ['Flutter', 'Dart', 'Supabase'],
      'githubUrl': 'https://github.com/ShiroYasha211/Lino',
      'category': 'mobileApp'.tr(),
      'status': 'inProgress'.tr(),
      'features': [
        'real_time_messaging'.tr(),
        'user_profiles'.tr(),
        'media_sharing'.tr(),
        'push_notifications'.tr(),
        'group_chats'.tr(),
        'search_functionality'.tr(),
        'typing_indicators'.tr(),
        'read_receipts'.tr(),
        'message_reactions'.tr(),
      ],
    },
    {
      'title': 'forum_title'.tr(),
      'description': 'forum_description'.tr(),
      'technologies': ['Flutter', 'Laravel', 'MySQL', 'API Integration'],
      'githubUrl': 'https://github.com/ShiroYasha211/Fourm_Frontend',
      'category': 'mobileApp'.tr(),
      'status': 'completed'.tr(),
      'features': [
        'user_registration'.tr(),
        'post_creation'.tr(),
        'comment_system'.tr(),
        'user_profiles'.tr(),
        'real_time_updates'.tr(),
      ],
    },
    {
      'title': 'forum_backend_title'.tr(),
      'description': 'forum_backend_description'.tr(),
      'technologies': ['Laravel', 'MySQL', 'Php', 'API Integration'],
      'githubUrl': 'https://github.com/ShiroYasha211/Fourm_Backend',
      'category': 'backend'.tr(),
      'status': 'completed'.tr(),
      'features': [
        'user_registration'.tr(),
        'post_creation'.tr(),
        'comment_system'.tr(),
        'user_profiles'.tr(),
        'real_time_updates'.tr(),
      ],
    },
    {
      'title': 'shoply_admin_title'.tr(),
      'description': 'shoply_admin_description'.tr(),
      'technologies': [
        'Flutter Web',
        'Supabase',
        'Charts',
        'Responsive Design'
      ],
      'githubUrl': 'https://github.com/ShiroYasha211/Shoply_Admin_Dashboard',
      'category': 'webApp'.tr(),
      'status': 'inProgress'.tr(),
      'features': [
        'product_management'.tr(),
        'order_management'.tr(),
        'analytics_dashboard'.tr(),
        'user_management'.tr(),
        'responsive_design'.tr(),
      ],
    },
    {
      'title': 'shoply_title'.tr(),
      'description': 'shoply_description'.tr(),
      'technologies': ['Flutter', 'Supabase', 'Responsive Design'],
      'githubUrl': 'https://github.com/ShiroYasha211/Shoply',
      'category': 'mobileApp'.tr(),
      'status': 'inProgress'.tr(),
      'features': [
        'product_browsing'.tr(),
        'shopping_cart'.tr(),
        'user_profiles'.tr(),
        'order_history'.tr(),
        'responsive_design'.tr(),
        'real_time_updates'.tr(),
      ],
    },
    {
      'title': 'portfolio_title'.tr(),
      'description': 'portfolio_description'.tr(),
      'technologies': ['Flutter Web', 'Responsive Design', 'Animations'],
      'githubUrl': 'https://github.com/ShiroYasha211/mohammed_Portfolio',
      'category': 'webApp'.tr(),
      'status': 'completed'.tr(),
      'features': [
        'modern_ui'.tr(),
        'smooth_animations'.tr(),
        'responsive_layout'.tr(),
        'contact_integration'.tr(),
        'seo_optimized'.tr(),
      ],
    },
  ];

  String _selectedCategory = 'all'.tr();
  final List<String> _categories = [
    'all'.tr(),
    'mobileApp'.tr(),
    'webApp'.tr(),
    'backend'.tr()
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

  List<Map<String, dynamic>> get _filteredProjects {
    if (_selectedCategory == 'all'.tr()) {
      return _projects;
    }
    return _projects
        .where((project) => project['category'] == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width < 1024;

    return VisibilityDetector(
      key: const Key('projects-section'),
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
            const SizedBox(height: 40),
            _buildCategoryFilter(),
            const SizedBox(height: 60),
            _buildProjectsGrid(),
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
            'projectsTitle'.tr(),
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
            'projectsSubtitle'.tr(),
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

  Widget _buildCategoryFilter() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = _selectedCategory == category;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textTertiary,
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProjectsGrid() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: MediaQuery.of(context).size.width < 768
            ? _buildMobileProjectsList()
            : _buildDesktopProjectsGrid(),
      ),
    );
  }

  Widget _buildMobileProjectsList() {
    return Column(
      children: _filteredProjects
          .map(
            (project) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildMobileProjectCard(
                  project, _filteredProjects.indexOf(project)),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMobileProjectCard(Map<String, dynamic> project, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final delayedValue =
            (_animationController.value - (index * 0.1)).clamp(0.0, 1.0);
        if (delayedValue <= 0) return const SizedBox.shrink();

        final curvedValue = Curves.easeOutCubic.transform(delayedValue);

        return Transform.translate(
          offset: Offset(0, (1 - curvedValue) * 20),
          child: Opacity(
            opacity: curvedValue,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 200,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.cardGradient.colors.first.withOpacity(0.9),
                    AppColors.cardGradient.colors.last.withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.15),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.06),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned(
                      top: -15,
                      right: -15,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.03),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildMobileProjectHeader(project),
                          const SizedBox(height: 15),
                          _buildMobileProjectDescription(project),
                          const SizedBox(height: 15),
                          _buildMobileTechnologies(project),
                          const SizedBox(height: 15),
                          _buildMobileProjectActions(project),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: context.locale.languageCode == 'en' ? 15 : null,
                      left: context.locale.languageCode == 'en' ? null : 15,
                      child: _buildStatusBadge(project['status']),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileProjectHeader(Map<String, dynamic> project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 45,
          height: 45,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Icon(
            project['category'] == 'mobileApp'.tr()
                ? Icons.phone_iphone
                : project['category'] == 'webApp'.tr()
                    ? Icons.web
                    : Icons.code,
            color: AppColors.primary,
            size: 22,
          ),
        ),
        Text(
          project['title'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withOpacity(0.15)),
          ),
          child: Text(
            project['category'],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileProjectDescription(Map<String, dynamic> project) {
    return Text(
      project['description'],
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildMobileTechnologies(Map<String, dynamic> project) {
    final technologies = (project['technologies'] as List<String>);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'technologies'.tr(),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: technologies.take(4).map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
              ),
              child: Text(
                tech,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMobileProjectActions(Map<String, dynamic> project) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (project['githubUrl'] != null)
                    Expanded(
                      child: _buildMobileActionButton(
                        icon: FontAwesomeIcons.github,
                        label: 'sourceCode'.tr(),
                        color: AppColors.github,
                        onTap: () => _launchUrl(project['githubUrl']),
                      ),
                    ),
                  if (project['githubUrl'] != null &&
                      project['demoUrl'] != null)
                    const SizedBox(width: 10),
                  if (project['demoUrl'] != null)
                    Expanded(
                      child: _buildMobileActionButton(
                        icon: Icons.launch,
                        label: 'liveDemo'.tr(),
                        color: AppColors.primary,
                        onTap: () => _launchUrl(project['demoUrl']),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: _buildMobileDetailsButton(project),
        ),
      ],
    );
  }

  Widget _buildMobileActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileDetailsButton(Map<String, dynamic> project) {
    return InkWell(
      onTap: () => _showProjectDetails(project),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'viewDetails'.tr(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopProjectsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.1,
      ),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(_filteredProjects[index], index);
      },
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final delayedValue = (_animationController.value).clamp(0.0, 1.0);

        final curvedValue = Curves.easeOutCubic.transform(delayedValue);

        return Transform.translate(
          offset: Offset(0, (1 - curvedValue) * 20),
          child: Opacity(
            opacity: curvedValue,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.cardGradient.colors.first.withOpacity(0.9),
                    AppColors.cardGradient.colors.last.withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 25,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: -5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.03),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProjectHeader(project),
                          const SizedBox(height: 20),
                          _buildProjectDescription(project),
                          const SizedBox(height: 20),
                          _buildTechnologies(project),
                          const Spacer(),
                          _buildProjectActions(project),
                        ],
                      ),
                    ),
                    Positioned(
                      top: context.locale.languageCode == 'ar' ? 20 : 20,
                      right: context.locale.languageCode == 'ar' ? null : 20,
                      left: context.locale.languageCode == 'ar' ? 20 : null,
                      child: _buildStatusBadge(project['status']),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _getStatusColor(status).withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(left: 4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            status,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectHeader(Map<String, dynamic> project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Icon(
            project['category'] == 'mobileApp'.tr()
                ? Icons.phone_iphone
                : project['category'] == 'webApp'.tr()
                    ? Icons.web
                    : Icons.code,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.primary.withOpacity(0.15)),
                    ),
                    child: Text(
                      project['category'],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectDescription(Map<String, dynamic> project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project['description'],
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  Widget _buildTechnologies(Map<String, dynamic> project) {
    final technologies = (project['technologies'] as List<String>);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'technologies'.tr(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: technologies.take(4).map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: AppColors.textTertiary.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                tech,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }).toList(),
        ),
        if (technologies.length > 4)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '+ ${technologies.length - 5} more',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textTertiary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProjectActions(Map<String, dynamic> project) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.textTertiary.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          if (project['githubUrl'] != null)
            _buildActionButton(
              icon: FontAwesomeIcons.github,
              label: 'sourceCode'.tr(),
              color: AppColors.github,
              onTap: () => _launchUrl(project['githubUrl']),
            ),
          if (project['githubUrl'] != null && project['demoUrl'] != null)
            const SizedBox(width: 12),
          if (project['demoUrl'] != null)
            _buildActionButton(
              icon: Icons.launch,
              label: 'liveDemo'.tr(),
              color: AppColors.primary,
              onTap: () => _launchUrl(project['demoUrl']),
            ),
          const Spacer(),
          InkWell(
            onTap: () => _showProjectDetails(project),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'viewDetails'.tr(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    // Use runtime comparisons instead of switch-case with method calls to avoid
    // "Methods can't be invoked in constant expressions" compile error.
    if (status == 'completed'.tr() || status == 'completed') {
      return AppColors.success;
    }
    if (status == 'inProgress'.tr() ||
        status == 'inProgress' ||
        status.toLowerCase() == 'in progress' ||
        status == 'In Progress') {
      return AppColors.warning;
    }
    if (status == 'planning'.tr() ||
        status == 'planning' ||
        status.toLowerCase() == 'planning' ||
        status == 'Planning') {
      return AppColors.primary;
    }
    if (status == 'onHold'.tr() ||
        status == 'onHold' ||
        status.toLowerCase() == 'on hold' ||
        status == 'On Hold') {
      return AppColors.error;
    }
    return AppColors.secondary;
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showProjectDetails(Map<String, dynamic> project) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon:
                        const Icon(Icons.close, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'features'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 15),
              ...(project['features'] as List<String>).map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                project['description'],
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
