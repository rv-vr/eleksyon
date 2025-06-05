import 'dart:io';
import 'dart:typed_data';
import 'package:eleksyon/components/constants.dart';
import 'package:eleksyon/features/sample_data/users.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'notification.dart';
import 'history.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile Settings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
        useMaterial3: true,
      ),
      home: const UserProfileSettings(),
    );
  }
}

class UserProfileSettings extends StatefulWidget {
  const UserProfileSettings({super.key});

  @override
  State<UserProfileSettings> createState() => _UserProfileSettingsState();
}

class _UserProfileSettingsState extends State<UserProfileSettings> {
  // user infos
  final String fullName = suette.fullName;
  String username = suette.userName;
  final String program = suette.program;
  final String studentId = suette.studentId;
  String yrAndSec = '${suette.yr} ${suette.section}';
  final String college = suette.college;
  final String schoolEmail = suette.schoolEmail;
  String password = suette.password;

  bool isEditing = false;

  // can edit controller
  late TextEditingController usernameController;
  late TextEditingController yrAndSecController;

  File? _profileImage;
  Uint8List? _profileImageBytes = suette.profilePicture;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: username);
    yrAndSecController = TextEditingController(text: yrAndSec);
  }

  @override
  void dispose() {
    usernameController.dispose();
    yrAndSecController.dispose();
    super.dispose();
  }

  void toggleEdit() {
    setState(() {
      if (isEditing) {
        username = usernameController.text;
        yrAndSec = yrAndSecController.text;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated')),
        );
      }
      isEditing = !isEditing;
    });
  }
  //pick image from files
  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _profileImageBytes = result.files.single.bytes!;
      });
    }
  }

  void changePassword() {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'Change Password',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Constants.primaryColor,
        ),
      ),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade700),
                ),
                enabledBorder: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade700),
                ),
                enabledBorder: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Color.fromARGB(255, 125, 124, 124))),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            final newPassword = newPasswordController.text.trim();
            final confirmPassword = confirmPasswordController.text.trim();

            if (newPassword.isEmpty || confirmPassword.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill in both fields')),
              );
              return;
            }

            if (newPassword != confirmPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Passwords do not match')),
              );
              return;
            }

            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password successfully changed')),
            );
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}


  void viewElectionHistory() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const VoterHistoryPage()),
  );
}

  //design
  Widget buildInfoRow(String label, Widget valueWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: valueWidget),
        ],
      ),
    );
  }

  final Gradient appBarGradient = LinearGradient(
    colors: [Colors.blue.shade800, Colors.blue.shade600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: appBarGradient),
        ),
        title: const Text('User Profile Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //banner
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: appBarGradient,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
            ),

            //pfp
            Container(
              transform: Matrix4.translationValues(0, -50, 0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.lightBlue.shade100,
                        child: _profileImageBytes != null
                            ? CircleAvatar(
                                radius: 46,
                                backgroundImage: MemoryImage(_profileImageBytes!),
                              )
                            : const CircleAvatar(
                                radius: 46,
                                backgroundColor: Colors.white,
                              ),
                      ),
                      // Camera icon to change pfp
                      Positioned(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.camera_alt,
                                size: 18, color: Constants.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    program,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: toggleEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(isEditing ? 'Save Profile' : 'Edit Profile'),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Account Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ),

                  buildInfoRow('Full Name:', Text(fullName)),
                  buildInfoRow(
                    'Username:',
                    isEditing
                        ? TextField(controller: usernameController)
                        : Text(username),
                  ),
                  buildInfoRow('Program:', Text(program)),
                  buildInfoRow('Student ID No:', Text(studentId)),
                  buildInfoRow(
                    'Year & Section:',
                    isEditing
                        ? TextField(controller: yrAndSecController)
                        : Text(yrAndSec),
                  ),
                  buildInfoRow('College:', Text(college)),
                  buildInfoRow('School Email:', Text(schoolEmail)),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: changePassword,
                      icon: const Icon(Icons.lock_reset, color: Colors.white),
                      label: const Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor,
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.history, color: Constants.primaryColor),
                    title: const Text('View Election History'),
                    subtitle: const Text('Votes Status, Election Title'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: viewElectionHistory,
                  ),

                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton.icon(
                      onPressed: () {
                        // Change Log out
                      },
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
