/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_request.dart';
import '../services/login_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  String _responseMessage = '';

  void _handleLogin() async {
    final request = LoginRequest(
      username: _usernameController.text.trim(),
      surname: _surnameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final service = LoginService();
    final result = await service.loginUser(request);

    setState(() {
      _responseMessage = result;
    });

    if (result == "Login successful.") {
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('role') ?? 'USER';

      if (role == 'ADMIN') {
        Navigator.pushReplacementNamed(context, '/admin/home');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(Icons.login, size: 60, color: Theme.of(context).primaryColor),
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
                  onPressed: () {
                    setState(() => _obscure = !_obscure);
                  },
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _handleLogin,
              icon: Icon(Icons.login),
              label: Text("Login"),
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
            SizedBox(height: 30),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: Text("Don't have an account? Register here"),
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
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_request.dart';
import '../services/login_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  String _responseMessage = '';

  void _handleLogin() async {
    final request = LoginRequest(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final result = await LoginService().loginUser(request);

    setState(() {
      _responseMessage = result;
    });

    if (result == "Login successful.") {
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('role') ?? 'USER';

      if (role == 'ADMIN') {
        Navigator.pushReplacementNamed(context, '/admin/home');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✔️ arka plan beyaz
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // ✉️ Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // 🔒 Password
              TextField(
                controller: _passwordController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 40),

              // 🔘 Login Button
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text("Login"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F3D57),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),

              const SizedBox(height: 16),

              if (_responseMessage.isNotEmpty)
                Text(
                  _responseMessage,
                  style: TextStyle(
                    color: _responseMessage.toLowerCase().contains("success")
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 30),

              // 📝 Register Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text("Signup"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
