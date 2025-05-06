import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/equipment_model.dart';

class EquipmentService {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Equipment>> fetchAllEquipment() async {
    final response = await http.get(Uri.parse('$baseUrl/api/equipment'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Equipment.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load equipment");
    }


  }

}
