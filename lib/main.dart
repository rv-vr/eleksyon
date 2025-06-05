import 'package:eleksyon/features/login/onboarding.dart';
import 'package:eleksyon/features/results/voting_results.dart';
import 'package:eleksyon/features/user_profile/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './components/bottomnavbar.dart';
import 'features/candidates/candidatelist.dart';
import 'features/dashboard/dashboard.dart'; 
import 'features/schedule/election_schedule.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.inter().fontFamily
      ),
      home: OnboardingPage(),
    );
  }
}

class EleksyonUIUI extends StatefulWidget {
  const EleksyonUIUI({super.key});

  @override
  State<EleksyonUIUI> createState() => _EleksyonUIUIState();
}

class _EleksyonUIUIState extends State<EleksyonUIUI> {
  int pageIndex = 0; 

  final List<Widget> _pages = [
    const VoterDashboardPage(),      
    const CandidateList(),           
    const ElectionSchedulePage(),    
    const VotingResultsPage(),       
    const UserProfileSettings(),     
  ];

  void updateState(int tabIndex) {
    setState(() {
      pageIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: IndexedStack(
        index: pageIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: pageIndex,
        onTabSelected: updateState,
      ),
    );
  }
}






