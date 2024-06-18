import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_account.dart';

class UserAccountApi {
  static const String _baseUrl = 'http://10.0.2.2/lostandfoundAPI';

  Future<bool> registerUser(UserAccount user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/user_account.php?action=register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['success'];
    } else {
      
      return false;
    }
  }

  Future<bool> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/user_account.php?action=login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['success'];
    } else {
      
      return false;
    }
  }
}
