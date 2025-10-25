import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- 1. Program Status Enum ---
enum ProgramEnrollmentStatus { completed, inProgress, upcoming }

// --- Helper to get status string ---
extension ProgramEnrollmentStatusExtension on ProgramEnrollmentStatus {
  String get displayName {
    switch (this) {
      case ProgramEnrollmentStatus.completed:
        return 'Completed';
      case ProgramEnrollmentStatus.inProgress:
        return 'In Progress';
      case ProgramEnrollmentStatus.upcoming:
        return 'Upcoming';
    }
  }
}

// --- 2. User Program Model ---
class UserProgram {
  final String title;
  final ProgramEnrollmentStatus status;

  const UserProgram({required this.title, required this.status});
}

// --- 3. User Model ---
class User {
  final String name;
  final String email;
  final String? profileImage;
  final bool isAssetImage;
  final List<UserProgram> enrolledPrograms;

  const User({
    required this.name,
    required this.email,
    this.profileImage,
    this.isAssetImage = false,
    required this.enrolledPrograms,
  });
}

// --- Sample Dynamic User Data ---
User sampleUser = const User(
  name: 'Pamwel Flora',
  email: 'flora@gmail.com',
  profileImage: 'assets/person1.jpg',
  isAssetImage: true,
  enrolledPrograms: [
    UserProgram(
      title: 'Leadership Workshop',
      status: ProgramEnrollmentStatus.completed,
    ),
    UserProgram(
      title: 'Digital Marketing',
      status: ProgramEnrollmentStatus.inProgress,
    ),
    UserProgram(
      title: 'Project Management',
      status: ProgramEnrollmentStatus.upcoming,
    ),
    UserProgram(
      title: 'Flutter Development',
      status: ProgramEnrollmentStatus.inProgress,
    ),
  ],
);

// --- Editable Profile Avatar Widget ---
class EditableProfileAvatar extends StatefulWidget {
  final ImageProvider? initialImage;

  const EditableProfileAvatar({super.key, this.initialImage});

  @override
  State<EditableProfileAvatar> createState() => _EditableProfileAvatarState();
}

class _EditableProfileAvatarState extends State<EditableProfileAvatar> {
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imageData = prefs.getString('profile_image');
    if (imageData != null) {
      setState(() {
        _imageBytes = Uint8List.fromList(imageData.codeUnits);
      });
    }
  }

  Future<void> _saveImage(Uint8List bytes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', String.fromCharCodes(bytes));
  }

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
    ImageProvider imageProvider;

    if (_imageBytes != null) {
      imageProvider = MemoryImage(_imageBytes!);
    } else if (widget.initialImage != null) {
      imageProvider = widget.initialImage!;
    } else {
      imageProvider = const AssetImage('assets/person1.png');
    }

    return Stack(
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
    );
  }
}

// --- Profile Screen Widget ---
class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    final profileImageProvider = _currentUser.profileImage != null
        ? (_currentUser.isAssetImage
              ? AssetImage(_currentUser.profileImage!) as ImageProvider
              : NetworkImage(_currentUser.profileImage!))
        : null;

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
                  EditableProfileAvatar(initialImage: profileImageProvider),
                  const SizedBox(height: 16),
                  Text(
                    _currentUser.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _currentUser.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'My Programs',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _currentUser.enrolledPrograms.length,
                    itemBuilder: (context, index) {
                      final program = _currentUser.enrolledPrograms[index];
                      return ProgramStatusCard(program: program);
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
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
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.grey, width: 1),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add_circle_outline),
      //       label: 'Add',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications_outlined),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      //   currentIndex: 4,
      // ),
    );
  }
}

// --- Program Status Card Widget ---
class ProgramStatusCard extends StatelessWidget {
  final UserProgram program;

  const ProgramStatusCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    program.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    program.status.displayName,
                    style: TextStyle(
                      fontSize: 14,
                      color: _getStatusColor(program.status),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ProgramEnrollmentStatus status) {
    switch (status) {
      case ProgramEnrollmentStatus.completed:
        return Colors.green[700]!;
      case ProgramEnrollmentStatus.inProgress:
        return Colors.orange[700]!;
      case ProgramEnrollmentStatus.upcoming:
        return Colors.blue[700]!;
    }
  }
}
