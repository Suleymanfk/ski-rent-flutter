import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/register_request.dart';

class RegisterService {
  final String baseUrl = 'http://10.0.2.2:8080'; // for Android emulator

  Future<String> registerUser(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return "User registered successfully.";
    } else {
      return response.body; // Error message from backend
    }
  }
}
