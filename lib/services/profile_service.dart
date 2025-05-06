import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class ProfileService {

  final String baseUrl = 'http://10.0.2.2:8080';
  //final int userId = 1; // Geçici olarak sabit kullanıcı
//profil
  Future<User> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;


    final response = await http.get(Uri.parse('$baseUrl/api/users/profile/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load user profile.");
    }
  }
//profil guncelle
  Future<String> updateProfile(User updatedUser) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;

    final response = await http.put(
      Uri.parse('$baseUrl/api/users/profile/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': updatedUser.username,
        'surname': updatedUser.surname,
        'email': updatedUser.email,
      }),
    );

    return response.statusCode == 200
        ? "Profile updated successfully."
        : "Update failed: ${response.body}";
  }
//profil şifre guncelle
  Future<String> updatePassword(String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;

    final response = await http.put(
      Uri.parse('$baseUrl/api/users/profile/$userId/password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newPassword),
    );

    return response.statusCode == 200
        ? "Password changed successfully."
        : "Password update failed: ${response.body}";
  }
}
