class ElectionPosition {
  final String id;
  final String title;
  final List<CandidateVoteItem> candidates;
  bool hasVoted;

  ElectionPosition({
    required this.id,
    required this.title,
    required this.candidates,
    this.hasVoted = false,
  });
}

class CandidateVoteItem {
  final String id;
  final String name;
  final String party;
  final String imageUrl; // Asset path or network URL

  CandidateVoteItem({
    required this.id,
    required this.name,
    required this.party,
    required this.imageUrl,
  });
}