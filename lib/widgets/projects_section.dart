import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      'title': 'Forum App',
      'description': 'A comprehensive forum application that allows users to create accounts, write posts, and interact through comments. Built with Flutter for the frontend and Laravel for the backend.',
      'technologies': ['Flutter', 'Laravel', 'MySQL', 'API Integration'],
      'image': 'assets/images/forum_app.png', // TODO: Add actual image
      'githubUrl': 'https://github.com/ShiroYasha211/forum-app', // TODO: Add actual URL
      'demoUrl': null, // TODO: Add demo URL if available
      'category': 'Mobile App',
      'status': 'Completed',
      'features': [
        'User Registration & Authentication',
        'Post Creation & Management',
        'Comment System',
        'User Profiles',
        'Real-time Updates',
      ],
    },
    {
      'title': 'Food Delivery App',
      'description': 'A professional food delivery application with smooth user experience, featuring restaurant browsing, menu management, order tracking, and payment integration.',
      'technologies': ['Flutter', 'Firebase', 'Supabase', 'API Integration'],
      'image': 'assets/images/food_delivery_app.png', // TODO: Add actual image
      'githubUrl': 'https://github.com/ShiroYasha211/food-delivery', // TODO: Add actual URL
      'demoUrl': null, // TODO: Add demo URL if available
      'category': 'Mobile App',
      'status': 'Completed',
      'features': [
        'Restaurant Browsing',
        'Menu Management',
        'Cart Functionality',
        'Order Tracking',
        'Payment Integration',
      ],
    },
    {
      'title': 'E-Commerce Dashboard',
      'description': 'A comprehensive dashboard for e-commerce management built with Flutter Web. Includes product management, order tracking, analytics, and user management features.',
      'technologies': ['Flutter Web', 'Firebase', 'Charts', 'API Integration'],
      'image': 'assets/images/ecommerce_dashboard.png', // TODO: Add actual image
      'githubUrl': 'https://github.com/ShiroYasha211/ecommerce-dashboard', // TODO: Add actual URL
      'demoUrl': 'https://your-demo-url.com', // TODO: Add actual demo URL
      'category': 'Web App',
      'status': 'Completed',
      'features': [
        'Product Management',
        'Order Management',
        'Analytics Dashboard',
        'User Management',
        'Responsive Design',
      ],
    },
    // TODO: Add more projects as they are completed
    {
      'title': 'Portfolio Website',
      'description': 'This personal portfolio website built with Flutter Web, featuring modern design, smooth animations, and responsive layout across all devices.',
      'technologies': ['Flutter Web', 'Responsive Design', 'Animations'],
      'image': 'assets/images/portfolio_website.png', // TODO: Add actual image
      'githubUrl': 'https://github.com/ShiroYasha211/portfolio', // TODO: Add actual URL
      'demoUrl': 'https://your-portfolio-url.com', // TODO: Add actual demo URL
      'category': 'Web App',
      'status': 'In Progress',
      'features': [
        'Modern UI Design',
        'Smooth Animations',
        'Responsive Layout',
        'Contact Integration',
        'SEO Optimized',
      ],
    },
  ];

  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Mobile App', 'Web App', 'Backend'];

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
    if (_selectedCategory == 'All') {
      return _projects;
    }
    return _projects.where((project) => project['category'] == _selectedCategory).toList();
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
          horizontal: isMobile ? 20 : isTablet ? 60 : 120,
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
            'Featured Projects',
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
            'A showcase of my recent work and personal projects',
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

  Widget _buildCategoryFilter() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.textTertiary,
                      ),
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
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
      children: _filteredProjects.map((project) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: _buildProjectCard(project, _filteredProjects.indexOf(project)),
        ),
      ).toList(),
    );
  }

  Widget _buildDesktopProjectsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 2 : 1,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 1.3,
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
        final delayedValue = (_animationController.value - (index * 0.2)).clamp(0.0, 1.0);
        return Transform.scale(
          scale: 0.8 + (delayedValue * 0.2),
          child: Opacity(
            opacity: delayedValue,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProjectImage(project),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProjectHeader(project),
                            const SizedBox(height: 15),
                            _buildProjectDescription(project),
                            const SizedBox(height: 15),
                            _buildTechnologies(project),
                            const Spacer(),
                            _buildProjectActions(project),
                          ],
                        ),
                      ),
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

  Widget _buildProjectImage(Map<String, dynamic> project) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        // TODO: Replace with actual project images
        // image: DecorationImage(
        //   image: AssetImage(project['image']),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                project['category'] == 'Mobile App' 
                  ? Icons.phone_android 
                  : Icons.web,
                size: 60,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: project['status'] == 'Completed' 
                    ? AppColors.success 
                    : AppColors.warning,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  project['status'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectHeader(Map<String, dynamic> project) {
    return Row(
      children: [
        Expanded(
          child: Text(
            project['title'],
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Text(
            project['category'],
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectDescription(Map<String, dynamic> project) {
    return Text(
      project['description'],
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTechnologies(Map<String, dynamic> project) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: (project['technologies'] as List<String>).map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.textTertiary.withOpacity(0.3)),
          ),
          child: Text(
            tech,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProjectActions(Map<String, dynamic> project) {
    return Row(
      children: [
        if (project['githubUrl'] != null)
          _buildActionButton(
            icon: FontAwesomeIcons.github,
            label: 'Code',
            color: AppColors.github,
            onTap: () => _launchUrl(project['githubUrl']),
          ),
        if (project['githubUrl'] != null && project['demoUrl'] != null)
          const SizedBox(width: 10),
        if (project['demoUrl'] != null)
          _buildActionButton(
            icon: Icons.launch,
            label: 'Demo',
            color: AppColors.primary,
            onTap: () => _launchUrl(project['demoUrl']),
          ),
        const Spacer(),
        InkWell(
          onTap: () => _showProjectDetails(project),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View Details',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
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
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Project Features:',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 15),
              ...(project['features'] as List<String>).map((feature) => 
                Padding(
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
                          style: GoogleFonts.poppins(
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
                style: GoogleFonts.poppins(
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