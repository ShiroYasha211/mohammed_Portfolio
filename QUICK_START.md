# 🚀 Quick Start Guide

## Prerequisites

1. **Flutter SDK**: Download and install Flutter from [flutter.dev](https://flutter.dev/docs/get-started/install)
2. **Chrome Browser**: Required for web development
3. **Code Editor**: VS Code or Android Studio recommended

## Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the Project
```bash
# For web development
flutter run -d chrome

# For web with hot reload
flutter run -d web-server --web-hostname localhost --web-port 8080
```

### 3. Build for Production
```bash
flutter build web
```

The built files will be in `build/web/` directory.

## 📂 Project Structure Overview

```
mohammed_portfolio/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── constants/
│   │   └── colors.dart             # App colors and theme
│   └── widgets/
│       ├── navbar.dart             # Navigation bar
│       ├── hero_section.dart       # Landing section
│       ├── about_section.dart      # About me section
│       ├── skills_section.dart     # Skills display
│       ├── projects_section.dart   # Projects showcase
│       ├── certificates_section.dart # Certificates
│       └── contact_section.dart    # Contact form
├── assets/
│   ├── images/                     # Profile and project images
│   └── certificates/               # PDF certificates
├── web/                            # Web-specific files
└── pubspec.yaml                    # Dependencies
```

## 🎯 Key Features

- ✅ **Responsive Design**: Works on all devices
- ✅ **Modern Animations**: Smooth scrolling and transitions  
- ✅ **Professional Theme**: Dark theme with blue accents
- ✅ **Interactive Navigation**: Smooth section scrolling
- ✅ **Contact Form**: Form validation and submission
- ✅ **Project Showcase**: Filter by category
- ✅ **Skills Display**: Progress bars and categories
- ✅ **Certificate Viewer**: PDF display capability

## 🔧 Quick Customization

### Update Personal Info
1. **Name & Title**: Edit `lib/widgets/hero_section.dart`
2. **About Text**: Edit `lib/widgets/about_section.dart` 
3. **Contact Info**: Edit `lib/widgets/contact_section.dart`

### Add Projects
1. Open `lib/widgets/projects_section.dart`
2. Add your project data to the `_projects` list
3. Add project images to `assets/images/`

### Add Skills
1. Open `lib/widgets/skills_section.dart`
2. Update the programming languages and frameworks lists
3. Adjust skill levels (0-100)

### Add Certificates
1. Open `lib/widgets/certificates_section.dart`
2. Add certificate data to the `_certificates` list
3. Add PDF files to `assets/certificates/`

## 🎨 Color Customization

Edit `lib/constants/colors.dart`:
```dart
static const Color primary = Color(0xFF2196F3);    // Your primary color
static const Color secondary = Color(0xFF00BCD4);  // Your secondary color
static const Color accent = Color(0xFFFFC107);     // Your accent color
```

## 📱 Testing on Different Devices

```bash
# Mobile view (iPhone)
flutter run -d chrome --dart-define=DEVICE_TYPE=mobile

# Tablet view  
flutter run -d chrome --dart-define=DEVICE_TYPE=tablet

# Desktop view
flutter run -d chrome --dart-define=DEVICE_TYPE=desktop
```

Or use Chrome DevTools to simulate different devices.

## 🚀 Deployment Options

### 1. Firebase Hosting
```bash
npm install -g firebase-tools
firebase login
firebase init hosting
flutter build web
firebase deploy
```

### 2. GitHub Pages
1. Build the project: `flutter build web`
2. Copy `build/web/*` to your GitHub Pages repository
3. Push to GitHub

### 3. Netlify
1. Build the project: `flutter build web` 
2. Drag and drop the `build/web` folder to Netlify
3. Your site is live!

## 🔍 Troubleshooting

### Common Issues

**1. "Flutter command not found"**
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

**2. "Package not found"**
```bash
flutter clean
flutter pub get
```

**3. "Web renderer issues"**
```bash
flutter run -d chrome --web-renderer html
```

**4. "Font loading issues"**
```bash
flutter run -d chrome --web-renderer canvaskit
```

### Performance Tips

1. **Optimize Images**: Use WebP format for better performance
2. **Lazy Loading**: Images load as needed
3. **Font Display**: Google Fonts loads efficiently
4. **Animation**: Optimized for 60fps

## 📋 Development Checklist

Before going live:

- [ ] Add your personal images
- [ ] Update all contact information  
- [ ] Add real project data and links
- [ ] Add certificate PDFs
- [ ] Test on mobile, tablet, and desktop
- [ ] Verify all external links work
- [ ] Test contact form (if connected to backend)
- [ ] Optimize images for web
- [ ] Add Google Analytics (optional)
- [ ] Test loading speed

## 🆘 Need Help?

**Mohammed Alhemyari**
- 📧 Email: samehing211@gmail.com
- 📱 WhatsApp: +967773468708  
- 💼 LinkedIn: [Mohammed Alhemyari](https://www.linkedin.com/in/mohammed-alhemyari-bb0352248/)
- 🐱 GitHub: [ShiroYasha211](https://github.com/ShiroYasha211)

---

**Happy Coding! 🎉**