class Enrollment {
  final String name;
  final String email;
  final String experience;
  final String feedback;
  final String programTitle;
  final DateTime timestamp;

  Enrollment({
    required this.name,
    required this.email,
    required this.experience,
    required this.feedback,
    required this.programTitle,
    DateTime? timestamp,
  }) : this.timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'experience': experience,
      'feedback': feedback,
      'programTitle': programTitle,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
