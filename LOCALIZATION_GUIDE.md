# التطبيق متعدد اللغات - Academy Plus

## نظرة عامة
تم إعداد التطبيق ليدعم اللغتين العربية والإنجليزية باستخدام `easy_localization`.

## الملفات المهمة

### ملفات الترجمة
- `assets/translations/en.json` - النصوص الإنجليزية
- `assets/translations/ar.json` - النصوص العربية

### ملفات المساعدة
- `lib/core/localization/app_localizations.dart` - مساعد الترجمة الرئيسي
- `lib/core/localization/app_localization_config.dart` - إعدادات الترجمة

## كيفية الاستخدام

### 1. استخدام النصوص المترجمة
```dart
import '../../../../../core/localization/app_localizations.dart';

// استخدام النصوص
Text(AppLocalizations.appName)
Text(AppLocalizations.welcome)
Text(AppLocalizations.login)
```

### 2. استخدام easy_localization مباشرة
```dart
import 'package:easy_localization/easy_localization.dart';

// استخدام النصوص
Text('app_name'.tr())
Text('welcome'.tr())
Text('login'.tr())
```

### 3. التحقق من اللغة الحالية
```dart
import '../../../../../core/localization/app_localization_config.dart';

// التحقق من اللغة
if (AppLocalizationConfig.isArabic(context)) {
  // كود للعربية
} else {
  // كود للإنجليزية
}
```

### 4. الحصول على اتجاه النص
```dart
import '../../../../../core/localization/localization_helper.dart';

// الحصول على اتجاه النص
TextDirection direction = LocalizationHelper.getTextDirection(context);

// الحصول على المحاذاة
Alignment alignment = LocalizationHelper.getAlignment(context);
```

## إضافة نصوص جديدة

### 1. إضافة المفتاح في ملفات JSON
في `assets/translations/en.json`:
```json
{
  "new_key": "New Text in English"
}
```

في `assets/translations/ar.json`:
```json
{
  "new_key": "نص جديد بالعربية"
}
```

### 2. إضافة المفتاح في AppLocalizations
في `lib/core/localization/app_localizations.dart`:
```dart
static String get newKey => 'new_key'.tr();
```

### 3. استخدام النص الجديد
```dart
Text(AppLocalizations.newKey)
```

## الميزات المدعومة

### ✅ تم تنفيذها
- دعم اللغة العربية والإنجليزية
- ملفات ترجمة منفصلة
- مساعدات للترجمة
- إعدادات الترجمة
- دعم اتجاه النص (RTL/LTR)
- مساعدات للمحاذاة والتخطيط

### 🔄 قيد التطوير
- تبديل اللغة من داخل التطبيق
- حفظ تفضيلات اللغة
- ترجمة ديناميكية

## ملاحظات مهمة

1. **اللغة الافتراضية**: الإنجليزية
2. **اللغة الاحتياطية**: الإنجليزية
3. **مسار ملفات الترجمة**: `assets/translations/`
4. **تنسيق الملفات**: JSON

## استكشاف الأخطاء

### مشكلة: النصوص لا تظهر
- تأكد من إضافة المفتاح في كلا الملفين (en.json و ar.json)
- تأكد من إضافة المفتاح في AppLocalizations
- تأكد من استيراد AppLocalizations

### مشكلة: اتجاه النص خاطئ
- استخدم LocalizationHelper.getTextDirection(context)
- تأكد من استخدام المحاذاة الصحيحة

### مشكلة: التطبيق لا يبدأ
- تأكد من إضافة مجلد assets/translations في pubspec.yaml
- تأكد من صحة تنسيق ملفات JSON
- تأكد من استيراد AppLocalizationConfig في main.dart

## التطوير المستقبلي

1. **إضافة لغات جديدة**: أضف ملف JSON جديد وحدد Locale جديد
2. **ترجمة ديناميكية**: استخدام API للترجمة
3. **حفظ تفضيلات اللغة**: استخدام SharedPreferences
4. **تبديل اللغة**: إضافة واجهة مستخدم للتبديل بين اللغات

