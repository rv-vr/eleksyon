import 'package:eleksyon/features/results/live_voting_results.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eleksyon/components/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/result_model.dart';

class VotingResultsPage extends StatefulWidget {
  const VotingResultsPage({super.key});

  @override
  State<VotingResultsPage> createState() => _VotingResultsPageState();
}

class _VotingResultsPageState extends State<VotingResultsPage> {
  final List<PositionResult> _results = [
    PositionResult(
      positionTitle: 'President',
      winnerId: 'cand_res_1',
      candidateResults: [
        CandidateResult(id: 'cand_res_1', name: 'Daniel C.', party: 'TDA', voteCount: 150, imageUrl: 'candidates/DC001.jpg'),
        CandidateResult(id: 'cand_res_2', name: 'Matthew M.', party: 'CompuTeam', voteCount: 120, imageUrl: 'candidates/MM002.jpg'),
      ]..sort((a, b) => b.voteCount.compareTo(a.voteCount)),
    ),
    PositionResult(
      positionTitle: 'Vice President',
      winnerId: 'cand_res_4',
      candidateResults: [
        CandidateResult(id: 'cand_res_3', name: 'Candidate G.', party: 'Party X', voteCount: 90, imageUrl: 'candidates/placeholder.png'),
        CandidateResult(id: 'cand_res_4', name: 'Candidate D.', party: 'Party Y', voteCount: 180, imageUrl: 'candidates/placeholder.png'),
      ]..sort((a, b) => b.voteCount.compareTo(a.voteCount)),
    ),
  ];

  // Helper function to create chart data for fl_chart
  BarChartData _createBarChartData(List<CandidateResult> data, String? winnerId) {
    final List<BarChartGroupData> barGroups = [];
    double maxY = 0;
    for (int i = 0; i < data.length; i++) {
      final candidate = data[i];
      if (candidate.voteCount > maxY) {
        maxY = candidate.voteCount.toDouble();
      }
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: candidate.voteCount.toDouble(),
              color: candidate.id == winnerId ? Colors.amber.shade600 : Constants.primaryColor,
              width: 16, // Adjust bar width
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
          showingTooltipIndicators: [0], // Show tooltip for the first rod
        ),
      );
    }
    // Add a little padding to the top of the Y-axis
    maxY = maxY == 0 ? 10 : maxY + (maxY * 0.1);


    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: maxY,
      barTouchData: BarTouchData(
        enabled: true, // Enable touch interactions
        touchTooltipData: BarTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(8),
          tooltipMargin: 8,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final candidate = data[group.x.toInt()];
            return BarTooltipItem(
              '${candidate.name}\n',
              GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              children: <TextSpan>[
                TextSpan(
                  text: '${rod.toY.toInt()} votes',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ],
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30, // Space for bottom titles
            getTitlesWidget: (double value, TitleMeta meta) {
              final index = value.toInt();
              if (index >= 0 && index < data.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    data[index].name.split(' ').first, // Show first name
                    style: GoogleFonts.inter(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 10),
                  ),
                );
              }
              return const Text('');
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35, // Space for left titles
            getTitlesWidget: (value, meta) {
              return const Text(''); // Hide left titles
            },
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40, // Space for top titles
            getTitlesWidget: (value, meta) {
              return const Text(''); // Hide top titles
            },
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30, // Space for right titles
            getTitlesWidget: (value, meta) {
              return const Text(''); // Hide right titles
            },
          ),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 10,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Election Results', style: GoogleFonts.inter(fontWeight: FontWeight.w900, color: Constants.secondaryColor)),
        backgroundColor: Constants.primaryColor,
        elevation: 1.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _results.isEmpty
                ? Center(child: Text('Results are not yet available.', style: GoogleFonts.inter(fontSize: 16, color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final positionResult = _results[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Constants.secondaryColor,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Constants.primaryColor.withAlpha(30)),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 1)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              positionResult.positionTitle,
                              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w900, color: Constants.primaryColor),
                            ),
                            const SizedBox(height: 10),
                            // Chart for vote distribution
                            Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 6, offset: const Offset(0, 2)),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: BarChart(
                                  _createBarChartData(positionResult.candidateResults, positionResult.winnerId),
                                ),
                              ),
                            ),
                            const Divider(height: 20, thickness: 0.5),
                            Text("Vote Counts:", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black54)),
                            const SizedBox(height: 8),
                            ...positionResult.candidateResults.map((candidate) {
                              bool isWinner = candidate.id == positionResult.winnerId;
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: isWinner ? Constants.primaryColor.withAlpha(25) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: isWinner ? Border.all(color: Constants.primaryColor.withAlpha(150), width: 1.5) : Border.all(color: Colors.grey.shade200),
                                ),
                                child: Row(
                                  children: [
                                    if (isWinner)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Icon(Icons.star_rounded, color: Colors.amber.shade600, size: 22),
                                      ),
                                    CircleAvatar(radius: 20, backgroundImage: AssetImage(candidate.imageUrl), backgroundColor: Colors.grey.shade200),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            candidate.name,
                                            style: GoogleFonts.inter(fontWeight: isWinner ? FontWeight.w800 : FontWeight.w600, fontSize: 15, color: isWinner ? Constants.primaryColor : Colors.black87),
                                          ),
                                          Text(candidate.party, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade600)),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${candidate.voteCount} votes',
                                      style: GoogleFonts.inter(fontWeight: isWinner ? FontWeight.bold : FontWeight.w600, fontSize: 14, color: isWinner ? Constants.primaryColor : Colors.black54),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.live_tv_rounded, color: Colors.white),
                label: Text('Live Results', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LiveVotingResultsPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}