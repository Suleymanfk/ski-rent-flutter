/*import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late Future<List<Category>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = CategoryService().fetchCategories();
  }

  void _onCategoryTap(Category category) {
    Navigator.pushNamed(
      context,
      '/equipment',
      arguments: category.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: true, // ✅ başlığı ortaya hizalar
      ),
      body: FutureBuilder<List<Category>>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No categories found."));
          }

          final categories = snapshot.data!;
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40), // ✅ yukarıdan boşluk ekliyoruz
                  ...categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () => _onCategoryTap(category),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(category.categoryName),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late Future<List<Category>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = CategoryService().fetchCategories();
  }

  void _onCategoryTap(Category category) {
    Navigator.pushNamed(
      context,
      '/equipment',
      arguments: category.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Rent Equipment"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Category>>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No categories found."));
          }

          final categories = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 30),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return GestureDetector(
                onTap: () => _onCategoryTap(category),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    width: screenWidth * 0.9,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(category.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: Text(
                        category.categoryName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
