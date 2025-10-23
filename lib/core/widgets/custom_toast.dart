import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../constants/app_colors.dart';
import '../localization/app_localizations.dart';

class CustomToast extends StatefulWidget {
  final String message;
  final ToastType type;
  final Duration duration;
  final VoidCallback? onDismiss;

  const CustomToast({
    super.key,
    required this.message,
    required this.type,
    this.duration = const Duration(seconds: 3),
    this.onDismiss,
  });

  @override
  State<CustomToast> createState() => _CustomToastState();

  static void show(
    BuildContext context, {
    required String message,
    required ToastType type,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 16,
        right: 16,
        child: CustomToast(
          message: message,
          type: type,
          duration: duration,
          onDismiss: () {
            overlayEntry.remove();
            onDismiss?.call();
          },
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto remove after duration
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  // Helper method to show success toast with Arabic text
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: ToastType.success,
      duration: duration,
    );
  }

  // Helper method to show error toast with Arabic text
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: ToastType.error,
      duration: duration,
    );
  }

  // Helper method to show warning toast
  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: ToastType.warning,
      duration: duration,
    );
  }
}

class _CustomToastState extends State<CustomToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      widget.onDismiss?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value * 100),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.type == ToastType.success
                        ? AppColors.success
                        : widget.type == ToastType.error
                            ? AppColors.error
                            : widget.type == ToastType.warning
                                ? Colors.orange
                                : AppColors.primary,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.type == ToastType.success
                          ? AppColors.success.withValues(alpha: 0.2)
                          : widget.type == ToastType.error
                              ? AppColors.error.withValues(alpha: 0.2)
                              : widget.type == ToastType.warning
                                  ? Colors.orange.withValues(alpha: 0.2)
                                  : AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: widget.type == ToastType.success
                            ? AppColors.success.withValues(alpha: 0.1)
                            : widget.type == ToastType.error
                                ? AppColors.error.withValues(alpha: 0.1)
                                : widget.type == ToastType.warning
                                    ? Colors.orange.withValues(alpha: 0.1)
                                    : AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: widget.type == ToastType.success
                              ? AppColors.success
                              : widget.type == ToastType.error
                                  ? AppColors.error
                                  : widget.type == ToastType.warning
                                      ? Colors.orange
                                      : AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        widget.type == ToastType.success
                            ? Ionicons.checkmark_circle
                            : widget.type == ToastType.error
                                ? Ionicons.warning_outline
                                : widget.type == ToastType.warning
                                    ? Ionicons.warning_outline
                                    : Ionicons.information_circle_outline,
                        color: widget.type == ToastType.success
                            ? AppColors.success
                            : widget.type == ToastType.error
                                ? AppColors.error
                                : widget.type == ToastType.warning
                                    ? Colors.orange
                                    : AppColors.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.type == ToastType.success
                                ? AppLocalizations.successToastTitle
                                : widget.type == ToastType.error
                                    ? AppLocalizations.errorToastTitle
                                    : widget.type == ToastType.warning
                                        ? AppLocalizations.warningToastTitle
                                        : AppLocalizations.infoToastTitle,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: widget.type == ToastType.success
                                  ? AppColors.success
                                  : widget.type == ToastType.error
                                      ? AppColors.error
                                      : widget.type == ToastType.warning
                                          ? Colors.orange
                                          : AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.message,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _dismiss,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outline.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: theme.colorScheme.outline.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Ionicons.close,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum ToastType {
  success,
  error,
  warning,
  info,
}

// Extension for easy usage with Arabic support
extension CustomToastExtension on BuildContext {
  void showSuccessToast(String message, {Duration? duration}) {
    CustomToast.showSuccess(
      this,
      message: message,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  void showErrorToast(String message, {Duration? duration}) {
    CustomToast.showError(
      this,
      message: message,
      duration: duration ?? const Duration(seconds: 4),
    );
  }

  void showInfoToast(String message, {Duration? duration}) {
    CustomToast.show(
      this,
      message: message,
      type: ToastType.info,
      duration: duration ?? const Duration(seconds: 3),
    );
  }
}