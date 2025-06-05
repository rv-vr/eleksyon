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
