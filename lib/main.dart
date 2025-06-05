import 'package:eleksyon/features/login/onboarding.dart';
import 'package:eleksyon/features/results/voting_results.dart';
import 'package:eleksyon/features/user_profile/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './components/bottomnavbar.dart';
import 'features/candidates/candidatelist.dart';
import 'features/dashboard/dashboard.dart'; // Import for Voter Dashboard
import 'features/schedule/election_schedule.dart'; // Import for Election Schedule

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
  int pageIndex = 0; // Default to the first tab (Voter Dashboard)

  // Define the pages for the IndexedStack
  final List<Widget> _pages = [
    const VoterDashboardPage(),      // Tab 1 (index 0)
    const CandidateList(),           // Tab 2 (index 1) - Assuming this was your previous second tab
    const ElectionSchedulePage(),    // Tab 3 (index 2)
    const VotingResultsPage(),       // Tab 4 (index 3) - Main results page
    const UserProfileSettings(),     // Tab 5 (index 4) - Assuming this was your previous last tab
  ];

  void updateState(int tabIndex) {
    setState(() {
      pageIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Assuming your main UI structure uses a Scaffold
      body: IndexedStack(
        index: pageIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar( // Your custom BottomNavBar
        currentIndex: pageIndex,
        onTabSelected: updateState,
        // Ensure your BottomNavBar is configured with 5 items
        // and their icons/labels match these pages.
      ),
    );
  }
}






