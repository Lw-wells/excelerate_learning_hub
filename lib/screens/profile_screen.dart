import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:excelerate_app/data/enrollment_data.dart';
import '../models/enrollment.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required Type user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();
  String userName = "Pamwel Flora";
  String userEmail = "flora@gmail.com";

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  // --- Reload screen when returning (to update enrolled programs)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  // --- Load image from local storage (using Base64 decoding)
  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString('profile_image');
    if (encoded != null) {
      setState(() {
        _imageBytes = base64Decode(encoded);
      });
    }
  }

  // --- Save image locally (Base64 encoding)
  Future<void> _saveImage(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = base64Encode(bytes);
    await prefs.setString('profile_image', encoded);
  }

  // --- Pick new image from gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
      await _saveImage(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final enrolledPrograms =
        ModalRoute.of(context)?.settings.arguments as List<Enrollment>? ??
        <Enrollment>[];
    final ImageProvider<Object> imageProvider = _imageBytes != null
        ? MemoryImage(_imageBytes!)
        : const AssetImage('assets/person1.jpg');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),

                  // --- Editable Avatar ---
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: imageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.brown,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEmail,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 32),

                  // --- Enrolled Programs Section ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'My Enrolled Programs',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  (enrolledPrograms.isEmpty)
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "You haven't enrolled in any program yet.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: enrolledPrograms.length,
                          itemBuilder: (context, index) {
                            final enrollment = enrolledPrograms[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.school_outlined,
                                          color: Colors.brown,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            enrollment.programTitle,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Experience Level: ${enrollment.experience}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    if (enrollment.feedback.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        "Feedback: ${enrollment.feedback}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // --- Logout Button ---
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  print('Logout button pressed');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You have been logged out.')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.brown[800],
                  side: BorderSide(color: Colors.brown[800]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Logout', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
