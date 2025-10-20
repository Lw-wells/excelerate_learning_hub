// lib/models/program.dart
class Program {
  final String title;
  final String description;
  final String imageUrl;

  Program({
    required this.title,
    required this.description,
    required this.imageUrl,
    required int durationWeeks,
  });

  get durationWeeks => null;
}
