import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/program_model.dart';

class ProgramService {
  Future<List<Program>> loadPrograms() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/programs.json',
      );
      final List<dynamic> data = json.decode(response);
      return data.map((program) => Program.fromJson(program)).toList();
    } catch (e) {
      throw Exception('Failed to load programs: $e');
    }
  }
}
