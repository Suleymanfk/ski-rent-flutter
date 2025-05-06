import 'package:flutter/material.dart';
import '../models/register_request.dart';
import '../services/register_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  String _responseMessage = '';

  void _handleRegister() async {
    final request = RegisterRequest(
      username: _usernameController.text.trim(),
      surname: _surnameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final service = RegisterService();
    final result = await service.registerUser(request);

    setState(() {
      _responseMessage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(Icons.app_registration, size: 60, color: Theme.of(context).primaryColor),
            SizedBox(height: 20),

            _buildTextField(_usernameController, "Username", Icons.person),
            SizedBox(height: 12),
            _buildTextField(_surnameController, "Surname", Icons.badge),
            SizedBox(height: 12),
            _buildTextField(_emailController, "Email", Icons.email),
            SizedBox(height: 12),

            TextField(
              controller: _passwordController,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _handleRegister,
              icon: Icon(Icons.check_circle),
              label: Text("Register"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            SizedBox(height: 20),
            if (_responseMessage.isNotEmpty)
              Text(
                _responseMessage,
                style: TextStyle(
                  color: _responseMessage.toLowerCase().contains("success") ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }
}
