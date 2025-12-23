import 'dart:convert';
import 'package:food_chef/Network/end_points.dart';
import 'package:food_chef/core/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var url;
  var response;

  Map<String, String> headersWithoutToken = {
    'Content-type': 'application/json',
  };
  Map<String, String> headersWithToken(token) => {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  static Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json", // Add Authorization if needed // "Authorization": "Bearer YOUR_TOKEN",
  };

  static dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    if (statusCode == 200) {
      return body;
    } else {
      throw Exception("Error [$statusCode]: ${response.reasonPhrase}");
    }
  }


  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint), headers: headers);
    return _processResponse(response);
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try{
      final response = await http.post( Uri.parse(endpoint), headers: headers, body: jsonEncode(body), );
      return _processResponse(response);
    }catch(e){
      throw Exception('Failed to load form info data: $e');
    }
  }
}
