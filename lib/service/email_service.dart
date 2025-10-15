import 'dart:developer';
import 'package:emailjs/emailjs.dart' as EmailJS;
import 'package:flutter/material.dart';
import '../config/email_config.dart';

class EmailService {
  static Future<EmailResult> sendContactEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      EmailJS.init(const EmailJS.Options(
          publicKey: EmailConfig.publicKey, privateKey: EmailConfig.privteKey));

      final templateParams = {
        'from_name': name,
        'from_email': email,
        'subject': subject,
        'message': message,
        'to_email': EmailConfig.senderEmail,
        'to_name': EmailConfig.senderName
      };

      debugPrint('Sending email with params: $templateParams');

      await EmailJS.send(
        EmailConfig.serviceId,
        EmailConfig.templateId,
        templateParams,
      );

      return EmailResult(
        success: true,
        message: EmailConfig.successMessage,
      );
    } catch (error) {
      debugPrint('Email sending failed: $error');

      String errorMessage = EmailConfig.errorMessage;

      if (error.toString().contains('network') ||
          error.toString().contains('internet') ||
          error.toString().contains('connection')) {
        errorMessage = EmailConfig.networkErrorMessage;
      }

      return EmailResult(
        success: false,
        message: errorMessage,
        error: error.toString(),
      );
    }
  }

  static Future<EmailResult> sendTestEmail() async {
    return await sendContactEmail(
      name: 'Test User',
      email: 'test@example.com',
      subject: 'Test Email from Portfolio',
      message: 'This is a test email to verify EmailJS configuration.',
    );
  }

  static bool validateConfiguration() {
    return EmailConfig.serviceId.isNotEmpty &&
        EmailConfig.templateId.isNotEmpty &&
        EmailConfig.publicKey.isNotEmpty &&
        EmailConfig.senderEmail.isNotEmpty;
  }
}

class EmailResult {
  final bool success;
  final String message;
  final String? response;
  final String? error;

  EmailResult({
    required this.success,
    required this.message,
    this.response,
    this.error,
  });

  @override
  String toString() {
    return 'EmailResult{success: $success, message: $message, response: $response, error: $error}';
  }
}
