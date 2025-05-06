import 'package:flutter/material.dart';
import '../services/profile_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _passwordController = TextEditingController();
  String message = '';
  bool _obscure = true;

  void _submit() async {
    final newPassword = _passwordController.text.trim();

    if (newPassword.isEmpty) {
      setState(() => message = 'Please enter a new password.');
      return;
    }

    final result = await ProfileService().updatePassword(newPassword);
    setState(() {
      message = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.lock, size: 60, color: Theme.of(context).primaryColor),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => _obscure = !_obscure);
                  },
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: Icon(Icons.save),
              label: Text("Update Password"),
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}
