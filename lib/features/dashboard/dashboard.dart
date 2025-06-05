import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eleksyon/components/constants.dart';
import '../models/dashboard_model.dart';
import 'vote_confirmation.dart'; 

class VoterDashboardPage extends StatefulWidget {
  const VoterDashboardPage({super.key});

  @override
  State<VoterDashboardPage> createState() => _VoterDashboardPageState();
}

class _VoterDashboardPageState extends State<VoterDashboardPage> {
  final String _userName = "Suette"; 
  final List<ElectionPosition> _electionPositions = [
    ElectionPosition(
      id: 'pres',
      title: 'President',
      candidates: [
        CandidateVoteItem(id: 'c1', name: 'Daniel Catedrilla', party: 'TDA', imageUrl: 'candidates/DC001.jpg'),
        CandidateVoteItem(id: 'c2', name: 'Matthew Mallorca', party: 'CompuTeam', imageUrl: 'candidates/MM002.jpg'),
      ],
    ),
    ElectionPosition(
      id: 'vp',
      title: 'Vice President',
      hasVoted: false, 
      candidates: [
        CandidateVoteItem(id: 'c3', name: 'Candidate Gamma', party: 'Party X', imageUrl: 'candidates/placeholder.png'),
        CandidateVoteItem(id: 'c4', name: 'Candidate Delta', party: 'Party Y', imageUrl: 'candidates/placeholder.png'),
      ],
    ),
  ];

  Future<void> _handleVote(String positionId, String candidateId, String candidateName) async {
    final position = _electionPositions.firstWhere((p) => p.id == positionId);

    final bool? confirmed = await showVoteConfirmationModal(
      context,
      candidateName: candidateName,
      positionTitle: position.title,
    );

    if (confirmed == true) {
      setState(() {
        position.hasVoted = true;
      });
      if (mounted) { 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully voted for $candidateName in ${position.title}!', style: GoogleFonts.inter()),
            backgroundColor: Colors.green.shade700, // Success color
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Text('Vote cancelled.', style: GoogleFonts.inter()),
             backgroundColor: Colors.grey.shade700,
             duration: const Duration(seconds: 2),
           ),
         );
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Eleksyon Dashboard',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w900,
            color: Constants.secondaryColor,
          ),
        ),
        backgroundColor: Constants.primaryColor,
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $_userName!',
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Constants.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cast your vote for the available positions below.',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            if (_electionPositions.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'No elections currently active or all positions have been voted on.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), 
                itemCount: _electionPositions.length,
                itemBuilder: (context, index) {
                  final position = _electionPositions[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ExpansionTile(
                      key: PageStorageKey(position.id), 
                      backgroundColor: Constants.primaryColor.withAlpha(10),
                      collapsedBackgroundColor: Constants.secondaryColor,
                      iconColor: Constants.primaryColor,
                      collapsedIconColor: Constants.primaryColor,
                      initiallyExpanded: !position.hasVoted, 
                      title: Text(
                        position.title,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Constants.primaryColor,
                        ),
                      ),
                      subtitle: Text(
                        position.hasVoted ? 'You have voted for this position' : 'Tap to view candidates and vote',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: position.hasVoted ? Colors.green.shade700 : Colors.grey.shade600,
                        ),
                      ),
                      children: position.candidates.map((candidate) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey.shade200, width: 0.5))
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage(candidate.imageUrl),
                                backgroundColor: Colors.grey.shade200,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      candidate.name,
                                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
                                    ),
                                    Text(
                                      candidate.party,
                                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: position.hasVoted
                                    ? null 
                                    : () => _handleVote(position.id, candidate.id, candidate.name), 
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.primaryColor,
                                  foregroundColor: Constants.secondaryColor,
                                  disabledBackgroundColor: Colors.grey.shade300,
                                  disabledForegroundColor: Colors.grey.shade500,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(position.hasVoted ? 'Voted' : 'Vote'),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}