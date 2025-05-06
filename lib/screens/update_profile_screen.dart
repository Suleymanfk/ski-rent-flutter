import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/profile_service.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  String email = '';
  String message = '';
  int userId = 0;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    final user = await ProfileService().fetchProfile();
    setState(() {
      userId = user.id;
      _nameController.text = user.username;
      _surnameController.text = user.surname;
      email = user.email;
    });
  }

  void _submitUpdate() async {
    final updatedUser = User(
      id: userId,
      username: _nameController.text.trim(),
      surname: _surnameController.text.trim(),
      email: email,
    );

    final result = await ProfileService().updateProfile(updatedUser);
    setState(() {
      message = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.person, size: 60, color: Theme.of(context).primaryColor),
            SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),

            TextField(
              controller: _surnameController,
              decoration: InputDecoration(
                labelText: 'Surname',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),

            /*TextField(
              enabled: false,
              decoration: InputDecoration(
                //labelText: 'Email (unchangeable)',
                prefixIcon: Icon(Icons.email),
                hintText: email,
                border: OutlineInputBorder(),
              ),
            ),*/

            SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _submitUpdate,
              icon: Icon(Icons.save),
              label: Text("Update Profile"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            SizedBox(height: 20),

            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(
                  color: message.toLowerCase().contains("success") ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
