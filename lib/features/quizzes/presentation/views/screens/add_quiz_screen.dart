import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/date_picker_widget.dart';
import '../../../../../core/widgets/multi_subject_selector_widget.dart';
import '../../../../../core/utils/navigation_helper.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  List<String> _selectedSubjects = [];
  DateTime? _selectedDate;
  bool _showSubjectError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _createQuizData() {
    // Calculate total price based on selected subjects
    final totalPrice = _calculateTotalPrice();
    
    // Generate quiz ID
    final quizId = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Calculate deadline (1 day before quiz date)
    final deadline = _selectedDate!.subtract(const Duration(days: 1));
    final deadlineString = '${deadline.day}/${deadline.month}/${deadline.year}';
    
    // Format quiz date
    final quizDateString = '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    
    return {
      'id': quizId,
      'title': 'اختبار جديد',
      'description': 'لا يوجد وصف متاح',
      'subjects': _selectedSubjects,
      'status': 'Available',
      'questions': 10, // Default number of questions
      'duration': 30, // Default duration in minutes
      'attempts': 0,
      'bestScore': null,
      'deadline': deadlineString,
      'quizDate': quizDateString,
      'totalPrice': totalPrice,
      'username': _usernameController.text,
      'createdDate': DateTime.now().toIso8601String(),
    };
  }

  double _calculateTotalPrice() {
    // Mock courses data with prices - same as in MultiSubjectSelectorWidget
    final courses = [
      {'name': 'البرمجة المتقدمة', 'price': 299, 'discount': 20},
      {'name': 'قواعد البيانات', 'price': 249, 'discount': 15},
      {'name': 'تطوير الويب', 'price': 199, 'discount': 25},
      {'name': 'هياكل البيانات', 'price': 179, 'discount': 10},
      {'name': 'تطوير التطبيقات المحمولة', 'price': 399, 'discount': 30},
      {'name': 'الذكاء الاصطناعي', 'price': 349, 'discount': 20},
      {'name': 'أمن المعلومات', 'price': 279, 'discount': 15},
      {'name': 'الرياضيات', 'price': 149, 'discount': 10},
      {'name': 'الفيزياء', 'price': 159, 'discount': 12},
      {'name': 'الكيمياء', 'price': 169, 'discount': 8},
    ];

    double total = 0.0;
    for (final subject in _selectedSubjects) {
      final course = courses.firstWhere((c) => c['name'] == subject);
      final originalPrice = course['price'] as int;
      final discount = course['discount'] as int;
      final discountedPrice = originalPrice - (originalPrice * discount / 100);
      total += discountedPrice;
    }
    
    return total;
  }

  void _selectDate() async {
    final date = await DatePickerWidget.showCustomDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _addToCart() {
    setState(() {
      _showSubjectError = _selectedSubjects.isEmpty;
    });

    if (_formKey.currentState!.validate()) {
      if (_selectedSubjects.isEmpty) {
        return; // Error already shown via _showSubjectError
      }

      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.pleaseSelectDate)),
        );
        return;
      }

      // Create quiz data
      final quizData = _createQuizData();
      
      // Here you would add the quiz to cart
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إضافة الاختبار إلى العربة'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate to quiz details
      NavigationHelper.to(
        path: '/quiz/new',
        context: context,
        data: quizData,
      );
    }
  }

  void _saveQuiz() {
    setState(() {
      _showSubjectError = _selectedSubjects.isEmpty;
    });

    if (_formKey.currentState!.validate()) {
      if (_selectedSubjects.isEmpty) {
        return; // Error already shown via _showSubjectError
      }

      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.pleaseSelectDate)),
        );
        return;
      }

      // Create quiz data
      final quizData = _createQuizData();
      
      // Here you would process payment for the quiz
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم الدفع بنجاح! سيتم إنشاء الاختبار قريباً'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate to quiz details
      NavigationHelper.to(
        path: '/quiz/new',
        context: context,
        data: quizData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(AppLocalizations.addQuiz)),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            // Subject Selection
            MultiSubjectSelectorWidget(
              selectedSubjects: _selectedSubjects,
              onSubjectsChanged: (subjects) {
                setState(() {
                  _selectedSubjects = subjects;
                  _showSubjectError =
                      false; // Hide error when subjects are selected
                });
              },
              label: AppLocalizations.subject,
              hasError: _showSubjectError,
              errorText: _showSubjectError
                  ? AppLocalizations.pleaseSelectSubject
                  : null,
            ),

            const SizedBox(height: 24),

            // Quiz Date (Required)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.quizDate,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _selectDate,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.textTertiary),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.calendar_outline,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedDate != null
                                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                : AppLocalizations.quizDate,
                            style: TextStyle(
                              color: _selectedDate != null
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(
                          Ionicons.chevron_down_outline,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // User Credentials Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Ionicons.person_circle_outline,
                        color: AppColors.accent,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'بيانات المستخدم',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'أدخل بيانات حسابك لربط الاختبار',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Username
                  CustomTextField(
                    controller: _usernameController,
                    label: 'اسم المستخدم',
                    hintText: 'اسم المستخدم',
                    prefixIcon: const Icon(Ionicons.person_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال اسم المستخدم';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password
                  CustomTextField(
                    controller: _passwordController,
                    label: 'كلمة المرور',
                    hintText: 'كلمة المرور',
                    prefixIcon: const Icon(Ionicons.lock_closed_outline),
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال كلمة المرور';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Payment Buttons Row
            Row(
              children: [
                // Add to Cart Button
                Expanded(
                  child: SizedBox(
                    height: 58,
                    child: CustomButton(
                      isOutlined: true,
                      text: 'أضف إلى العربة',
                      onPressed: _addToCart,
                      icon: const Icon(Ionicons.cart_outline),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Pay Now Button
                Expanded(
                  child: SizedBox(
                    height: 58,
                    child: CustomButton(
                      isGradient: true,
                      text: 'ادفع الآن',
                      onPressed: _saveQuiz,
                      icon: const Icon(Ionicons.card_outline),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
