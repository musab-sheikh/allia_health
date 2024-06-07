import 'package:http/http.dart' as http;
import 'dart:convert';

class SubmitReportService {
  static const String baseUrl = 'https://api-dev.allia.health';

  static Future<void> submitReport({
    required String accessToken,
    required int questionId,
    required int selectedOptionId,
  }) async {
    print('Submitting report with:');
    print('AccessToken: $accessToken');
    print('QuestionId: $questionId');
    print('SelectedOptionId: $selectedOptionId');

    final response = await http.post(
      Uri.parse('$baseUrl/api/client/self-report/answer'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'answers': [
          {
            'questionId': questionId,
            'selectedOptionId': selectedOptionId,
            'freeformValue': null,
          }
        ]
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to submit answer');
    }
  }
}
