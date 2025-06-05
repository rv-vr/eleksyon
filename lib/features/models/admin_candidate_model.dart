class AdminCandidate {
  String id;
  String name;
  String course;
  String year;
  String runningFor;
  String party;
  String? imagePath; 

  AdminCandidate({
    required this.id,
    required this.name,
    required this.course,
    required this.year,
    required this.runningFor,
    required this.party,
    this.imagePath,
  });
}