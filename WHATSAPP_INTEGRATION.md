# WhatsApp Integration Guide

## ✅ Implementation Complete

The WhatsApp integration feature has been successfully implemented across the app.

---

## 📦 Package Added

```yaml
dependencies:
  url_launcher: ^6.3.1
```

This package allows opening external URLs, including WhatsApp deep links.

---

## 🛠️ Components Created

### 1. **WhatsApp Launcher Utility**
**File:** `lib/core/utils/whatsapp_launcher.dart`

Provides two main functions:

#### `openWhatsApp()`
Opens WhatsApp with a pre-filled message.

```dart
await WhatsAppLauncher.openWhatsApp(
  phoneNumber: '201234567890',  // Without + or spaces
  message: 'Hello!',             // Optional
);
```

#### `openForCourseSubscription()`
Specialized function for course subscription inquiries.

```dart
await WhatsAppLauncher.openForCourseSubscription(
  phoneNumber: '201234567890',
  courseName: 'Advanced Programming',
  courseId: '123',
);
```

**Auto-generated message:**
```
Hello! I'm interested in subscribing to the course:
"Advanced Programming" (ID: 123).
Could you please provide more information?
```

---

### 2. **App Configuration**
**File:** `lib/core/constants/app_config.dart`

Centralized configuration for WhatsApp business number:

```dart
class AppConfig {
  static const String whatsappBusinessNumber = '201234567890';
  // Change this to your actual WhatsApp business number
}
```

---

## 📱 Integration Points

### 1. **Course Details Screen** (`course_screen.dart`)

When user taps "Contact via WhatsApp" button:
- ✅ Opens WhatsApp with course name (bilingual support)
- ✅ Includes course ID for reference
- ✅ Shows error message if WhatsApp is not installed

### 2. **Courses List Screen** (`courses_screen.dart`)

Each course card has a WhatsApp button:
- ✅ Green outlined button with WhatsApp color (#25D366)
- ✅ Opens with course information
- ✅ Error handling with user feedback

---

## 🎨 UI Implementation

### Course Details Page:
```
┌─────────────────────────────────┐
│  [Subscribe Button]             │  ← Payment Gateway
│                                 │
│  [Contact via WhatsApp]         │  ← WhatsApp Button
│   💬 Icon                       │
└─────────────────────────────────┘
```

### Courses List Page:
```
┌─────────────────────────────────┐
│  Course Card                    │
│  ┌──────────┐  ┌──────────┐    │
│  │ WhatsApp │  │Subscribe │    │
│  └──────────┘  └──────────┘    │
└─────────────────────────────────┘
```

---

## 🔧 Configuration

### Change WhatsApp Business Number:

**Option 1: Using AppConfig (Recommended)**
```dart
// lib/core/constants/app_config.dart
static const String whatsappBusinessNumber = 'YOUR_NUMBER_HERE';
```

**Option 2: Direct in Code**
```dart
const whatsappNumber = '201234567890';  // Replace in each screen
```

### Phone Number Format:
- ✅ **Correct:** `'201234567890'` (Country code + number, no spaces)
- ❌ **Wrong:** `'+20 123 456 7890'`
- ❌ **Wrong:** `'0123456789'` (without country code)

**Examples:**
- Egypt: `'201234567890'` (20 = country code)
- USA: `'11234567890'` (1 = country code)
- UK: `'441234567890'` (44 = country code)
- Saudi Arabia: `'966123456789'` (966 = country code)

---

## 🎯 Features

### ✅ **Error Handling**
- Checks if WhatsApp is installed
- Shows user-friendly error message
- Fallback to browser if direct launch fails

### ✅ **Bilingual Support**
- Uses Arabic course name if available
- Falls back to English name
- Maintains course identity in message

### ✅ **Context Awareness**
- Checks `context.mounted` before showing snackbar
- Prevents errors during navigation

### ✅ **User Experience**
- Pre-filled message saves time
- Course information included automatically
- Professional message format

---

## 🔄 Flow Diagram

```
User taps WhatsApp button
         ↓
Get course name (Arabic/English)
         ↓
Format WhatsApp URL with message
         ↓
Try to open WhatsApp
         ↓
    ┌────────┴────────┐
    ↓                 ↓
Success          Failed
    ↓                 ↓
Opens           Show error
WhatsApp        message
```

---

## 📝 Message Template

When user taps WhatsApp button, the pre-filled message is:

```
Hello! I'm interested in subscribing to the course:
"[Course Name in Arabic or English]" (ID: [Course ID]).
Could you please provide more information?
```

**Example:**
```
Hello! I'm interested in subscribing to the course:
"البرمجة المتقدمة" (ID: 42).
Could you please provide more information?
```

---

## 🚀 Testing

### Desktop/Web:
Opens WhatsApp Web in browser

### Mobile:
Opens WhatsApp mobile app directly

### Error Scenarios:
- WhatsApp not installed → Shows error snackbar
- Invalid number → Shows error snackbar
- No internet → System handles it

---

## 🔒 Security Notes

- ✅ No sensitive data in URL
- ✅ Phone number stored in config (not hardcoded everywhere)
- ✅ User can cancel before sending message
- ✅ Message is pre-filled, not auto-sent

---

## 🎨 Customization

### Change Button Color:
```dart
// In courses_screen.dart
foregroundColor: Color(0xFF25D366),  // WhatsApp green
side: BorderSide(color: Color(0xFF25D366)),
```

### Change Message Template:
```dart
// In whatsapp_launcher.dart
final message = 'Your custom message here with $courseName';
```

### Add More Context:
```dart
// Add department, price, or other info to message
final message = 'Hello! I want to subscribe to $courseName '
                'from $departmentName department...';
```

---

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| **Android** | ✅ Full Support | Opens WhatsApp app |
| **iOS** | ✅ Full Support | Opens WhatsApp app |
| **Web** | ✅ Full Support | Opens WhatsApp Web |
| **Windows** | ✅ Full Support | Opens WhatsApp Web |
| **macOS** | ✅ Full Support | Opens WhatsApp Web |
| **Linux** | ✅ Full Support | Opens WhatsApp Web |

---

## 🐛 Troubleshooting

### Issue: Button doesn't open WhatsApp
**Solution:** Check phone number format (must include country code)

### Issue: Error message appears
**Solution:** Ensure WhatsApp is installed on the device

### Issue: Opens browser instead of app
**Solution:** Normal behavior on desktop, make sure WhatsApp is default handler on mobile

---

## 🔮 Future Enhancements

- [ ] Add WhatsApp number to course data (backend)
- [ ] Support multiple contact numbers per course
- [ ] Track WhatsApp inquiries (analytics)
- [ ] Add course price in message
- [ ] Support instructor-specific WhatsApp numbers
- [ ] Add language preference in message

---

## ✨ Summary

✅ WhatsApp integration is fully functional
✅ Works on all platforms (mobile, web, desktop)
✅ User-friendly error handling
✅ Bilingual support (Arabic/English)
✅ Easy to configure and customize
✅ Professional message templates
✅ Clean, maintainable code structure
