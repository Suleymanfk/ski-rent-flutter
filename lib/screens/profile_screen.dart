import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = ProfileService().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(Icons.person, size: 60, color: Theme.of(context).primaryColor),
                        SizedBox(height: 10),
                        Text(user.username, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(user.surname, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text(user.email, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                ElevatedButton.icon(
                  icon: Icon(Icons.history),
                  label: Text("View Rental History"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/rental-history');
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text("Update Profile"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/update-profile');
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.lock),
                  label: Text("Change Password"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/change-password');
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
