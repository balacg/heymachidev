// lib/services/email_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class EmailService {
  static Future<void> sendEmailWithPDF({
    required String toEmail,
    required String subject,
    required String body,
    required List<int> pdfBytes,
    String filename = 'bill.pdf',
  }) async {
    final apiUrl = Uri.parse('http://localhost:8000/send-email');

    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "to": toEmail,
        "subject": subject,
        "body": body,
        "attachment": base64Encode(pdfBytes),
        "filename": filename,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to send email: ${response.body}");
    }
  }

  static Future<File> savePDFToFile(List<int> pdfBytes, String filename) async {
    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/$filename");
    return file.writeAsBytes(pdfBytes);
  }
}
