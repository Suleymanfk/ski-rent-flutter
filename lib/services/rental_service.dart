import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rental_model.dart';

class RentalService {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Rental>> fetchMyRentals() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    print("RentalService: userId = $userId");
    final response = await http.get(Uri.parse('$baseUrl/api/rentals/user/$userId'));
    print("RentalService: response = ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Rental.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load rental history");
    }
  }
}
