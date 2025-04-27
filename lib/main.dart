import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './components/bottomnavbar.dart';
import 'pages/candidatelist.dart';

void main() {
  runApp(const EleksyonUI());
}

class EleksyonUI extends StatefulWidget {
  const EleksyonUI({super.key});
  

  @override
  State<EleksyonUI> createState() => _EleksyonUIState();
}

class _EleksyonUIState extends State<EleksyonUI> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap Elect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.inter().fontFamily
      ),
      home: EleksyonUIUI(),
    );
  }
}

class EleksyonUIUI extends StatefulWidget {
  const EleksyonUIUI({super.key});

  @override
  State<EleksyonUIUI> createState() => _EleksyonUIUIState();
}

class _EleksyonUIUIState extends State<EleksyonUIUI> {
  int prevIndex = 0; 
  int pageIndex = 1; 


  void updateState(int tabIndex) {
    setState(() {
      prevIndex = pageIndex; 
      pageIndex = tabIndex;
    });
  }

  void backState(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(
          onTabSelected: updateState,
          currentIndex: pageIndex,
        ),
        body: IndexedStack(
          index: pageIndex,
          children: [
            Center(child: Text('Home Page')),
            CandidateList(),
            Center(child: Text('Vote Page')),
            Center(child: Text('Results Page')),
            Center(child: Text('Profile Page')),
          ],
        ),
      ),
    );
  }
}






