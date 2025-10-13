import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/date_picker_widget.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/subject_selector_widget.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _adminUsernameController = TextEditingController();
  final _adminPasswordController = TextEditingController();
  
  String? _selectedSubject;
  DateTime? _selectedDate;
  bool _showSubjectError = false;
  
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
    _adminUsernameController.dispose();
    _adminPasswordController.dispose();
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
                    _showSubjectError = false; // Hide error when subject is selected
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

  void _saveQuiz() {
    setState(() {
      _showSubjectError = _selectedSubject == null;
    });
    
    if (_formKey.currentState!.validate()) {
      if (_selectedSubject == null) {
        return; // Error already shown via _showSubjectError
      }
      
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.pleaseSelectDate)),
        );
        return;
      }

      // Here you would save the quiz to your backend
      // For now, we'll just go back
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.addQuiz),
        actions: [
          TextButton(
            onPressed: _saveQuiz,
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
            SubjectSelectorWidget(
              selectedSubject: _selectedSubject,
              onTap: _selectSubject,
              label: AppLocalizations.subject,
              hasError: _showSubjectError,
              errorText: _showSubjectError ? AppLocalizations.pleaseSelectSubject : null,
            ),
            
            const SizedBox(height: 24),
            
            // Quiz Title
            CustomTextField(
              controller: _titleController,
              label: AppLocalizations.quizTitle,
              hintText: AppLocalizations.quizTitle,
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
            CustomTextField(
              controller: _descriptionController,
              label: AppLocalizations.description,
              hintText: AppLocalizations.description,
              prefixIcon: const Icon(Ionicons.text_outline),
              // No validator - description is optional
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
            
            // Admin Credentials Section
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
                        Ionicons.shield_checkmark_outline,
                        color: AppColors.accent,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'بيانات الأدمن',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'أدخل بيانات حسابك في المنصة لربط الاختبار',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Admin Username
                  CustomTextField(
                    controller: _adminUsernameController,
                    label: AppLocalizations.adminUsername,
                    hintText: AppLocalizations.adminUsername,
                    prefixIcon: const Icon(Ionicons.person_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.pleaseEnterAdminUsername;
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Admin Password
                  CustomTextField(
                    controller: _adminPasswordController,
                    label: AppLocalizations.adminPassword,
                    hintText: AppLocalizations.adminPassword,
                    prefixIcon: const Icon(Ionicons.lock_closed_outline),
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.pleaseEnterAdminPassword;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Save Button
            CustomButton(
              text: AppLocalizations.save,
              onPressed: _saveQuiz,
              width: double.infinity,
              icon: const Icon(
                Ionicons.save_outline,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
