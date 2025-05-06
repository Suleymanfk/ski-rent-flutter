//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ski_rental_app2/screens/admin/add_equipment_screen.dart';
import 'package:ski_rental_app2/screens/admin/admin_equipment_list_screen.dart';
import 'package:ski_rental_app2/screens/admin/admin_main_layout.dart';
import 'package:ski_rental_app2/screens/admin/update_equipment_screen.dart';
import 'package:ski_rental_app2/screens/category_list_screen.dart';
import 'package:ski_rental_app2/screens/change_password_screen.dart';
import 'package:ski_rental_app2/screens/equipment_detail_screen.dart';
import 'package:ski_rental_app2/screens/equipment_list_screen.dart';
//import 'package:ski_rental_app2/screens/home_screens.dart';
import 'package:ski_rental_app2/screens/login_screen.dart';
import 'package:ski_rental_app2/screens/main_layout.dart';
import 'package:ski_rental_app2/screens/profile_screen.dart';
import 'package:ski_rental_app2/screens/register_screen.dart';
import 'package:ski_rental_app2/screens/rent_screen.dart';
import 'package:ski_rental_app2/screens/rental_history_screen.dart';
import 'package:ski_rental_app2/screens/update_profile_screen.dart';

import 'models/equipment_model.dart';

void main() {
  runApp(MyApp());
}




/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ski Rental Admin',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(), // geçici ana sayfa
        '/admin/add': (context) => AddEquipmentScreen(),
        // diğer sayfalar...
      },
    );
  }
}*/






class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ski Rent',
      initialRoute: '/',
      routes: {
        '/categories': (context) => CategoryListScreen(),
        '/equipment': (context) {
          final categoryId = ModalRoute.of(context)!.settings.arguments as int;
          return EquipmentListScreen(categoryId: categoryId);
        },
        '/equipment-detail': (context) {
          final equipment = ModalRoute.of(context)!.settings.arguments as Equipment;
          return EquipmentDetailScreen(equipment: equipment);
        },
        '/rent': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return RentScreen(equipment: args['equipment'], );
        },
        '/profile': (context) => ProfileScreen(),
        '/rental-history': (context) => RentalHistoryScreen(),
        '/admin/add': (context) => AddEquipmentScreen(),
        '/admin/list': (context) => AdminEquipmentListScreen(),
        '/admin/update': (context) {
          final equipment = ModalRoute.of(context)!.settings.arguments as Equipment;
          return UpdateEquipmentScreen(equipment: equipment);
        },
        '/home': (context) => MainLayout(),
        '/': (context) => LoginScreen(), //
        '/admin/home': (context) => AdminMainLayout(),
        '/register': (context) => RegisterScreen(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/update-profile': (context) => UpdateProfileScreen(),



      },
    );
  }
}
