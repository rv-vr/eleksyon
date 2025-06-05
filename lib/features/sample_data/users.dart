import 'dart:typed_data';

class User {
  String fullName;
  String userName;
  String program;
  String studentId;
  String yr;
  String section;
  String college;
  String schoolEmail;
  String password;
  Uint8List? profilePicture;

  User({
    required this.fullName,
    required this.userName,
    required this.program,
    required this.studentId,
    required this.yr,
    required this.section,
    required this.college,
    required this.schoolEmail,
    required this.password,
    this.profilePicture,
  });
}

final User suette = User(
    fullName: 'Suette Key Simoy',
    userName: 'suettekey.simoy',
    program: 'BS Computer Science',
    studentId: '2023-2603-I',
    yr: '2nd Year',
    section: 'Section A',
    college: 'College of Arts and Sciences',
    schoolEmail: 'suettekey.simoy@students.isatu.edu.ph',
    password: 'password123'
);