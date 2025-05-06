/*import 'package:flutter/material.dart';
import 'category_list_screen.dart';
import 'profile_screen.dart';
import 'rental_history_screen.dart';
import '../services/auth_service.dart'; // Logout servisini unutma

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  /*final List<Widget> _pages = [
    CategoryListScreen(),
    RentalHistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ski Rent"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),

        ],
      ),
     // body: _pages[_selectedIndex],
      body: CategoryListScreen(),
      /*
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Rentals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),*/
    );
  }
}*/


import 'package:flutter/material.dart';
import 'category_list_screen.dart';
import 'profile_screen.dart';
import 'rental_history_screen.dart';
import '../services/auth_service.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF0F3D57), // ✔️ koyu mavi
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF0F3D57),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.snowboarding, color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Text(
                      "Ski Rental",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
              _drawerItem(Icons.dashboard, "Dashboard", () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainLayout()));
              }),
              _drawerItem(Icons.person, "My Account", () {
                Navigator.pushNamed(context, '/profile');
              }),
              _drawerItem(Icons.receipt_long, "My Orders", () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RentalHistoryScreen()));
              }),
              const Spacer(),
              const Divider(color: Colors.white24),
              _drawerItem(Icons.logout, "Logout", () async {
                await AuthService().logout();
                Navigator.pushReplacementNamed(context, '/');
              }),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Ski Rental"),
        backgroundColor: Colors.white, // ✔️ beyaz
        foregroundColor: Colors.black, // ✔️ siyah yazı/ikon
        elevation: 0,
      ),
      body: CategoryListScreen(),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context); // drawer'ı kapat
        onTap();
      },
    );
  }
}

