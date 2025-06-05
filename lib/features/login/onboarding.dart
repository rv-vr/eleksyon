import 'package:eleksyon/components/constants.dart';
import 'package:eleksyon/features/login/admin_login.dart';
import 'package:eleksyon/features/login/register.dart';
import 'package:flutter/material.dart';
import 'student_login.dart';


class OnboardingPage extends StatefulWidget {
  @override

  const OnboardingPage({super.key});
  
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Gradient blue banner with logo and introoo
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
                Column(
                  children: [
                    Text(
                      'Hey there! Ready to cast your vote?',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Vote Securely. Vote Transparently. Vote Smart.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      icon: Icons.school,
                      label: 'Student Login',
                      color: Constants.primaryColor,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => StudentLogin(),
                        ));
                      },
                    ),
                    SizedBox(height: 24),
                    _buildButton(
                      icon: Icons.admin_panel_settings,
                      label: 'Admin Login',
                      color: Constants.primaryColor,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AdminLoginForm(),
                        ));
                      },
                    ),
                    SizedBox(height: 24),
                    _buildButton(
                      icon: Icons.app_registration,
                      label: 'Register',
                      color: Constants.primaryColor,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => RegisterForm(),
                        ));
                      },
                    ),
                    //footer
                    SizedBox(height: 32),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified_user, size: 18, color: Constants.primaryColor),
                        SizedBox(width: 6),
                        Text(
                          'Secure and Trusted Voting App',
                          style: TextStyle(
                            fontSize: 12,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
