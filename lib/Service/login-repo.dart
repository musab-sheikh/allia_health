
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api-dev.allia.health';
  String? _accessToken;

  String? get accessToken => _accessToken;

  Future<void> login(String email, String password) async {
    const String endpoint = '/api/client/auth/login';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      _accessToken = data['body']['accessToken']; // Updated access token extraction
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
