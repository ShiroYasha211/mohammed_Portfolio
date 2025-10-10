import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';

class CertificatesSection extends StatefulWidget {
  const CertificatesSection({super.key});

  @override
  State<CertificatesSection> createState() => _CertificatesSectionState();
}

class _CertificatesSectionState extends State<CertificatesSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  // TODO: Add your actual certificates here
  final List<Map<String, dynamic>> _certificates = [
    {
      'title': 'Flutter Development Certificate',
      'issuer': 'Google',
      'date': '2023',
      'description': 'Comprehensive Flutter development certification covering advanced mobile app development.',
      'pdfUrl': 'assets/certificates/flutter_certificate.pdf', // TODO: Add actual PDF path
      'credentialId': 'FL001234567',
      'category': 'Mobile Development',
      'skills': ['Flutter', 'Dart', 'Mobile UI/UX'],
      'verificationUrl': 'https://verify.google.com/flutter-cert', // TODO: Add actual URL
    },
    {
      'title': 'JavaScript Fundamentals',
      'issuer': 'freeCodeCamp',
      'date': '2022',
      'description': 'Complete JavaScript fundamentals course including ES6+ features and modern development practices.',
      'pdfUrl': 'assets/certificates/javascript_certificate.pdf', // TODO: Add actual PDF path
      'credentialId': 'JS987654321',
      'category': 'Web Development',
      'skills': ['JavaScript', 'ES6+', 'DOM Manipulation'],
      'verificationUrl': 'https://freecodecamp.org/verify/js-cert', // TODO: Add actual URL
    },
    {
      'title': 'Database Management',
      'issuer': 'Oracle University',
      'date': '2022',
      'description': 'Database design, management, and optimization using Oracle SQL and MySQL.',
      'pdfUrl': 'assets/certificates/database_certificate.pdf', // TODO: Add actual PDF path
      'credentialId': 'DB456789123',
      'category': 'Database',
      'skills': ['SQL', 'Database Design', 'MySQL', 'Oracle'],
      'verificationUrl': 'https://oracle.com/verify/db-cert', // TODO: Add actual URL
    },
    {
      'title': 'Computer Information Systems Degree',
      'issuer': 'University',
      'date': '2021',
      'description': 'Bachelor\'s degree in Computer Information Systems with focus on software development.',
      'pdfUrl': 'assets/certificates/degree_certificate.pdf', // TODO: Add actual PDF path
      'credentialId': 'UNI2021CIS',
      'category': 'Education',
      'skills': ['Programming', 'Systems Analysis', 'Software Engineering'],
      'verificationUrl': null, // Academic certificates may not have online verification
    },
    // TODO: Add more certificates as you obtain them
    {
      'title': 'Python Programming',
      'issuer': 'Coursera',
      'date': '2022',
      'description': 'Python programming fundamentals and advanced concepts for software development.',
      'pdfUrl': 'assets/certificates/python_certificate.pdf', // TODO: Add actual PDF path
      'credentialId': 'PY123456789',
      'category': 'Programming',
      'skills': ['Python', 'OOP', 'Data Structures'],
      'verificationUrl': 'https://coursera.org/verify/python-cert', // TODO: Add actual URL
    },
  ];

  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Mobile Development', 'Web Development', 'Database', 'Programming', 'Education'];

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

  List<Map<String, dynamic>> get _filteredCertificates {
    if (_selectedCategory == 'All') {
      return _certificates;
    }
    return _certificates.where((cert) => cert['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 768;
    final isTablet = screenSize.width < 1024;

    return VisibilityDetector(
      key: const Key('certificates-section'),
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
            const SizedBox(height: 40),
            _buildCategoryFilter(),
            const SizedBox(height: 60),
            _buildCertificatesGrid(),
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
            'Certificates & Education',
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
            'My professional certifications and educational achievements',
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

  Widget _buildCertificatesGrid() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: MediaQuery.of(context).size.width < 768
            ? _buildMobileCertificatesList()
            : _buildDesktopCertificatesGrid(),
      ),
    );
  }

  Widget _buildMobileCertificatesList() {
    return Column(
      children: _filteredCertificates.map((certificate) => 
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: _buildCertificateCard(certificate, _filteredCertificates.indexOf(certificate)),
        ),
      ).toList(),
    );
  }

  Widget _buildDesktopCertificatesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 1.1,
      ),
      itemCount: _filteredCertificates.length,
      itemBuilder: (context, index) {
        return _buildCertificateCard(_filteredCertificates[index], index);
      },
    );
  }

  Widget _buildCertificateCard(Map<String, dynamic> certificate, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final delayedValue = (_animationController.value - (index * 0.15)).clamp(0.0, 1.0);
        return Transform.scale(
          scale: 0.8 + (delayedValue * 0.2),
          child: Opacity(
            opacity: delayedValue,
            child: Container(
              padding: const EdgeInsets.all(25),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCertificateHeader(certificate),
                  const SizedBox(height: 15),
                  _buildCertificateBody(certificate),
                  const Spacer(),
                  _buildCertificateActions(certificate),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCertificateHeader(Map<String, dynamic> certificate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _getCategoryIcon(certificate['category']),
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    certificate['title'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    certificate['issuer'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Text(
                certificate['date'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.accent.withOpacity(0.3)),
              ),
              child: Text(
                certificate['category'],
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCertificateBody(Map<String, dynamic> certificate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          certificate['description'],
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 15),
        if (certificate['credentialId'] != null) ...[
          Row(
            children: [
              Icon(
                Icons.verified,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'ID: ${certificate['credentialId']}',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: (certificate['skills'] as List<String>).take(3).map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.textTertiary.withOpacity(0.3)),
              ),
              child: Text(
                skill,
                style: GoogleFonts.poppins(
                  fontSize: 10,
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

  Widget _buildCertificateActions(Map<String, dynamic> certificate) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _viewCertificate(certificate),
            icon: const Icon(Icons.picture_as_pdf, size: 16),
            label: Text(
              'View PDF',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        if (certificate['verificationUrl'] != null)
          InkWell(
            onTap: () => _verifyCredential(certificate['verificationUrl']),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Icon(
                Icons.verified,
                color: AppColors.success,
                size: 20,
              ),
            ),
          ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Mobile Development':
        return Icons.phone_android;
      case 'Web Development':
        return Icons.web;
      case 'Database':
        return Icons.storage;
      case 'Programming':
        return Icons.code;
      case 'Education':
        return Icons.school;
      default:
        return Icons.verified;
    }
  }

  void _viewCertificate(Map<String, dynamic> certificate) {
    // TODO: Implement PDF viewing functionality
    // For now, show a placeholder dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
        ),
        title: Text(
          'Certificate PDF',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.picture_as_pdf,
              color: AppColors.primary,
              size: 60,
            ),
            const SizedBox(height: 20),
            Text(
              'Certificate: ${certificate['title']}',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'PDF Path: ${certificate['pdfUrl']}',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'TODO: Implement PDF viewer or download functionality',
              style: GoogleFonts.poppins(
                color: AppColors.warning,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: GoogleFonts.poppins(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _verifyCredential(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}