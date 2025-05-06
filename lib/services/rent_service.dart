import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/rent_request.dart';

class RentService {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<String> rentEquipment(RentRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/rentals/create?userId=${request.userId}&equipmentId=${request.equipmentId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'startTime': request.startTime.toIso8601String(),
        'endTime': request.endTime.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return "Rental created successfully.";
    } else {
      return "Rental failed: ${response.body}";
    }
  }
}
