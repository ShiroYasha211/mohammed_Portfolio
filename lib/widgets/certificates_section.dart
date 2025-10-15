import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import 'package:web/web.dart' as html;

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

  final List<Map<String, dynamic>> _certificates = [
    {
      'title': 'Computer Essentials',
      'issuer': 'Edraak',
      'date': '2025',
      'description':
          'Comprehensive course covering computer basics, internet usage, and essential software applications.',
      'pdfUrl': 'assets/certificates/computer_essentials.pdf',
      'category': 'Programming',
      'skills': ['Computer Basics', 'Internet', 'Software Applications'],
    },
    {
      'title': 'Interaction Design Fundamentals',
      'issuer': 'Edraak',
      'date': '2025',
      'description':
          'Fundamentals of interaction design, user experience principles, and usability testing.',
      'pdfUrl': 'assets/certificates/Interaction Design Fundamentals.pdf',
      'category': 'Design',
      'skills': ['UX Design', 'Usability', 'User Research'],
    },
    {
      'title': 'Practical Computer Programs',
      'issuer': 'Different Academy',
      'date': '2022',
      'description':
          'Hands-on course on essential computer programs including MS Office and Google Workspace.',
      'pdfUrl': 'assets/certificates/practical computer programs.pdf',
      'category': 'Programming',
      'skills': ['MS Office', 'Google Workspace', 'Productivity'],
    },
    {
      'title': 'UI/UX Design',
      'issuer': 'Edraak',
      'date': '2025',
      'description':
          'Fundamentals of UI/UX design, user experience principles, and usability testing.',
      'pdfUrl': 'assets/certificates/UI_UX Design.pdf',
      'category': 'Design',
      'skills': ['UX Design', 'Usability', 'User Research'],
    },
    {
      'title': 'User Experience Design',
      'issuer': 'Edraak',
      'date': '2025',
      'description':
          'This course is about what it takes to understand users, design for them, and evaluate your designs.',
      'pdfUrl': 'assets/certificates/User Experience Design.pdf',
      'category': 'Design',
      'skills': ['User Research', 'Prototyping', 'Usability Testing'],
    },
    {
      'title': 'User interface design principles',
      'issuer': 'Edraak',
      'date': '2025',
      'description':
          'This Course explain the principles of visual design and how to apply them to create effective user interfaces.',
      'pdfUrl': 'assets/certificates/User interface design principles.pdf',
      'category': 'Design',
      'skills': ['UI Design', 'Visual Design', 'Interaction Design'],
    },
    {
      'title': 'UX Research',
      'issuer': 'Edraak',
      'date': '2025',
      'description':
          'This course covers the basic knowledge of UX research, including planning, conducting, and analyzing research studies.',
      'pdfUrl': 'assets/certificates/UI_UX Design.pdf',
      'category': 'Design',
      'skills': ['User Research', 'Prototyping', 'Usability Testing'],
    },
  ];

  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    //'Mobile Development',
    //'Web Development',
    //'Database',
    'Programming',
    'Education'
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

  List<Map<String, dynamic>> get _filteredCertificates {
    if (_selectedCategory == 'All') {
      return _certificates;
    }
    return _certificates
        .where((cert) => cert['category'] == _selectedCategory)
        .toList();
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
          horizontal: isMobile
              ? 20
              : isTablet
                  ? 60
                  : 120,
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
            // const SizedBox(height: 40),
            // _buildCategoryFilter(),
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
                      style: GoogleFonts.poppins(
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
      children: _filteredCertificates
          .map(
            (certificate) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildMobileCertificateCard(
                  certificate, _filteredCertificates.indexOf(certificate)),
            ),
          )
          .toList(),
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
        final delayedValue =
            (_animationController.value - (0 * 0.15)).clamp(0.0, 1.0);
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

  Widget _buildMobileCertificateCard(
      Map<String, dynamic> certificate, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final delayedValue =
            (_animationController.value - (0 * 0.1)).clamp(0.0, 1.0);
        if (delayedValue <= 0) return const SizedBox.shrink();

        return Transform.translate(
          offset: Offset(0, (1 - delayedValue) * 20),
          child: Opacity(
            opacity: delayedValue,
            child: Container(
              width: double.infinity, // مهم للهاتف
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMobileCertificateHeader(certificate),
                  const SizedBox(height: 12),
                  _buildMobileCertificateBody(certificate),
                  const SizedBox(height: 15),
                  _buildMobileCertificateActions(certificate),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileCertificateHeader(Map<String, dynamic> certificate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getCategoryIcon(certificate['category']),
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
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
                  const SizedBox(height: 4),
                  Text(
                    certificate['issuer'],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Text(
                certificate['date'],
                style: GoogleFonts.poppins(
                  fontSize: 11,
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
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.accent.withOpacity(0.3)),
              ),
              child: Text(
                certificate['category'],
                style: GoogleFonts.poppins(
                  fontSize: 10,
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

  Widget _buildMobileCertificateBody(Map<String, dynamic> certificate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          certificate['description'],
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        if (certificate['credentialId'] != null) ...[
          Row(
            children: [
              const Icon(
                Icons.verified,
                color: AppColors.primary,
                size: 14,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'ID: ${certificate['credentialId']}',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: AppColors.textTertiary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children:
              (certificate['skills'] as List<String>).take(2).map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: AppColors.textTertiary.withOpacity(0.3)),
              ),
              child: Text(
                skill,
                style: GoogleFonts.poppins(
                  fontSize: 9,
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

  Widget _buildMobileCertificateActions(Map<String, dynamic> certificate) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _viewCertificate(certificate),
            icon: const Icon(Icons.picture_as_pdf, size: 14),
            label: Text(
              'View PDF',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        if (certificate['verificationUrl'] != null) ...[
          const SizedBox(width: 8),
          InkWell(
            onTap: () => _verifyCredential(certificate['verificationUrl']),
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: const Icon(
                Icons.verified,
                color: AppColors.success,
                size: 16,
              ),
            ),
          ),
        ],
      ],
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
              const Icon(
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
          children:
              (certificate['skills'] as List<String>).take(3).map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: AppColors.textTertiary.withOpacity(0.3)),
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
              child: const Icon(
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
      case 'Design':
        return Icons.design_services;
      default:
        return Icons.verified;
    }
  }

  void _viewCertificate(Map<String, dynamic> certificate) {
    // Show options dialog for viewing PDF
    _showViewOptionsDialog(certificate);
  }

  void _showViewOptionsDialog(Map<String, dynamic> certificate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.picture_as_pdf,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'View Certificate',
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              certificate['title'],
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Issued by ${certificate['issuer']} • ${certificate['date']}',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Choose how you want to view this certificate:',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),

            // Option 2: Open in Browser
            _buildViewOption(
              icon: Icons.open_in_new,
              title: 'Open in Browser',
              subtitle: 'Open PDF in a new browser tab',
              color: AppColors.primary,
              onTap: () {
                Navigator.of(context).pop();
                _openInBrowser(certificate);
              },
            ),
            const SizedBox(height: 12),

            // Option 3: Download
            _buildViewOption(
              icon: Icons.download,
              title: 'Download PDF',
              subtitle: 'Save certificate to your device',
              color: AppColors.success,
              onTap: () {
                Navigator.of(context).pop();
                _downloadCertificate(certificate);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
          color: color.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color.withOpacity(0.6),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _openInBrowser(Map<String, dynamic> certificate) {
    try {
      final String pdfUrl = certificate['pdfUrl'];
      html.window.open(pdfUrl, '_blank');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Opening certificate: ${certificate['title']}',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      _showPdfErrorDialog(certificate);
    }
  }

  void _showPdfErrorDialog(Map<String, dynamic> certificate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.warning,
              size: 24,
            ),
            const SizedBox(width: 10),
            Text(
              'Certificate Access',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Certificate: ${certificate['title']}',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Unable to open PDF directly. You can:',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            _buildOptionRow(Icons.download, 'Download PDF file', () {
              _downloadCertificate(certificate);
              Navigator.of(context).pop();
            }),
            const SizedBox(height: 8),
            _buildOptionRow(Icons.open_in_new, 'Try opening again', () {
              Navigator.of(context).pop();
              _viewCertificate(certificate);
            }),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'PDF Path: ${certificate['pdfUrl']}',
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionRow(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadCertificate(Map<String, dynamic> certificate) {
    try {
      final String pdfUrl = certificate['pdfUrl'];
      final String fileName =
          '${certificate['title'].replaceAll(' ', '_')}.pdf';

      // Create download link
      final html.HTMLAnchorElement anchor =
          html.document.createElement('a') as html.HTMLAnchorElement;
      anchor.href = pdfUrl;
      anchor.download = fileName;
      anchor.click();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Downloading: $fileName',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to download certificate',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  void _verifyCredential(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
