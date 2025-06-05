import 'package:eleksyon/components/constants.dart'; // Import your Constants
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import GoogleFonts

// Placeholder for your actual data model
class VoterHistoryItem {
  final String electionTitle;
  final String votedForCandidateName;
  final DateTime electionDate;

  VoterHistoryItem({
    required this.electionTitle,
    required this.votedForCandidateName,
    required this.electionDate,
  });
}

class VoterHistoryPage extends StatefulWidget {
  const VoterHistoryPage({super.key});

  @override
  State<VoterHistoryPage> createState() => _VoterHistoryPageState();
}

class _VoterHistoryPageState extends State<VoterHistoryPage> {
  // Sample data - replace this with your actual data fetching logic
  final List<VoterHistoryItem> _electionHistory = [
    VoterHistoryItem(
      electionTitle: 'Student Council President 2025',
      votedForCandidateName: 'Alice Wonderland',
      electionDate: DateTime(2025, 9, 15),
    ),
    VoterHistoryItem(
      electionTitle: 'Class Secretary Election 2024',
      votedForCandidateName: 'Bob The Builder',
      electionDate: DateTime(2024, 3, 10),
    ),
    VoterHistoryItem(
      electionTitle: 'University Mascot Referendum 2023',
      votedForCandidateName: 'Option Gryphon',
      electionDate: DateTime(2023, 11, 5),
    ),
    // Add more items as needed
  ];

  @override
  void initState() {
    super.initState();
    _electionHistory.sort((a, b) => b.electionDate.compareTo(a.electionDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Voting History',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w900,
            color: Constants.primaryColor,
            fontSize: 20, // Adjusted for AppBar
          ),
        ),
        backgroundColor: Constants.secondaryColor, // White background for AppBar
        elevation: 1.0, // Subtle elevation
        iconTheme: const IconThemeData(
          color: Constants.primaryColor, // Back arrow color
        ),
      ),
      body: _electionHistory.isEmpty
          ? Center(
              child: Text(
                'You have not participated in any elections yet.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0), // Consistent padding
              itemCount: _electionHistory.length,
              itemBuilder: (context, index) {
                final item = _electionHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0), // Spacing between items
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withAlpha(20), // Light background like in CandidateList
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.electionTitle,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800, // Bold title
                          fontSize: 17,
                          color: Constants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Date: ${item.electionDate.toLocal().toString().split(' ')[0]}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Constants.primaryColor.withAlpha(150), // Softer color for date
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You voted for: ${item.votedForCandidateName}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87, // Darker text for voted candidate
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
