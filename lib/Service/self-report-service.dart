
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelfReportService {
  static const String baseUrl = 'https://api-dev.allia.health';
  final String accessToken;

  SelfReportService({required this.accessToken});

  Future<List<Question>> getQuestions() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/client/self-report/question'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Decoded JSON: $data');
      
      if (data['body'] != null && data['body'] is List) {
        List<dynamic> questionList = data['body'];
        return questionList.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Questions key is missing in the response or is null');
      }
    } else {
      throw Exception('Failed to load questions: ${response.body}');
    }
  }
}

class Question {
  final String id;
  final String text;
  final String questionType;
  final List<Option> options;

  Question({
    required this.id,
    required this.text,
    required this.questionType,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'].toString(),
      text: json['question'],
      questionType: json['answerType'],
      options: (json['options'] as List<dynamic>)
          .map((option) => Option.fromJson(option))
          .toList(),
    );
  }
}

class Option {
  final String id;
  final String option;
  final bool isFreeForm;

  Option({
    required this.id,
    required this.option,
    required this.isFreeForm,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'].toString(),
      option: json['option'],
      isFreeForm: json['isFreeForm'],
    );
  }
}
