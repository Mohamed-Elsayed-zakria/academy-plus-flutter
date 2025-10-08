# University App - Project Structure

This is a modern educational mobile app built with Flutter, focusing on UI/UX design with no backend integration at this stage.

## 📁 Project Structure

```
lib/
│
├── core/                      # Core utilities and shared resources
│   ├── constants/             # App-wide constants
│   │   ├── app_colors.dart    # Color palette
│   │   └── app_strings.dart   # String constants
│   ├── theme/                 # App theme configuration
│   │   └── app_theme.dart     # Material theme setup
│   └── widgets/               # Reusable widgets
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── empty_state.dart
│
├── features/                  # Feature-based modules
│   ├── splash/                # Splash & Welcome screens
│   │   └── presentation/views/screens/
│   │       ├── splash_screen.dart
│   │       └── welcome_screen.dart
│   │
│   ├── auth/                  # Authentication screens
│   │   └── presentation/views/screens/
│   │       ├── login_screen.dart
│   │       ├── register_screen.dart
│   │       └── otp_screen.dart
│   │
│   ├── home/                  # Home and course screens
│   │   └── presentation/views/screens/
│   │       ├── main_screen.dart
│   │       ├── home_screen.dart
│   │       ├── department_screen.dart
│   │       ├── course_screen.dart
│   │       └── course_content_screen.dart
│   │
│   ├── notifications/         # Notifications screen
│   │   └── presentation/views/screens/
│   │       └── notifications_screen.dart
│   │
│   ├── subscriptions/         # Subscriptions screen
│   │   └── presentation/views/screens/
│   │       └── subscriptions_screen.dart
│   │
│   └── profile/               # Profile screens
│       └── presentation/views/screens/
│           ├── profile_screen.dart
│           └── edit_profile_screen.dart
│
├── routes/                    # Navigation configuration
│   └── app_routes.dart        # GoRouter configuration
│
├── routes.dart                # Routes export file
└── main.dart                  # App entry point
```

## 🎨 Features Implemented

### ✅ Authentication Flow
- **Splash Screen** - Animated logo with fade and scale animations
- **Welcome Screen** - Gradient background with login/register buttons
- **Login Screen** - Phone number and password input
- **Register Screen** - Full name, phone, university dropdown, profile image upload
- **OTP Verification** - Modern PIN code input using Pinput package

### ✅ Main Navigation
- **Bottom Navigation Bar** - Custom animated navigation with 4 tabs:
  - Home
  - Notifications
  - Subscriptions
  - Profile

### ✅ Home Tab
- Search bar
- Auto-sliding banner carousel
- Quick access cards (Assignments & Quizzes)
- Department grid with modern cards
- Department courses list
- Course details page with:
  - Cover image with free preview indicator
  - Instructor information
  - Price with discount display
  - Subscribe and WhatsApp contact buttons

### ✅ Course Content (After Subscription)
- **Tabbed Interface** with 6 sections:
  - Midterm Lectures (expandable with video player)
  - Final Lectures (expandable with video player)
  - Midterm Exam Solutions
  - Final Exam Solutions
  - Attachments (with file type icons)
  - Test Yourself (quizzes)

### ✅ Other Screens
- **Notifications** - Card-style with read/unread states and type icons
- **Subscriptions** - Active/completed subscriptions with progress bars
- **Profile** - User info display with action buttons
- **Edit Profile** - Update user information

## 📦 Dependencies

- `go_router: ^14.6.2` - Declarative routing
- `carousel_slider: ^5.0.0` - Image carousel
- `pinput: ^5.0.0` - OTP input
- `image_picker: ^1.1.2` - Profile image selection
- `flutter_svg: ^2.0.16` - SVG support
- `google_fonts: ^6.2.1` - Custom fonts

## 🎨 Design System

### Colors
- **Primary**: Indigo (#6366F1)
- **Accent**: Green (#10B981)
- **Secondary Accents**: Orange, Purple
- **Background**: Light gray (#F9FAFB)
- **Surface**: White (#FFFFFF)

### Typography
- **Font Family**: Inter (via Google Fonts)
- Modern, clean, and student-friendly design

### UI Components
- Rounded corners (16px border radius)
- Soft shadows
- Gradient buttons
- Smooth animations and transitions

## 🚀 Navigation Flow

```
Splash → Welcome → Login/Register → OTP → Main Screen
                                              ├─ Home
                                              ├─ Notifications
                                              ├─ Subscriptions
                                              └─ Profile → Edit Profile
```

## 📱 Running the App

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 🔮 Future Enhancements

This is the UI-only version. Future additions will include:
- Backend integration (API calls)
- State management (Cubit/Bloc)
- Repository pattern
- Data models
- Video player integration
- PDF viewer for attachments
- Push notifications
- Payment gateway integration
- WhatsApp integration
