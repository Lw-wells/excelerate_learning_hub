class Program {
  final int id;
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

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Untitled Program',
      description: json['description'] ?? 'No description available.',
      image: (json['image'] != null && json['image'].toString().isNotEmpty)
          ? json['image']
          : 'assets/softwaretesting.jpg',
      duration:
          json['duration']?.toString() ??
          json['durationWeeks']?.toString() ??
          'N/A',
      category: json['category'] ?? 'General',
      date: json['date'] ?? 'TBA',
    );
  }
}
