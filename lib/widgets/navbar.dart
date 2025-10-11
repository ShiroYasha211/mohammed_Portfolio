import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String selectedSection = 'Home';

  void _updateSelectionSection() {
    final scrollPosition = widget.scrollController.position.pixels;
    final context = widget.sectionKeys['home']!.currentContext;

    if (context != null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      //final size = renderBox.size;

      Future.delayed(const Duration(milliseconds: 200), () {
        if (scrollPosition >= position.dy - 100) {
          setState(() {
            selectedSection = 'Home';
          });
        }
      });
    }
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
                Text(
                  'Mohammed Alhemyari',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ],
          ),

          // Navigation Items
          if (isMobile) _buildMobileMenu() else _buildDesktopMenu(),
        ],
      ),
    );
  }

  Widget _buildDesktopMenu() {
    final menuItems = [
      {'title': 'Home', 'key': 'home'},
      {'title': 'About', 'key': 'about'},
      {'title': 'Skills', 'key': 'skills'},
      {'title': 'Projects', 'key': 'projects'},
      {'title': 'Certificates', 'key': 'certificates'},
      {'title': 'Contact', 'key': 'contact'},
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
                  style: GoogleFonts.poppins(
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
    return PopupMenuButton<String>(
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
        _buildPopupMenuItem('Home'),
        _buildPopupMenuItem('About'),
        _buildPopupMenuItem('Skills'),
        _buildPopupMenuItem('Projects'),
        _buildPopupMenuItem('Certificates'),
        _buildPopupMenuItem('Contact'),
      ],
      onSelected: (value) {
        setState(() {
          selectedSection = value;
        });

        widget.onNavigate(value.toLowerCase());
      },
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title) {
    return PopupMenuItem<String>(
      value: title,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
