class Category {
  final int id;
  final String categoryName;
  final String imageUrl;

  Category({required this.id, required this.categoryName, required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
