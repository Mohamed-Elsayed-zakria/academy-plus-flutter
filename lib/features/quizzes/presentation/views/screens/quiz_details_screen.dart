import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/navigation_helper.dart';

class QuizDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> quiz;

  const QuizDetailsScreen({
    super.key,
    required this.quiz,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Available':
        return AppColors.success;
      case 'Completed':
        return AppColors.info;
      case 'Unavailable':
        return AppColors.textTertiary;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Available':
        return Ionicons.play_circle_outline;
      case 'Completed':
        return Ionicons.checkmark_circle_outline;
      case 'Unavailable':
        return Ionicons.lock_closed_outline;
      default:
        return Ionicons.help_circle_outline;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'Available':
        return 'متاح';
      case 'Completed':
        return 'مكتمل';
      case 'Unavailable':
        return 'غير متاح';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = quiz['status'] as String? ?? 'Available';
    final bestScore = quiz['bestScore'] as int?;
    final subjects = quiz['subjects'] as List<String>? ?? [];
    final title = quiz['title'] as String? ?? 'اختبار جديد';
    final deadline = quiz['deadline'] as String? ?? 'غير محدد';
    final totalPrice = quiz['totalPrice'] as double? ?? 0.0;
    final quizDate = quiz['quizDate'] as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.quizDetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern Header with Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: _getStatusColor(status).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getStatusIcon(status),
                              size: 18,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _getStatusText(status),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Modern Quiz Icon with Glass Effect
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          Ionicons.document_text_outline,
                          size: 56,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Quiz Title with Better Typography
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      
                      // Modern Subjects Tags
                      if (subjects.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: subjects.take(3).map((subject) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                subject,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Modern Content Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Modern Info Cards Grid
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Deadline Card
                      _ModernInfoCard(
                        icon: Ionicons.calendar_outline,
                        label: 'الموعد النهائي',
                        value: deadline,
                        color: AppColors.error,
                        isHighlighted: true,
                      ),
                      const SizedBox(height: 16),
                      
                      // Enhanced Price and Date Column
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.accent.withValues(alpha: 0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Ionicons.card_outline,
                                    color: AppColors.accent,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'السعر الإجمالي',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.textSecondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${totalPrice.toStringAsFixed(0)} \$',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.accent,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.info.withValues(alpha: 0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.info.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Ionicons.calendar_outline,
                                    color: AppColors.info,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'تاريخ الاختبار',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.textSecondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        quizDate ?? 'غير محدد',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.info,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            
            
            
                const SizedBox(height: 24),
            
                // Modern Instructions Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Ionicons.information_circle_outline,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'التعليمات',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
            
                      _ModernInstructionItem(
                        icon: Ionicons.document_outline,
                        text: 'قم برفع ملف يحتوي على إجاباتك (PDF, Word, أو صور)',
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 16),
                      _ModernInstructionItem(
                        icon: Ionicons.calendar_outline,
                        text: 'تأكد من التسليم قبل الموعد النهائي',
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      _ModernInstructionItem(
                        icon: Ionicons.checkmark_circle_outline,
                        text: 'راجع الملف قبل الرفع',
                        color: AppColors.success,
                      ),
                      const SizedBox(height: 16),
                      _ModernInstructionItem(
                        icon: Ionicons.time_outline,
                        text: 'يمكنك رفع الملف في أي وقت قبل الموعد النهائي',
                        color: AppColors.info,
                      ),
                    ],
                  ),
                ),
            
            
                const SizedBox(height: 32),
            
                // Modern Action Buttons
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (status == 'Available') ...[
                        _ModernActionButton(
                          text: 'رفع الإجابة',
                          onPressed: () {
                            _showUploadConfirmation(context);
                          },
                          icon: Ionicons.cloud_upload_outline,
                          isPrimary: true,
                        ),
                        if (bestScore != null) ...[
                          const SizedBox(height: 12),
                          _ModernActionButton(
                            text: 'عرض التسليم السابق',
                            onPressed: () {
                              // View previous submission
                            },
                            icon: Ionicons.eye_outline,
                            isPrimary: false,
                          ),
                        ],
                        const SizedBox(height: 12),
                        _ModernActionButton(
                          text: 'تحميل المواد المرجعية',
                          onPressed: () {
                            // Download materials
                          },
                          icon: Ionicons.download_outline,
                          isPrimary: false,
                        ),
                      ] else if (status == 'Completed') ...[
                        _ModernActionButton(
                          text: 'عرض النتائج',
                          onPressed: () {
                            // View results
                          },
                          icon: Ionicons.bar_chart_outline,
                          isPrimary: true,
                        ),
                        const SizedBox(height: 12),
                        _ModernActionButton(
                          text: 'تحميل الشهادة',
                          onPressed: () {
                            // Download certificate
                          },
                          icon: Ionicons.trophy_outline,
                          isPrimary: false,
                        ),
                      ] else if (status == 'Unavailable') ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.textTertiary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.lock_closed_outline,
                                color: AppColors.textTertiary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'الاختبار غير متاح حالياً',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUploadConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Ionicons.cloud_upload_outline, color: AppColors.primary),
              const SizedBox(width: 12),
              const Text('رفع الإجابة'),
            ],
          ),
          content: const Text(
            'هل أنت مستعد لرفع ملف الإجابة؟ تأكد من أن الملف يحتوي على جميع الإجابات المطلوبة.',
          ),
          actions: [
            TextButton(
              onPressed: () => NavigationHelper.back(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationHelper.back(context);
                // Open file picker and upload
                _openFilePicker(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('رفع الملف'),
            ),
          ],
        );
      },
    );
  }

  void _openFilePicker(BuildContext context) {
    // TODO: Implement file picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم فتح منتقي الملفات قريباً'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

class _ModernInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isHighlighted;

  const _ModernInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isHighlighted 
            ? Border.all(color: color.withValues(alpha: 0.3), width: 1)
            : Border.all(color: color.withValues(alpha: 0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isHighlighted ? color : AppColors.textPrimary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernInstructionItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _ModernInstructionItem({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}

class _ModernActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final bool isPrimary;

  const _ModernActionButton({
    required this.text,
    required this.onPressed,
    required this.icon,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.white,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary 
                ? BorderSide.none 
                : BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          elevation: isPrimary ? 4 : 0,
          shadowColor: isPrimary ? AppColors.primary.withValues(alpha: 0.3) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


