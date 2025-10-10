# Mohammed Alhemyari - Portfolio

A modern, responsive portfolio website built with Flutter Web showcasing my skills, projects, and experience as a Flutter Developer.

## 🚀 Features

- **Responsive Design**: Optimized for all devices (mobile, tablet, desktop)
- **Modern UI**: Clean and professional design with smooth animations
- **Interactive Sections**:
  - Hero section with animated text
  - About me with statistics
  - Skills showcase with progress indicators
  - Projects gallery with filtering
  - Certificates section with PDF viewer capability
  - Contact form with validation
- **Smooth Animations**: Page transitions and scroll-triggered animations
- **Professional Theme**: Dark theme with blue accent colors

## 🛠️ Technologies Used

- **Flutter Web**: Cross-platform web framework
- **Dart**: Programming language
- **Google Fonts**: Beautiful typography
- **Font Awesome**: Professional icons
- **Animated Text Kit**: Text animations
- **URL Launcher**: External link handling

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── constants/
│   └── colors.dart          # Color scheme and theme constants
└── widgets/
    ├── navbar.dart          # Navigation bar component
    ├── hero_section.dart    # Hero/landing section
    ├── about_section.dart   # About me section
    ├── skills_section.dart  # Skills and technologies
    ├── projects_section.dart # Projects showcase
    ├── certificates_section.dart # Certificates display
    └── contact_section.dart # Contact form and info
```

## 🎨 Customization Guide

### 1. Personal Information

Edit the following files to update your personal information:

#### Hero Section (`lib/widgets/hero_section.dart`)
```dart
// Update your name and titles
Text('Mohammed Alhemyari', ...)
TypewriterAnimatedText('Flutter Developer', ...)
TypewriterAnimatedText('Mobile App Developer', ...)

// Update your description
Text('Bachelor in Computer Information Systems...', ...)

// Update social links
'https://github.com/ShiroYasha211',
'https://www.linkedin.com/in/mohammed-alhemyari-bb0352248/',
'https://wa.me/967773468708',
'mailto:samehing211@gmail.com',
```

#### About Section (`lib/widgets/about_section.dart`)
```dart
// Update contact information
_buildContactItem(Icons.email, 'samehing211@gmail.com'),
_buildContactItem(Icons.phone, '+967773468708'),

// Update your story
_buildParagraph('I am a passionate software developer...'),

// Update statistics
_stats = [
  {'number': '4+', 'label': 'Years Experience', ...},
  {'number': '15+', 'label': 'Projects Completed', ...},
  // ... update with your actual numbers
];
```

### 2. Skills and Technologies

Update your skills in `lib/widgets/skills_section.dart`:

```dart
// Programming languages with proficiency levels
final List<Map<String, dynamic>> _programmingLanguages = [
  {
    'name': 'Dart',
    'level': 90, // Update with your level (0-100)
    'experience': '2+ years', // Update experience
  },
  // Add/remove languages as needed
];

// Frameworks and tools
final List<Map<String, dynamic>> _frameworks = [
  {
    'name': 'Flutter',
    'level': 90,
    'description': 'Cross-platform mobile & web development',
  },
  // Add your frameworks
];
```

### 3. Projects

Update your projects in `lib/widgets/projects_section.dart`:

```dart
final List<Map<String, dynamic>> _projects = [
  {
    'title': 'Your Project Name',
    'description': 'Project description...',
    'technologies': ['Flutter', 'Firebase', 'etc'],
    'image': 'assets/images/your_project.png', // Add your image
    'githubUrl': 'https://github.com/yourusername/project',
    'demoUrl': 'https://your-demo-url.com',
    'category': 'Mobile App', // or 'Web App', 'Backend'
    'status': 'Completed', // or 'In Progress'
    'features': [
      'Feature 1',
      'Feature 2',
      // List your project features
    ],
  },
  // Add more projects
];
```

### 4. Certificates

Update your certificates in `lib/widgets/certificates_section.dart`:

```dart
final List<Map<String, dynamic>> _certificates = [
  {
    'title': 'Certificate Name',
    'issuer': 'Issuing Organization',
    'date': '2023',
    'description': 'Certificate description...',
    'pdfUrl': 'assets/certificates/your_certificate.pdf',
    'credentialId': 'CERT123456',
    'category': 'Mobile Development', // or 'Web Development', etc
    'skills': ['Skill1', 'Skill2'],
    'verificationUrl': 'https://verify-url.com',
  },
  // Add your certificates
];
```

### 5. Contact Information

Update contact details in `lib/widgets/contact_section.dart`:

```dart
final List<Map<String, dynamic>> _contactInfo = [
  {
    'title': 'Email',
    'value': 'your-email@example.com',
    'url': 'mailto:your-email@example.com',
  },
  {
    'title': 'Phone',
    'value': '+1234567890',
    'url': 'tel:+1234567890',
  },
  // Update with your contact information
];
```

## 📸 Adding Images

### Profile Images
1. Add your profile image to `assets/images/profile.jpg`
2. Update the image path in:
   - `lib/widgets/hero_section.dart` (line with TODO: Replace with actual profile image)
   - `lib/widgets/about_section.dart` (line with TODO: Replace with actual image)

### Project Images
1. Add project screenshots to `assets/images/`
2. Update the image paths in your project data

### Example:
```dart
// Replace placeholder with your actual image
decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/your-project.png'),
    fit: BoxFit.cover,
  ),
),
```

## 📄 Adding PDF Certificates

1. Add your certificate PDFs to `assets/certificates/`
2. Update the PDF paths in the certificates data
3. Implement PDF viewing functionality (currently shows placeholder)

## 🎨 Customizing Colors

Update the color scheme in `lib/constants/colors.dart`:

```dart
class AppColors {
  // Change primary colors to match your brand
  static const Color primary = Color(0xFF2196F3); // Your primary color
  static const Color secondary = Color(0xFF00BCD4); // Your secondary color
  static const Color accent = Color(0xFFFFC107); // Your accent color
  
  // Customize other colors as needed
}
```

## 🚀 Running the Project

1. **Install Flutter**: Follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install)

2. **Get Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run on Web**:
   ```bash
   flutter run -d chrome
   ```

4. **Build for Production**:
   ```bash
   flutter build web
   ```

## 📱 Responsive Breakpoints

The portfolio adapts to different screen sizes:
- **Mobile**: < 768px
- **Tablet**: 768px - 1024px  
- **Desktop**: > 1024px

## 🔧 TODO: Implementation Notes

The following features need to be implemented when you use this portfolio:

1. **PDF Viewer**: Implement actual PDF viewing for certificates
2. **Form Backend**: Connect contact form to email service (e.g., EmailJS, Firebase Functions)
3. **Analytics**: Add Google Analytics or similar tracking
4. **SEO**: Add meta tags and SEO optimization for web
5. **Performance**: Optimize images and add lazy loading

## 📞 Contact Information

**Mohammed Alhemyari**
- 📧 Email: samehing211@gmail.com
- 📱 Phone: +967773468708
- 💼 LinkedIn: [Mohammed Alhemyari](https://www.linkedin.com/in/mohammed-alhemyari-bb0352248/)
- 🐱 GitHub: [ShiroYasha211](https://github.com/ShiroYasha211)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Built with ❤️ using Flutter**