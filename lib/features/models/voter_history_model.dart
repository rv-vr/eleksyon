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