import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/multi_subject_selector_widget.dart';
import '../../../../../core/widgets/assignment_type_selector_widget.dart';
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

      // Here you would add the assignment to cart
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إضافة الواجب إلى العربة'),
          backgroundColor: Colors.green,
        ),
      );
      NavigationHelper.back(context);
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

      // Here you would process payment for the assignment
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم الدفع بنجاح! سيتم إنشاء الواجب قريباً'),
          backgroundColor: Colors.green,
        ),
      );
      NavigationHelper.back(context);
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
