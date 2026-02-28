class Program {
  final String id; // Changed from int because Firestore uses string doc IDs
  final String title;
  final String description;
  final String image;
  final String duration;
  final String category;
  final String date;

  Program({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.duration,
    required this.category,
    required this.date,
  });

  // Existing JSON support
  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'].toString(), // Convert to string
      title: json['title'] ?? 'Untitled Program',
      description: json['description'] ?? 'No description available.',
      image: json['image'] ?? 'assets/softwaretesting.jpg',
      duration: json['duration']?.toString() ?? 'N/A',
      category: json['category'] ?? 'General',
      date: json['date'] ?? 'TBA',
    );
  }

  // NEW — Firestore support
  factory Program.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Program(
      id: documentId,
      title: data['title'] ?? 'Untitled Program',
      description: data['description'] ?? 'No description available.',
      image: data['image'] ?? 'assets/softwaretesting.jpg',
      duration: data['duration']?.toString() ?? 'N/A',
      category: data['category'] ?? 'General',
      date: data['date'] ?? 'TBA',
    );
  }
}

// class Program {
//   final int id;
//   final String title;
//   final String description;
//   final String image;
//   final String duration;
//   final String category;
//   final String date;

//   Program({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.duration,
//     required this.category,
//     required this.date,
//   });

//   factory Program.fromJson(Map<String, dynamic> json) {
//     return Program(
//       id: json['id'] ?? 0,
//       title: json['title'] ?? 'Untitled Program',
//       description: json['description'] ?? 'No description available.',
//       image: (json['image'] != null && json['image'].toString().isNotEmpty)
//           ? json['image']
//           : 'assets/softwaretesting.jpg',
//       duration:
//           json['duration']?.toString() ??
//           json['durationWeeks']?.toString() ??
//           'N/A',
//       category: json['category'] ?? 'General',
//       date: json['date'] ?? 'TBA',
//     );
//   }
// }
