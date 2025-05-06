class Equipment {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double hourlyRate;
  final bool isAvailable;
  final int categoryId;

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.hourlyRate,
    required this.isAvailable,
    required this.categoryId,
  });




  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['equipmentId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      hourlyRate: (json['hourlyRate'] ?? 0 as num).toDouble(),
      isAvailable: json['isAvailable'] ?? false,
      categoryId: json['category'] != null
          ? json['category']['categoryId'] ?? 0
          : 0,
      // İlişki varsa
    );
  }
}








/*
  factory Equipment.fromJson(Map<String, dynamic> json) {
    int resolvedCategoryId = 0;

    try {
      if (json.containsKey('equipmentCategory') && json['equipmentCategory'] != null) {
        final dynamic categoryData = json['equipmentCategory'];
        if (categoryData is Map && categoryData.containsKey('id')) {
          resolvedCategoryId = categoryData['id'];
        }
      }
    } catch (e) {
      resolvedCategoryId = 0;
    }

    return Equipment(
      id: json['equipmentId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      hourlyRate: (json['hourlyRate'] ?? 0).toDouble(),
      isAvailable: json['isAvailable'] ?? false,
      categoryId: resolvedCategoryId,
    );
  }
*/











/*class Equipment {
  final int id;
  final String name;
  final String category;
  //final String imageUrl;
  final int stock;

  Equipment({
    required this.id,
    required this.name,
    required this.category,
   // required this.imageUrl,
    required this.stock,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
     // imageUrl: json['imageUrl'] ?? '',
      stock: json['stock'] ?? 0,
    );
  }
}*/
