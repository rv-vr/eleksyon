import 'package:eleksyon/components/constants.dart'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import '../models/voter_history_model.dart';

class VoterHistoryPage extends StatefulWidget {
  const VoterHistoryPage({super.key});

  @override
  State<VoterHistoryPage> createState() => _VoterHistoryPageState();
}

class _VoterHistoryPageState extends State<VoterHistoryPage> {
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
            fontSize: 20, 
          ),
        ),
        backgroundColor: Constants.secondaryColor, 
        elevation: 1.0, 
        iconTheme: const IconThemeData(
          color: Constants.primaryColor, 
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
              padding: const EdgeInsets.all(16.0), 
              itemCount: _electionHistory.length,
              itemBuilder: (context, index) {
                final item = _electionHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.electionTitle,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800, 
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
                          color: Constants.primaryColor.withAlpha(150), 
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You voted for: ${item.votedForCandidateName}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87, 
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
