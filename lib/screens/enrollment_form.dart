import 'package:flutter/material.dart';

// Simple Enrollment model (you can move this to models/enrollment.dart)
class Enrollment {
  final String name;
  final String email;
  final String experience;
  final String feedback;
  final String programTitle;

  Enrollment({
    required this.name,
    required this.email,
    required this.experience,
    required this.feedback,
    required this.programTitle,
  });
}

class EnrollmentFormScreen extends StatefulWidget {
  final String programTitle;
  final Function(Enrollment)? onEnroll; // callback to send enrollment to parent

  const EnrollmentFormScreen({
    super.key,
    required this.programTitle,
    this.onEnroll,
  });

  @override
  State<EnrollmentFormScreen> createState() => _EnrollmentFormScreenState();
}

class _EnrollmentFormScreenState extends State<EnrollmentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // --- Controllers ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  String? _selectedExperience;
  bool _isLoading = false;

  final List<String> _experienceOptions = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  // --- Submit Handler ---
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final enrollment = Enrollment(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        experience: _selectedExperience ?? '',
        feedback: _feedbackController.text.trim(),
        programTitle: widget.programTitle,
      );

      // ✅ Send enrollment to parent or store locally
      widget.onEnroll?.call(enrollment);

      // ✅ Stop loading
      setState(() => _isLoading = false);

      // ✅ Confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '✅ Enrollment successful for ${widget.programTitle}!',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      // ✅ Clear form fields
      _nameController.clear();
      _emailController.clear();
      _feedbackController.clear();
      setState(() => _selectedExperience = null);

      // Optionally pop back after short delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context, enrollment);
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error submitting form. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enroll in ${widget.programTitle}'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Text(
                'Fill in your details below:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // --- Name Field ---
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your name'
                    : null,
              ),
              const SizedBox(height: 16),

              // --- Email Field ---
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- Experience Dropdown ---
              DropdownButtonFormField<String>(
                value: _selectedExperience,
                items: _experienceOptions.map((level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Experience Level',
                  prefixIcon: Icon(Icons.bar_chart_outlined),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) =>
                    setState(() => _selectedExperience = value),
                validator: (value) => value == null
                    ? 'Please select your experience level'
                    : null,
              ),
              const SizedBox(height: 16),

              // --- Feedback Field ---
              TextFormField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Any feedback or goals?',
                  prefixIcon: Icon(Icons.feedback_outlined),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),

              // --- Submit Button ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Submit Enrollment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
