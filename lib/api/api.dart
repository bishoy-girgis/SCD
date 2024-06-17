import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> login(String email, String password) async {
  var url = Uri.parse('https://scd.skin/mobile_api/login/')
      .replace(queryParameters: {'email': email, 'password': password});

  try {
    final response = await http.get(url, headers: {
      'Authorization': 'Token b384a378a9c6eddfd548a6c03da5e43a9ce5d772',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to connect to the API: $e');
  }
}
