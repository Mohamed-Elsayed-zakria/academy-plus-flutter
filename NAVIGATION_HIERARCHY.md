# Navigation Hierarchy Structure

## 📌 Updated Home Tab Structure

The Home Tab now implements a **3-level hierarchical structure** for better organization:

### Navigation Flow

```
Home Screen
    ↓
Departments (Main Categories)
    ↓
Sub-Departments
    ↓
Courses
    ↓
Course Details
    ↓
Course Content (After Subscription)
```

---

## 🏛️ Level 1: Main Departments

**Screen:** `home_screen.dart`

Displays 6 main department categories:

1. **Business**
   - Icon: business_center
   - Color: Indigo (#6366F1)
   - Sub-departments: Accounting, Marketing, Finance, HR

2. **Engineering**
   - Icon: engineering
   - Color: Purple (#8B5CF6)
   - Sub-departments: Computer Science, Electrical, Mechanical, Civil

3. **Medicine**
   - Icon: medical_services
   - Color: Pink (#EC4899)
   - Sub-departments: General Medicine, Surgery, Pediatrics, Cardiology

4. **Arts**
   - Icon: palette
   - Color: Orange (#F59E0B)
   - Sub-departments: Fine Arts, Music, Theater, Literature

5. **Science**
   - Icon: science
   - Color: Green (#10B981)
   - Sub-departments: Physics, Chemistry, Biology, Mathematics

6. **Law**
   - Icon: gavel
   - Color: Red (#EF4444)
   - Sub-departments: Criminal Law, Civil Law, International Law, Corporate Law

---

## 📂 Level 2: Sub-Departments

**Screen:** `sub_departments_screen.dart`

- Shows all sub-departments within the selected main department
- Each sub-department card displays:
  - Folder icon with department color
  - Sub-department name
  - Arrow navigation indicator
- Clicking navigates to courses within that sub-department

---

## 📚 Level 3: Courses

**Screen:** `courses_screen.dart`

Displays all courses within the selected sub-department.

### Course Card Features:

#### 1. **Cover Image**
   - Gradient background using department color
   - Free intro video play button (centered, white circle)
   - "Free Preview" badge (top-right corner)

#### 2. **Course Information**
   - **Bilingual Course Name:**
     - Arabic name (primary, RTL)
     - English name (secondary, smaller font)
   - **Instructor:** Name with person icon
   - **Price Display:**
     - Original price (strikethrough if discounted)
     - Discounted price (large, green)
     - Discount badge (e.g., "20% OFF")

#### 3. **Subscription Options** (Dynamic)
   The buttons shown depend on course configuration:

   - **WhatsApp Only:** Shows WhatsApp button
   - **Payment Gateway Only:** Shows Subscribe button
   - **Both:** Shows both buttons side by side

   **WhatsApp Button:**
   - Outlined style
   - Green color (#25D366)
   - Chat icon

   **Subscribe Button:**
   - Filled style
   - Primary color
   - Payment icon

---

## 🎓 Level 4: Course Details

**Screen:** `course_screen.dart`

### Features:
- **Cover Image:** Large gradient with play button overlay
- **Free Preview Badge**
- **Bilingual Course Title:**
  - Arabic (main, RTL)
  - English (subtitle)
- **Instructor Info:** Avatar + name
- **Price Section:**
  - Original & discounted prices
  - Discount percentage badge
- **Description:** "About this course" section
- **Subscription Buttons:**
  - Conditionally shown based on `hasWhatsApp` and `hasPaymentGateway` flags
  - WhatsApp opens chat
  - Subscribe navigates to course content

---

## 📖 Level 5: Course Content

**Screen:** `course_content_screen.dart`

**6 Tabbed Sections:**
1. Midterm Lectures
2. Final Lectures
3. Midterm Exam Solutions
4. Final Exam Solutions
5. Attachments
6. Test Yourself (Quizzes)

---

## 🛤️ Routing Structure

### Updated Routes:

```dart
// Level 1: Main Departments
GET /main → Shows Home with main departments

// Level 2: Sub-Departments
GET /department/:id → Shows sub-departments
    Extra: department object {id, name, icon, color, subDepartments}

// Level 3: Courses
GET /subdepartment/:deptId/:subDeptId/courses → Shows courses
    Extra: {departmentName, subDepartmentName, color}

// Level 4: Course Details
GET /course/:id → Shows course details
    Extra: course object {id, nameAr, nameEn, instructor, price, discount, hasWhatsApp, hasPaymentGateway}

// Level 5: Course Content
GET /course/:id/content → Shows course content (after subscription)
```

---

## 📊 Data Structure

### Department Object:
```dart
{
  'id': 1,
  'name': 'Business',
  'icon': Icons.business_center,
  'color': Color(0xFF6366F1),
  'subDepartments': ['Accounting', 'Marketing', 'Finance', 'HR']
}
```

### Course Object:
```dart
{
  'id': 0,
  'nameAr': 'مقدمة في المحاسبة',  // Arabic name
  'nameEn': 'Introduction to Accounting',  // English name
  'instructor': 'Dr. John Doe',
  'price': 299.99,
  'discount': 20,
  'image': 'url',
  'hasWhatsApp': true,  // Show WhatsApp button
  'hasPaymentGateway': true,  // Show Subscribe button
}
```

---

## 🎨 UI/UX Features

✅ **Bilingual Support:** Arabic (RTL) and English course names
✅ **Dynamic Subscription Options:** WhatsApp, Payment Gateway, or Both
✅ **Free Preview:** Prominent badge and play button
✅ **Color-Coded:** Each department has unique color scheme
✅ **Modern Cards:** Rounded corners, shadows, gradients
✅ **Smooth Navigation:** Hierarchical flow with breadcrumb-like experience

---

## 🚀 Next Steps (Backend Integration)

When connecting to backend:
1. Fetch departments from API
2. Fetch sub-departments for selected department
3. Fetch courses for selected sub-department
4. Course data should include:
   - `nameAr` and `nameEn` fields
   - `hasWhatsApp` and `hasPaymentGateway` boolean flags
   - Free preview video URL
   - Instructor details
   - Pricing information
