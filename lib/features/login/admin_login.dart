import 'package:flutter/material.dart';
import '../admin/admin_dashboard.dart';

void main() => runApp(MaterialApp(
  home: AdminLoginForm(),
  debugShowCheckedModeBanner: false,
));

class AdminLoginForm extends StatefulWidget {
  @override
  _AdminLoginFormState createState() => _AdminLoginFormState();
}

class _AdminLoginFormState extends State<AdminLoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = 'Super Admin';
  bool rememberMe = false;
  //dropdown options
  final List<String> roles = [
    'Super Admin',
    'Auditor',
    'Election Officer',
    'Content Manager',
    'Student Record Admin',
    'Technical Admin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        elevation: 0, // Remove shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            // Blue circle with logo
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade700,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Image.asset(
                    'assets/icon_nobg.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Admin Portal Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Manage, audit, and oversee election operations.',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32),

            // login form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildTextField('Username', usernameController),
                  SizedBox(height: 16),
                  _buildTextField('Password', passwordController, obscureText: true),
                  SizedBox(height: 16),
                  _buildDropdownField('Admin Role', roles, selectedRole, (val) {
                    setState(() => selectedRole = val!);
                  }),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() => rememberMe = value!);
                        },
                      ),
                      Text('Remember Me'),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // Forgot password
                        },
                        child: Text('Forgot Password?'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => AdminDashboardPage()),
                        );
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
