import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://example.com/api";

  static Future<dynamic> post(String endpoint, Map data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
}
