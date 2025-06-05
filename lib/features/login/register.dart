import 'package:flutter/material.dart';
import 'student_login.dart';
void main() => runApp(RegisterForm());
class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController programController = TextEditingController();
  final TextEditingController yearSectionController = TextEditingController();
  final TextEditingController schoolEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //dropdown options
  String selectedCollege = 'College of Arts and Sciences';

  final List<String> collegeOptions = [
    'College of Arts and Sciences',
    'College of Engineering and Architecture',
    'College of Education',
    'College of Industrial Technology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                //heaader with logo
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icon_nobg.png',
                        height: 80,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Create an Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      _buildFormField('Full Name', nameController),
                      SizedBox(height: 16),
                      _buildFormField('Username', usernameController),
                      SizedBox(height: 16),
                      _buildFormField('Program', programController),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                                'Student ID No.', studentIdController),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildFormField(
                                'Year & Section', yearSectionController),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildDropdownField('College', collegeOptions,
                          selectedCollege, (value) {
                        setState(() {
                          selectedCollege = value!;
                        });
                      }),
                      SizedBox(height: 16),
                      _buildFormField('School Email', schoolEmailController,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 16),
                      _buildFormField('Password', passwordController,
                          obscureText: true),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => StudentLogin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 140, vertical: 20),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String value,
      Function(String?) onChanged) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
