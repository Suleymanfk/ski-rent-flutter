import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class CategoryService {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/api/category'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
