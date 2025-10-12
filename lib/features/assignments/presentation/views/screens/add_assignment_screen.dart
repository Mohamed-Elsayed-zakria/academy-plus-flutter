import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/date_picker_widget.dart';

class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String? _selectedSubject;
  DateTime? _selectedDate;
  
  // Mock subjects list - in real app this would come from a service
  final List<String> _subjects = [
    'البرمجة المتقدمة',
    'قواعد البيانات',
    'تطوير الويب',
    'هياكل البيانات',
    'تطوير التطبيقات المحمولة',
    'الذكاء الاصطناعي',
    'أمن المعلومات',
    'الرياضيات',
    'الفيزياء',
    'الكيمياء',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _selectSubject() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.selectSubject),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _subjects.length,
            itemBuilder: (context, index) {
              final subject = _subjects[index];
              return ListTile(
                title: Text(subject),
                onTap: () {
                  setState(() {
                    _selectedSubject = subject;
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.cancel),
          ),
        ],
      ),
    );
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

  void _saveAssignment() {
    if (_formKey.currentState!.validate()) {
      if (_selectedSubject == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.pleaseSelectSubject)),
        );
        return;
      }
      
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.pleaseSelectDate)),
        );
        return;
      }

      // Here you would save the assignment to your backend
      // For now, we'll just go back
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.addAssignment),
        actions: [
          TextButton(
            onPressed: _saveAssignment,
            child: Text(
              AppLocalizations.save,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Subject Selection
            _buildSectionTitle(AppLocalizations.subject),
            const SizedBox(height: 8),
            InkWell(
              onTap: _selectSubject,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Ionicons.book_outline,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedSubject ?? AppLocalizations.selectSubject,
                        style: TextStyle(
                          color: _selectedSubject != null 
                              ? AppColors.textPrimary 
                              : AppColors.textSecondary,
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
            
            const SizedBox(height: 24),
            
            // Assignment Title
            _buildSectionTitle(AppLocalizations.assignmentTitle),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _titleController,
              hintText: AppLocalizations.assignmentTitle,
              prefixIcon: const Icon(Ionicons.document_text_outline),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.pleaseEnterTitle;
                }
                return null;
              },
            ),
            
            const SizedBox(height: 24),
            
            // Description (Optional)
            _buildSectionTitle(AppLocalizations.description),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _descriptionController,
              hintText: AppLocalizations.description,
              prefixIcon: const Icon(Ionicons.text_outline),
              // No validator - description is optional
            ),
            
            const SizedBox(height: 24),
            
            // Due Date (Required)
            _buildSectionTitle(AppLocalizations.dueDate),
            const SizedBox(height: 8),
            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                            : AppLocalizations.dueDate,
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
            
            const SizedBox(height: 32),
            
            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveAssignment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.save,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}
