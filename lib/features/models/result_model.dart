class PositionResult {
  final String positionTitle;
  final List<CandidateResult> candidateResults;
  final String? winnerId;

  PositionResult({
    required this.positionTitle,
    required this.candidateResults,
    this.winnerId,
  });
}

class CandidateResult {
  final String id;
  final String name;
  final int voteCount;
  final String party;
  final String imageUrl;

  CandidateResult({
    required this.id,
    required this.name,
    required this.voteCount,
    required this.party,
    required this.imageUrl,
  });
}