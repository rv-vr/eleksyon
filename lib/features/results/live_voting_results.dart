import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eleksyon/components/constants.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart
// import 'dart:async';
// import 'dart:math';

// --- Placeholder Models ---
class LivePositionResult {
  final String positionId;
  final String positionTitle;
  final List<LiveCandidateResult> candidateResults;

  LivePositionResult({
    required this.positionId,
    required this.positionTitle,
    required this.candidateResults,
  });
}

class LiveCandidateResult {
  final String id;
  final String name;
  int voteCount;
  final String party;
  final String imageUrl;

  LiveCandidateResult({
    required this.id,
    required this.name,
    required this.voteCount,
    required this.party,
    required this.imageUrl,
  });
}
// --- End Placeholder Models ---

class LiveVotingResultsPage extends StatefulWidget {
  const LiveVotingResultsPage({super.key});

  @override
  State<LiveVotingResultsPage> createState() => _LiveVotingResultsPageState();
}

class _LiveVotingResultsPageState extends State<LiveVotingResultsPage> {
  final List<LivePositionResult> _allLiveResults = [
    LivePositionResult(
      positionId: 'pres_live', positionTitle: 'President (Live)',
      candidateResults: [
        LiveCandidateResult(id: 'lc1', name: 'Daniel C.', party: 'TDA', voteCount: 75, imageUrl: 'candidates/DC001.jpg'),
        LiveCandidateResult(id: 'lc2', name: 'Matthew M.', party: 'CompuTeam', voteCount: 60, imageUrl: 'candidates/MM002.jpg'),
      ],
    ),
    LivePositionResult(
      positionId: 'vp_live', positionTitle: 'Vice President (Live)',
      candidateResults: [
        LiveCandidateResult(id: 'lc3', name: 'Candidate G.', party: 'Party X', voteCount: 40, imageUrl: 'candidates/placeholder.png'),
        LiveCandidateResult(id: 'lc4', name: 'Candidate D.', party: 'Party Y', voteCount: 95, imageUrl: 'candidates/placeholder.png'),
      ],
    ),
  ];

  String? _selectedPositionId;
  LivePositionResult? _currentDisplayResult;
  // Timer? _updateTimer; // For live simulation

  @override
  void initState() {
    super.initState();
    if (_allLiveResults.isNotEmpty) {
      _selectedPositionId = _allLiveResults.first.positionId;
      _filterResults(_selectedPositionId);
    }
    // Simulate live updates (uncomment if needed)
    // _updateTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
    //   if (_currentDisplayResult != null && mounted) {
    //     setState(() {
    //       for (var candidate in _currentDisplayResult!.candidateResults) {
    //         candidate.voteCount += Random().nextInt(3); // Add 0, 1, or 2 votes
    //       }
    //       _currentDisplayResult!.candidateResults.sort((a, b) => b.voteCount.compareTo(a.voteCount));
    //     });
    //   }
    // });
  }

  // @override
  // void dispose() {
  //   _updateTimer?.cancel();
  //   super.dispose();
  // }

  void _filterResults(String? positionId) {
    setState(() {
      _selectedPositionId = positionId;
      if (positionId == null) {
        _currentDisplayResult = null;
      } else {
        _currentDisplayResult = _allLiveResults.firstWhere(
          (r) => r.positionId == positionId,
          orElse: () => _allLiveResults.first,
        );
        _currentDisplayResult?.candidateResults.sort((a, b) => b.voteCount.compareTo(a.voteCount));
      }
    });
  }

  BarChartData _createLiveBarChartData(List<LiveCandidateResult> data) {
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
              color: Constants.primaryColor.withOpacity(0.85),
              width: 18,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        ),
      );
    }
    maxY = maxY == 0 ? 10 : maxY + (maxY * 0.1);


    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: maxY,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
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
            reservedSize: 30,
            getTitlesWidget: (double value, TitleMeta meta) {
              final index = value.toInt();
              if (index >= 0 && index < data.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    data[index].name.split(' ').first,
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
            reservedSize: 35,
             getTitlesWidget: (double value, TitleMeta meta) {
              if (value % (maxY / 5).ceil() == 0 || value == maxY || value == 0) {
                 return Text(
                    value.toInt().toString(),
                    style: GoogleFonts.inter(color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 9),
                    textAlign: TextAlign.left,
                  );
              }
              return const Text('');
            },
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          left: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      barGroups: barGroups,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: (maxY / 5).ceilToDouble(),
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.grey.shade200, strokeWidth: 0.8);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Constants.secondaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Live Voting Results', style: GoogleFonts.inter(fontWeight: FontWeight.w900, color: Constants.secondaryColor)),
        backgroundColor: Constants.primaryColor,
        elevation: 1.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Constants.secondaryColor),
            tooltip: 'Refresh Data',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Simulating data refresh...', style: GoogleFonts.inter()), duration: const Duration(seconds: 1))
              );
              _filterResults(_selectedPositionId); // Re-filter to apply any simulated changes
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Select Position',
                hintStyle: GoogleFonts.inter(color: Colors.grey.shade600),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Constants.primaryColor, width: 1.5)),
                filled: true,
                fillColor: Constants.secondaryColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              value: _selectedPositionId,
              icon: Icon(Icons.arrow_drop_down_rounded, color: Constants.primaryColor),
              isExpanded: true,
              items: _allLiveResults.map((position) {
                return DropdownMenuItem<String>(
                  value: position.positionId,
                  child: Text(position.positionTitle, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                );
              }).toList(),
              onChanged: _filterResults,
            ),
          ),
          Expanded(
            child: _currentDisplayResult == null
                ? Center(child: Text(_allLiveResults.isEmpty ? 'No live results available.' : 'Select a position to view live results.', style: GoogleFonts.inter(fontSize: 16, color: Colors.grey)))
                : SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_currentDisplayResult!.candidateResults.isNotEmpty)
                          SizedBox(
                            height: 220, // Adjust height
                            child: BarChart(
                              _createLiveBarChartData(_currentDisplayResult!.candidateResults),
                              swapAnimationDuration: const Duration(milliseconds: 150), // Faster for live feel
                              swapAnimationCurve: Curves.linear,
                            ),
                          )
                        else
                          Container(
                            height: 220, alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                            child: Text('No candidates or votes yet for ${_currentDisplayResult!.positionTitle}', style: GoogleFonts.inter(color: Colors.grey.shade600, fontSize: 12)),
                          ),
                        const Divider(height: 20, thickness: 0.5),
                        ..._currentDisplayResult!.candidateResults.map((candidate) {
                           bool isLeading = _currentDisplayResult!.candidateResults.isNotEmpty && candidate.id == _currentDisplayResult!.candidateResults.first.id && _currentDisplayResult!.candidateResults.first.voteCount > 0;
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                              color: isLeading ? Constants.primaryColor.withAlpha(20) : Constants.secondaryColor,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: isLeading ? Constants.primaryColor.withAlpha(100) : Colors.grey.shade200, width: isLeading ? 1.5 : 1),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(radius: 22, backgroundImage: AssetImage(candidate.imageUrl), backgroundColor: Colors.grey.shade200),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        candidate.name,
                                        style: GoogleFonts.inter(fontWeight: isLeading ? FontWeight.w800 : FontWeight.w600, fontSize: 16, color: isLeading ? Constants.primaryColor : Colors.black87),
                                      ),
                                      Text(candidate.party, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade600)),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${candidate.voteCount} votes',
                                  style: GoogleFonts.inter(fontWeight: isLeading ? FontWeight.bold : FontWeight.w600, fontSize: 15, color: isLeading ? Constants.primaryColor : Colors.black),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}