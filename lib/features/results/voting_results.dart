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
    // 1) Compute maxY with 20% padding
    double maxY = data.fold<double>(
        0, (prev, c) => c.voteCount.toDouble().clamp(prev, double.infinity));
    maxY = (maxY <= 0 ? 10 : maxY) * 1.2;

    // 2) Build one BarChartGroupData per candidate
    final barGroups = data.asMap().entries.map((e) {
      final idx = e.key;
      final c = e.value;
      return BarChartGroupData(
        x: idx,
        barRods: [
          BarChartRodData(
            toY: c.voteCount.toDouble(),
            color: c.id == winnerId
                ? Colors.amber.shade600
                : Constants.primaryColor,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          )
        ],
      );
    }).toList();

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: maxY,
      barGroups: barGroups,

      // 3) Titles on bottom and left
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final i = value.toInt();
              if (i < 0 || i >= data.length) return const SizedBox();
              return Text(
                data[i].name.split(' ').first,
                style: const TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold),
              );
            },
            reservedSize: 30,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              // only label multiples of maxY/5
              final step = (maxY / 5).ceil();
              if (value % step != 0.0 && value != maxY && value != 0.0) {
                return const SizedBox();
              }
              return Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
              );
            },
            reservedSize: 35,
          ),
        ),
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
      ),

      // 4) Simple grid & border
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (maxY / 5),
        getDrawingHorizontalLine: (_) =>
            FlLine(color: Colors.grey.shade300, strokeWidth: 1),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
          left: BorderSide(color: Colors.grey.shade300),
        ),
      ),

      // 5) Enable tooltips with default styling
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem:
              (group, groupIndex, rod, rodIndex) {
            final c = data[group.x.toInt()];
            return BarTooltipItem(
              '${c.name}\n${c.voteCount} votes',
              const TextStyle(color: Colors.white),
            );
          },
        ),
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