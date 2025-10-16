import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/multi_subject_selector_widget.dart';
import '../../../../../core/widgets/assignment_type_selector_widget.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../../../../core/utils/navigation_helper.dart';

class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<String> _selectedSubjects = [];
  AssignmentType? _selectedAssignmentType;
  bool _showSubjectError = false;
  bool _showTypeError = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _createAssignmentData() {
    // Calculate total price based on selected subjects
    final totalPrice = _calculateTotalPrice();
    
    // Generate assignment ID
    final assignmentId = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Calculate due date (7 days from now)
    final dueDate = DateTime.now().add(const Duration(days: 7));
    final dueDateString = '${dueDate.day}/${dueDate.month}/${dueDate.year}';
    
    return {
      'id': assignmentId,
      'title': _titleController.text.isNotEmpty ? _titleController.text : 'واجب جديد',
      'description': _descriptionController.text.isNotEmpty 
          ? _descriptionController.text 
          : 'لا يوجد وصف متاح',
      'subjects': _selectedSubjects,
      'type': _selectedAssignmentType,
      'status': 'In Progress',
      'dueDate': dueDateString,
      'totalPrice': totalPrice,
      'createdDate': DateTime.now().toIso8601String(),
      'grade': null,
      'submittedDate': null,
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

  void _addToCart() {
    setState(() {
      _showSubjectError = _selectedSubjects.isEmpty;
      _showTypeError = _selectedAssignmentType == null;
    });

    if (_formKey.currentState!.validate()) {
      if (_selectedSubjects.isEmpty) {
        return; // Error already shown via _showSubjectError
      }

      if (_selectedAssignmentType == null) {
        return; // Error already shown via _showTypeError
      }

      // Create assignment data
      final assignmentData = _createAssignmentData();
      
      // Here you would add the assignment to cart
      CustomToast.showSuccess(
        context,
        message: 'تم إضافة الواجب إلى العربة',
      );
      
      // Navigate to assignment details
      NavigationHelper.to(
        path: '/assignment/new',
        context: context,
        data: assignmentData,
      );
    }
  }

  void _saveAssignment() {
    setState(() {
      _showSubjectError = _selectedSubjects.isEmpty;
      _showTypeError = _selectedAssignmentType == null;
    });

    if (_formKey.currentState!.validate()) {
      if (_selectedSubjects.isEmpty) {
        return; // Error already shown via _showSubjectError
      }

      if (_selectedAssignmentType == null) {
        return; // Error already shown via _showTypeError
      }

      // Create assignment data
      final assignmentData = _createAssignmentData();
      
      // Here you would process payment for the assignment
      CustomToast.showSuccess(
        context,
        message: 'تم الدفع بنجاح! سيتم إنشاء الواجب قريباً',
      );
      
      // Navigate to assignment details
      NavigationHelper.to(
        path: '/assignment/new',
        context: context,
        data: assignmentData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(AppLocalizations.addAssignment)),
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

            // Assignment Type Selection
            AssignmentTypeSelectorWidget(
              selectedType: _selectedAssignmentType,
              onTypeChanged: (type) {
                setState(() {
                  _selectedAssignmentType = type;
                  _showTypeError = false; // Hide error when type is selected
                });
              },
              label: 'نوع الواجب',
              hasError: _showTypeError,
              errorText: _showTypeError ? 'يرجى اختيار نوع الواجب' : null,
            ),

            const SizedBox(height: 24),

            // Assignment Title (Optional)
            CustomTextField(
              controller: _titleController,
              label: 'عنوان الواجب',
              hintText: 'هل لديك عنوان للواجب ؟',
              prefixIcon: const Icon(Ionicons.document_text_outline),
              // No validator - title is optional
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
                      onPressed: _saveAssignment,
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
