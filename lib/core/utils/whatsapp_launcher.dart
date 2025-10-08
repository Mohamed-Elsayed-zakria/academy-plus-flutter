import 'package:url_launcher/url_launcher.dart';

class WhatsAppLauncher {
  /// Opens WhatsApp with a pre-filled message
  ///
  /// [phoneNumber] - WhatsApp business number (with country code, without +)
  /// [message] - Optional pre-filled message
  ///
  /// Example: openWhatsApp('1234567890', 'Hello, I want to subscribe to...')
  static Future<void> openWhatsApp({
    required String phoneNumber,
    String? message,
  }) async {
    // Remove any spaces, dashes, or plus signs from phone number
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\+]'), '');

    // Encode the message for URL
    final encodedMessage = message != null
        ? Uri.encodeComponent(message)
        : '';

    // Create WhatsApp URL (works for both mobile and web)
    final whatsappUrl = Uri.parse(
      'https://wa.me/$cleanNumber${message != null ? '?text=$encodedMessage' : ''}'
    );

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(
          whatsappUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw Exception('Could not launch WhatsApp');
      }
    } catch (e) {
      // Fallback: try opening with browser
      try {
        await launchUrl(
          whatsappUrl,
          mode: LaunchMode.platformDefault,
        );
      } catch (e) {
        throw Exception('WhatsApp is not installed or cannot be opened');
      }
    }
  }

  /// Opens WhatsApp for course subscription inquiry
  static Future<void> openForCourseSubscription({
    required String phoneNumber,
    required String courseName,
    String? courseId,
  }) async {
    final message = 'Hello! I\'m interested in subscribing to the course: '
        '"$courseName"${courseId != null ? ' (ID: $courseId)' : ''}. '
        'Could you please provide more information?';

    await openWhatsApp(
      phoneNumber: phoneNumber,
      message: message,
    );
  }
}
