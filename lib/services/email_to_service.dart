import 'package:url_launcher/url_launcher.dart';

class EmailHelper {
  static Future<void> launchEmail({
    required String email,
    String subject = '',
    String body = '',
  }) async {
    final String query = [
      if (subject.isNotEmpty) 'subject=${Uri.encodeComponent(subject)}',
      if (body.isNotEmpty) 'body=${Uri.encodeComponent(body)}',
    ].join('&');

    final Uri emailUri = Uri.parse('mailto:$email?$query');

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw Exception('Could not launch email client');
      }
    } catch (e) {
      throw Exception('Failed to open email client: $e');
    }
  }
}
