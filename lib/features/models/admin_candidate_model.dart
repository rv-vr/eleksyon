class AdminCandidate {
  String id;
  String name;
  String course;
  String year;
  String runningFor;
  String party;
  String? imagePath; // For existing images (asset path)
  // Uint8List? imageBytes; // For new/edited image from picker

  AdminCandidate({
    required this.id,
    required this.name,
    required this.course,
    required this.year,
    required this.runningFor,
    required this.party,
    this.imagePath,
    // this.imageBytes,
  });
}