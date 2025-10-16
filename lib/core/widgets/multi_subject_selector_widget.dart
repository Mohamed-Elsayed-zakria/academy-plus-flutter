import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';

class MultiSubjectSelectorWidget extends StatefulWidget {
  final List<String> selectedSubjects;
  final Function(List<String>) onSubjectsChanged;
  final String label;
  final bool hasError;
  final String? errorText;

  const MultiSubjectSelectorWidget({
    super.key,
    required this.selectedSubjects,
    required this.onSubjectsChanged,
    required this.label,
    this.hasError = false,
    this.errorText,
  });

  @override
  State<MultiSubjectSelectorWidget> createState() => _MultiSubjectSelectorWidgetState();
}

class _MultiSubjectSelectorWidgetState extends State<MultiSubjectSelectorWidget> {
  // Mock courses data with prices - in real app this would come from a service
  final List<Map<String, dynamic>> _courses = [
    {
      'name': 'البرمجة المتقدمة',
      'price': 299,
      'discount': 20,
      'instructor': 'د. أحمد محمد',
      'rating': 4.8,
    },
    {
      'name': 'قواعد البيانات',
      'price': 249,
      'discount': 15,
      'instructor': 'د. فاطمة علي',
      'rating': 4.6,
    },
    {
      'name': 'تطوير الويب',
      'price': 199,
      'discount': 25,
      'instructor': 'د. محمود حسن',
      'rating': 4.9,
    },
    {
      'name': 'هياكل البيانات',
      'price': 179,
      'discount': 10,
      'instructor': 'د. سارة خالد',
      'rating': 4.7,
    },
    {
      'name': 'تطوير التطبيقات المحمولة',
      'price': 399,
      'discount': 30,
      'instructor': 'د. خالد أحمد',
      'rating': 4.8,
    },
    {
      'name': 'الذكاء الاصطناعي',
      'price': 349,
      'discount': 20,
      'instructor': 'د. نور الدين',
      'rating': 4.9,
    },
    {
      'name': 'أمن المعلومات',
      'price': 279,
      'discount': 15,
      'instructor': 'د. مريم حسن',
      'rating': 4.6,
    },
    {
      'name': 'الرياضيات',
      'price': 149,
      'discount': 10,
      'instructor': 'د. عمر محمد',
      'rating': 4.5,
    },
    {
      'name': 'الفيزياء',
      'price': 159,
      'discount': 12,
      'instructor': 'د. لينا أحمد',
      'rating': 4.4,
    },
    {
      'name': 'الكيمياء',
      'price': 169,
      'discount': 8,
      'instructor': 'د. يوسف علي',
      'rating': 4.3,
    },
  ];

  void _showSubjectSelectionDialog() {
    List<String> tempSelectedSubjects = List.from(widget.selectedSubjects);
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Icon(
                  Ionicons.book_outline,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'اختيار المواد',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: Column(
                children: [
                  // Selected count
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'تم اختيار ${tempSelectedSubjects.length} مادة',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Courses list
                  Expanded(
                    child: ListView.builder(
                      itemCount: _courses.length,
                      itemBuilder: (context, index) {
                        final course = _courses[index];
                        final isSelected = tempSelectedSubjects.contains(course['name']);
                        final originalPrice = course['price'] as int;
                        final discount = course['discount'] as int;
                        final discountedPrice = originalPrice - (originalPrice * discount / 100);
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected 
                                  ? AppColors.primary 
                                  : AppColors.textTertiary.withValues(alpha: 0.3),
                              width: isSelected ? 2 : 1,
                            ),
                            color: isSelected 
                                ? AppColors.primary.withValues(alpha: 0.05)
                                : Colors.white,
                          ),
                          child: CheckboxListTile(
                            value: isSelected,
                            onChanged: (bool? value) {
                              setDialogState(() {
                                if (value == true) {
                                  tempSelectedSubjects.add(course['name'] as String);
                                } else {
                                  tempSelectedSubjects.remove(course['name'] as String);
                                }
                              });
                            },
                            activeColor: AppColors.primary,
                            title: Text(
                              course['name'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  course['instructor'] as String,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.star,
                                      size: 12,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${course['rating']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    if (discount > 0) ...[
                                      Text(
                                        '${originalPrice} \$',
                                        style: TextStyle(
                                          fontSize: 12,
                                          decoration: TextDecoration.lineThrough,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                    Text(
                                      '${discountedPrice.round()} \$',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                    if (discount > 0) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.accent,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          '-$discount%',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  AppLocalizations.cancel,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onSubjectsChanged(tempSelectedSubjects);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text('تأكيد'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _showSubjectSelectionDialog,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.hasError 
                    ? AppColors.error 
                    : AppColors.textTertiary,
                width: widget.hasError ? 2 : 1,
              ),
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
                  Ionicons.book_outline,
                  color: widget.hasError 
                      ? AppColors.error 
                      : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: widget.selectedSubjects.isEmpty
                      ? Text(
                          'اضغط لاختيار المواد',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.selectedSubjects.length} مادة مختارة',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.selectedSubjects.take(2).join('، ') + 
                              (widget.selectedSubjects.length > 2 ? '...' : ''),
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                ),
                Icon(
                  Ionicons.chevron_down_outline,
                  color: widget.hasError 
                      ? AppColors.error 
                      : AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (widget.hasError && widget.errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: AppColors.error,
              fontSize: 12,
            ),
          ),
        ],
        
        // Selected subjects summary
        if (widget.selectedSubjects.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Ionicons.checkmark_circle_outline,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'المواد المختارة:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...widget.selectedSubjects.map((subject) {
                  final course = _courses.firstWhere((c) => c['name'] == subject);
                  final originalPrice = course['price'] as int;
                  final discount = course['discount'] as int;
                  final discountedPrice = originalPrice - (originalPrice * discount / 100);
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            subject,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          '${discountedPrice.round()} \$',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 8),
                Divider(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  height: 1,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المجموع:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${widget.selectedSubjects.map((subject) {
                        final course = _courses.firstWhere((c) => c['name'] == subject);
                        final originalPrice = course['price'] as int;
                        final discount = course['discount'] as int;
                        return originalPrice - (originalPrice * discount / 100);
                      }).reduce((a, b) => a + b).round()} \$',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
