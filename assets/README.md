# Assets Folder - File Structure Guide

This folder contains all the static assets for your portfolio.

## 📁 Folder Structure

```
assets/
├── images/
│   ├── profile.jpg                 # Your profile photo (400x400px recommended)
│   ├── profile_about.jpg           # About section photo (300x300px)
│   ├── forum_app.png               # Forum project screenshot
│   ├── food_delivery_app.png       # Food delivery project screenshot  
│   ├── ecommerce_dashboard.png     # E-commerce dashboard screenshot
│   ├── portfolio_website.png       # Portfolio project screenshot
│   └── placeholder_project.png     # Placeholder for new projects
└── certificates/
    ├── flutter_certificate.pdf     # Flutter certification
    ├── javascript_certificate.pdf  # JavaScript certification
    ├── database_certificate.pdf    # Database certification
    ├── degree_certificate.pdf      # University degree
    └── python_certificate.pdf      # Python certification
```

## 📸 Image Guidelines

### Profile Images
- **Format**: JPG, PNG, or WebP
- **Size**: 400x400px (square format)
- **File Size**: < 500KB for web performance
- **Background**: Professional, plain background preferred

### Project Screenshots
- **Format**: PNG (for screenshots with transparency)
- **Size**: 1200x800px (landscape format)
- **File Size**: < 1MB each
- **Content**: Clear view of your project interface

## 📄 Certificate Guidelines

### PDF Requirements
- **Format**: PDF only
- **File Size**: < 5MB per certificate
- **Quality**: High resolution, text should be readable
- **Security**: Ensure no sensitive information is exposed

## 🔄 How to Add Your Assets

### 1. Profile Images
```dart
// Replace in hero_section.dart (line ~289)
decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/profile.jpg'), // Add your image here
    fit: BoxFit.cover,
  ),
),

// Replace in about_section.dart (line ~125)  
decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/profile_about.jpg'), // Add your image here
    fit: BoxFit.cover,
  ),
),
```

### 2. Project Images
```dart
// Update in projects_section.dart in your project data
{
  'title': 'Your Project',
  'image': 'assets/images/your_project.png', // Add your project image
  // ... other project data
},
```

### 3. Certificate PDFs
```dart
// Update in certificates_section.dart in your certificate data
{
  'title': 'Your Certificate',
  'pdfUrl': 'assets/certificates/your_certificate.pdf', // Add your PDF
  // ... other certificate data
},
```

## 📋 Asset Checklist

Before launching your portfolio:

### Images Needed:
- [ ] Profile photo (main)
- [ ] Profile photo (about section) 
- [ ] Forum app screenshot
- [ ] Food delivery app screenshot
- [ ] E-commerce dashboard screenshot
- [ ] Portfolio website screenshot
- [ ] Any additional project screenshots

### Certificates Needed:
- [ ] Flutter development certificate
- [ ] JavaScript fundamentals certificate  
- [ ] Database management certificate
- [ ] University degree certificate
- [ ] Python programming certificate
- [ ] Any additional certifications

## 🎨 Image Optimization Tips

### Before Adding Images:
1. **Resize**: Use online tools like TinyPNG or Photoshop
2. **Compress**: Reduce file size without losing quality
3. **Format**: Use WebP for better compression (optional)
4. **Naming**: Use descriptive, lowercase names with underscores

### Recommended Tools:
- **TinyPNG**: For compressing images
- **Canva**: For creating professional photos
- **GIMP/Photoshop**: For advanced editing
- **Online Converters**: For format conversion

## 🔧 Adding New Assets

### Step 1: Add Files
1. Place your files in the appropriate folders
2. Use descriptive names (e.g., `react_project_screenshot.png`)

### Step 2: Update Code
1. Reference the new asset path in your widget files
2. Update the file paths in your data structures

### Step 3: Update pubspec.yaml (if needed)
```yaml
flutter:
  assets:
    - assets/images/
    - assets/certificates/
    # Add new folders here if needed
```

### Step 4: Test
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

## ⚠️ Important Notes

1. **Copyright**: Only use images you own or have permission to use
2. **Privacy**: Ensure personal information in certificates is appropriate for public viewing
3. **File Size**: Keep total asset size under 50MB for fast loading
4. **Backup**: Keep original high-resolution versions of your files
5. **Naming**: Avoid spaces and special characters in file names

## 📞 Need Help?

If you need help with image preparation or have questions:

**Mohammed Alhemyari**
- 📧 Email: samehing211@gmail.com
- 📱 Phone: +967773468708
- 💼 LinkedIn: [Mohammed Alhemyari](https://www.linkedin.com/in/mohammed-alhemyari-bb0352248/)

---

**Ready to make your portfolio shine! ✨**