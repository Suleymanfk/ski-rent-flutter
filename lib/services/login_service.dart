import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_request.dart';

class LoginService {
  final String baseUrl = 'http://10.0.2.2:8080'; // for Android emulator

  Future<String> loginUser(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userId = data['userId'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', userId);
      await prefs.setString('role', data['role']);
      //await prefs.setString('username', request.username);
      await prefs.setString('email', request.email);
      await prefs.setString('password', request.password);
      return "Login successful.";
      return "Login successful.";
    } else {
      return "Login failed: ${response.body}";
    }
  }
}





//return jsonDecode(response.body)["message"] ?? "Login failed!";