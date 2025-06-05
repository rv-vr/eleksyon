import 'package:eleksyon/components/constants.dart';
import 'package:eleksyon/main.dart';
import 'package:flutter/material.dart';
import 'register.dart';

class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Blue header with logo
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: Constants.primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/icon_nobg.png',
                  height: 100,
                ),
                SizedBox(height: 16),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Login to your student account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Form section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  _buildTextField(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                          Text('Remember Me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // forgot password
                        },
                        child: Text('Forgot Password?'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => EleksyonUIUI()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => RegisterForm()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register here",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
