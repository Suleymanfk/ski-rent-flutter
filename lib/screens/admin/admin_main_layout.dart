import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'add_equipment_screen.dart';
import 'admin_equipment_list_screen.dart';

class AdminMainLayout extends StatefulWidget {
  @override
  _AdminMainLayoutState createState() => _AdminMainLayoutState();
}

class _AdminMainLayoutState extends State<AdminMainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminEquipmentListScreen(),
    AddEquipmentScreen(),
  ];

  final List<String> _titles = [
    'All Equipment (Admin)',
    'Add New Equipment',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_titles[_selectedIndex])),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () async {
              await AuthService().logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Equipment'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        ],
      ),
    );
  }
}
