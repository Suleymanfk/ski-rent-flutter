import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/equipment_model.dart';
import '../models/rental_model.dart';

class AdminService {
  final String baseUrl = 'http://10.0.2.2:8080';
//kiralananları getir
  Future<List<Rental>> fetchAllRentals() async {
    final response = await http.get(Uri.parse('$baseUrl/api/admin/rentals'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Rental.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch rentals");
    }
  }
//ekle
  Future<String> addEquipment(Equipment equipment, int selectedCategoryId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/admin/equipment?categoryId=${selectedCategoryId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": equipment.name,
        "description": equipment.description,
        "imageUrl": equipment.imageUrl,
        "hourlyRate": equipment.hourlyRate,
        "isAvailable": equipment.isAvailable,
        "equipmentCategory": {"id": equipment.categoryId}
      }),
    );
    return response.statusCode == 200
        ? "Equipment added successfully"
        : "Failed to add: ${response.body}";
  }
//sil
  Future<String> deleteEquipment(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/admin/equipment/$id'),
    );
    return response.statusCode == 200
        ? "Equipment deleted"
        : "Failed to delete";
  }
//güncelle
  Future<String> updateEquipment(Equipment equipment) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/admin/equipment/${equipment.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": equipment.name,
        "description": equipment.description,
        "imageUrl": equipment.imageUrl,
        "hourlyRate": equipment.hourlyRate,
        "isAvailable": equipment.isAvailable,
        "equipmentCategory": {"id": equipment.categoryId}
      }),
    );
    return response.statusCode == 200
        ? "Equipment updated"
        : "Update failed: ${response.body}";
  }
}
