# دليل التخصيص - بورتفوليو محمد الحميري

## 📋 أماكن التعديل الأساسية

### 1. المعلومات الشخصية

#### القسم الرئيسي (Hero Section)
**الملف**: `lib/widgets/hero_section.dart`

```dart
// تغيير الاسم والمسمى الوظيفي
Text('محمد الحميري'), // اكتب اسمك هنا
TypewriterAnimatedText('مطور فلاتر'), // اكتب مسماك الوظيفي
```

**الأماكن المحددة للتعديل:**
- **السطر 196**: اكتب اسمك
- **السطر 208-230**: اكتب مسمياتك الوظيفية
- **السطر 244**: اكتب نبذة عنك
- **السطر 331-338**: أضف روابط حساباتك الشخصية

#### قسم نبذة عني (About Section)  
**الملف**: `lib/widgets/about_section.dart`

**الأماكن المحددة للتعديل:**
- **السطر 149**: اكتب اسمك
- **السطر 167**: اكتب مسماك الوظيفي  
- **السطر 177-183**: أضف معلومات الاتصال
- **السطر 229-249**: اكتب قصتك المهنية
- **السطر 38-57**: حدث الإحصائيات (سنوات الخبرة، المشاريع، إلخ)

### 2. المهارات والتقنيات

**الملف**: `lib/widgets/skills_section.dart`

#### لغات البرمجة
**السطر 22-57**: أضف/عدل لغات البرمجة مع مستوى الإتقان

```dart
{
  'name': 'Dart', // اسم اللغة
  'level': 90,    // مستوى الإتقان (0-100)
  'experience': '2+ years', // سنوات الخبرة
},
```

#### الإطارات والتقنيات
**السطر 59-88**: أضف/عدل الإطارات والتقنيات

```dart
{
  'name': 'Flutter', // اسم الإطار
  'level': 90,       // مستوى الإتقان
  'description': 'وصف التقنية', // وصف مختصر
},
```

### 3. المشاريع

**الملف**: `lib/widgets/projects_section.dart`

**السطر 24-108**: أضف/عدل مشاريعك

```dart
{
  'title': 'اسم المشروع',
  'description': 'وصف المشروع...',
  'technologies': ['Flutter', 'Firebase'], // التقنيات المستخدمة
  'image': 'assets/images/project1.png', // مسار الصورة - TODO: أضف صورة المشروع
  'githubUrl': 'https://github.com/username/project', // TODO: أضف رابط GitHub
  'demoUrl': 'https://demo-url.com', // TODO: أضف رابط العرض التوضيحي
  'category': 'Mobile App', // نوع المشروع
  'status': 'Completed', // حالة المشروع
  'features': [ // مميزات المشروع
    'الميزة الأولى',
    'الميزة الثانية',
  ],
},
```

### 4. الشهادات

**الملف**: `lib/widgets/certificates_section.dart`

**السطر 23-85**: أضف/عدل شهادتك

```dart
{
  'title': 'اسم الشهادة',
  'issuer': 'الجهة المانحة',
  'date': '2023',
  'description': 'وصف الشهادة...',
  'pdfUrl': 'assets/certificates/certificate.pdf', // TODO: أضف ملف PDF
  'credentialId': 'رقم الشهادة',
  'category': 'Mobile Development', // تصنيف الشهادة
  'skills': ['المهارة 1', 'المهارة 2'], // المهارات المكتسبة
  'verificationUrl': 'رابط التحقق', // TODO: أضف رابط التحقق
},
```

### 5. معلومات الاتصال

**الملف**: `lib/widgets/contact_section.dart`

**السطر 26-56**: حدث معلومات الاتصال

```dart
{
  'title': 'البريد الإلكتروني',
  'value': 'your-email@example.com', // TODO: ضع بريدك الإلكتروني
  'url': 'mailto:your-email@example.com',
},
```

## 🖼️ إضافة الصور

### 1. الصورة الشخصية
- أضف صورتك الشخصية في: `assets/images/profile.jpg`
- **المواقع المطلوب تحديثها:**
  - `lib/widgets/hero_section.dart` - السطر 289 (TODO comment)
  - `lib/widgets/about_section.dart` - السطر 125 (TODO comment)

### 2. صور المشاريع
- أضف صور مشاريعك في: `assets/images/`
- حدث مسارات الصور في بيانات المشاريع

### 3. شهادات PDF
- أضف ملفات PDF للشهادات في: `assets/certificates/`
- حدث مسارات PDF في بيانات الشهادات

## 🎨 تخصيص الألوان

**الملف**: `lib/constants/colors.dart`

```dart
// غير الألوان حسب ذوقك
static const Color primary = Color(0xFF2196F3); // اللون الأساسي
static const Color secondary = Color(0xFF00BCD4); // اللون الثانوي  
static const Color accent = Color(0xFFFFC107); // لون التمييز
```

## 📝 قائمة المهام للإكمال

عند استخدام هذا البورتفوليو، تحتاج لتنفيذ:

### ✅ جاهز للاستخدام:
- [x] التصميم والشكل العام
- [x] الانيميشن والتأثيرات
- [x] التجاوب مع جميع الأجهزة
- [x] النماذج والتخطيط

### 🔄 يحتاج إضافة:
- [ ] **الصور الشخصية**: أضف صورتك في `assets/images/`
- [ ] **صور المشاريع**: أضف صور مشاريعك 
- [ ] **ملفات PDF للشهادات**: أضف شهاداتك
- [ ] **روابط GitHub**: حدث روابط مشاريعك
- [ ] **روابط العرض التوضيحي**: أضف روابط المشاريع المباشرة
- [ ] **عارض PDF**: تنفيذ عارض PDF للشهادات
- [ ] **نموذج الاتصال**: ربط النموذج بخدمة إرسال البريد
- [ ] **Google Analytics**: إضافة تتبع الزوار
- [ ] **تحسين SEO**: إضافة meta tags

## 🚀 كيفية التشغيل

1. **تثبيت Flutter**: اتبع دليل تثبيت Flutter
2. **تحميل المكتبات**:
   ```bash
   flutter pub get
   ```
3. **تشغيل المشروع**:
   ```bash
   flutter run -d chrome
   ```
4. **بناء للإنتاج**:
   ```bash
   flutter build web
   ```

## 📞 للمساعدة والدعم

إذا احتجت مساعدة في التخصيص:

**محمد الحميري**
- 📧 البريد: samehing211@gmail.com  
- 📱 الهاتف: +967773468708
- 💼 LinkedIn: [Mohammed Alhemyari](https://www.linkedin.com/in/mohammed-alhemyari-bb0352248/)
- 🐱 GitHub: [ShiroYasha211](https://github.com/ShiroYasha211)

---

**تم البناء بـ ❤️ باستخدام Flutter**