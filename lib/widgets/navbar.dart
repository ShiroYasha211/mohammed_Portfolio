import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohammed_portfolio/main.dart';
import '../constants/colors.dart';

class CustomNavBar extends StatefulWidget {
  final Function(String) onNavigate;
  final Map<String, GlobalKey> sectionKeys;
  final ScrollController scrollController;

  const CustomNavBar({
    super.key,
    required this.onNavigate,
    required this.sectionKeys,
    required this.scrollController,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  String selectedSection = 'home'.tr();

  void _updateSelectionSection() {
    final scrollPosition = widget.scrollController.position.pixels;
    final context = widget.sectionKeys['home']!.currentContext;

    if (context != null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      Future.delayed(const Duration(milliseconds: 200), () {
        if (scrollPosition >= position.dy - 100) {
          setState(() {
            selectedSection = 'home'.tr();
          });
        }
      });
    }
  }

  void _toggleLanguage() async {
    if (context.locale.languageCode == 'en') {
      await context.setLocale(const Locale('ar'));
    } else {
      await context.setLocale(const Locale('en'));
    }

    _reloadApp();
  }

  void _reloadApp() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const PortfolioHome()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateSelectionSection);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateSelectionSection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Brand
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.code,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              if (!isMobile) ...[
                const Text(
                  'Mohammed Alhemyari',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ],
          ),

          // Navigation Items and Language Toggle
          Row(
            children: [
              if (!isMobile) _buildDesktopMenu(),
              _buildLanguageToggle(),
              if (isMobile) _buildMobileMenu()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopMenu() {
    final menuItems = [
      {'title': 'home'.tr(), 'key': 'home'},
      {'title': 'about'.tr(), 'key': 'about'},
      {'title': 'skills'.tr(), 'key': 'skills'},
      {'title': 'projects'.tr(), 'key': 'projects'},
      {'title': 'certificates'.tr(), 'key': 'certificates'},
      {'title': 'contact'.tr(), 'key': 'contact'},
    ];
    return Row(
      children: menuItems.map((item) {
        final isSelected = selectedSection == item['title'];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedSection = item['title'] as String;
                });
                widget.onNavigate(item['key'] as String);
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(color: AppColors.primary.withOpacity(0.3))
                      : null,
                ),
                child: Text(
                  item['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileMenu() {
    return Row(
      children: [
        const SizedBox(width: 12),
        PopupMenuButton<String>(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.menu,
              color: AppColors.primary,
            ),
          ),
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          itemBuilder: (context) => [
            _buildPopupMenuItem('home'.tr(), 'home'),
            _buildPopupMenuItem('about'.tr(), 'about'),
            _buildPopupMenuItem('skills'.tr(), 'skills'),
            _buildPopupMenuItem('projects'.tr(), 'projects'),
            _buildPopupMenuItem('certificates'.tr(), 'certificates'),
            _buildPopupMenuItem('contact'.tr(), 'contact'),
          ],
          onSelected: (value) {
            setState(() {
              selectedSection = value;
            });

            widget.onNavigate(_getKeyFromTitle(value));
          },
        ),
      ],
    );
  }

  String _getKeyFromTitle(String title) {
    final keys = {
      'home'.tr(): 'home',
      'about'.tr(): 'about',
      'skills'.tr(): 'skills',
      'projects'.tr(): 'projects',
      'certificates'.tr(): 'certificates',
      'contact'.tr(): 'contact',
    };
    return keys[title] ?? 'home';
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title, String key) {
    return PopupMenuItem<String>(
      value: title,
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: InkWell(
        onTap: _toggleLanguage,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.language,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                context.locale.languageCode == 'ar' ? 'EN' : 'AR',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
