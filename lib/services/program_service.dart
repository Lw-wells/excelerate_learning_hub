import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/program_model.dart';

class ProgramService {
  final CollectionReference _programsRef = FirebaseFirestore.instance
      .collection('programs');

  // Fetch once
  Future<List<Program>> loadPrograms() async {
    final snapshot = await _programsRef.get();
    return snapshot.docs.map((doc) {
      return Program.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Live updates stream
  Stream<List<Program>> listenToPrograms() {
    return _programsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Program.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  // Submit enrollment
  Future<void> enrollUser(Map<String, dynamic> enrollmentData) async {
    await FirebaseFirestore.instance.collection('enrollments').add(enrollmentData);
  }
}

// import 'dart:convert';
// import 'package:flutter/services.dart';
// import '../models/program_model.dart';

// class ProgramService {
//   Future<List<Program>> loadPrograms() async {
//     try {
//       final String response = await rootBundle.loadString(
//         'assets/data/programs.json',
//       );
//       final List<dynamic> data = json.decode(response);
//       return data.map((program) => Program.fromJson(program)).toList();
//     } catch (e) {
//       throw Exception('Failed to load programs: $e');
//     }
//   }
// }
