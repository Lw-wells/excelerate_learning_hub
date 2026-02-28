import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ Firebase Auth import
import 'package:google_sign_in/google_sign_in.dart'; // ✅ Google Sign-In import
import '../models/enrollment_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required Type user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String userName = "Guest User";
  String userEmail = "guest@example.com";
  String? userPhotoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadSavedImage();
  }

  // --- Load user info from FirebaseAuth
  void _loadUserData() {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? "No Name";
        userEmail = user.email ?? "No Email";
        userPhotoUrl = user.photoURL;
      });
    }
  }

  // --- Load locally saved image (Base64 decoding)
  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString('profile_image');
    if (encoded != null) {
      setState(() {
        _imageBytes = base64Decode(encoded);
      });
    }
  }

  // --- Save picked image locally
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

  // --- Logout (handles both Google and Firebase sign-out)
  Future<void> _logout(BuildContext context) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have been logged out.')),
      );
      Navigator.pushReplacementNamed(context, '/signIn');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final enrolledPrograms =
        ModalRoute.of(context)?.settings.arguments as List<Enrollment>? ??
        <Enrollment>[];

    // --- Determine which profile image to show ---
    ImageProvider<Object> imageProvider;
    if (_imageBytes != null) {
      imageProvider = MemoryImage(_imageBytes!);
    } else if (userPhotoUrl != null) {
      imageProvider = NetworkImage(userPhotoUrl!);
    } else {
      imageProvider = const AssetImage('assets/profile.png');
    }

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

                  // --- Enrolled Programs ---
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
                onPressed: () => _logout(context),
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
