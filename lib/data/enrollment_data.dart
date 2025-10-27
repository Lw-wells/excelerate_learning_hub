import 'package:excelerate_app/models/enrollment.dart';

// lib/data/enrollment_data.dart
import '../models/enrollment.dart';

class EnrollmentData {
  static final EnrollmentData _instance = EnrollmentData._internal();
  factory EnrollmentData() => _instance;

  EnrollmentData._internal();

  final List<Enrollment> _enrolledPrograms = [];

  List<Enrollment> get enrolledPrograms => _enrolledPrograms;

  void addEnrollment(Enrollment enrollment) {
    _enrolledPrograms.add(enrollment);
  }

  void clearEnrollments() {
    _enrolledPrograms.clear();
  }
}
