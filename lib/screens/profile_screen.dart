import 'package:flutter/material.dart';

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
  final String? profileImageUrl; // Optional, for dynamic profile picture
  final List<UserProgram> enrolledPrograms;

  const User({
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.enrolledPrograms,
  });
}

// --- Sample Dynamic User Data ---
// This could come from an API call, local storage, or user input
User sampleUser = const User(
  name: 'Miriam Jones',
  email: 'miriam@gmail.com',
  profileImageUrl:
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Example image
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
      // Example of adding more dynamic programs
      title: 'Flutter Development',
      status: ProgramEnrollmentStatus.inProgress,
    ),
  ],
);

// --- Profile Screen Widget (Stateful for dynamic updates) ---
class ProfileScreen extends StatefulWidget {
  final User user; // Pass the user object to the screen

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _currentUser; // Use _currentUser to manage state internally

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  // Example function to simulate updating user data
  void _updateUser(User newUser) {
    setState(() {
      _currentUser = newUser;
    });
    // In a real app, you might save this to a database or local storage
  }

  // Example function to simulate adding a new program
  void _addProgram(UserProgram newProgram) {
    setState(() {
      _currentUser = User(
        name: _currentUser.name,
        email: _currentUser.email,
        profileImageUrl: _currentUser.profileImageUrl,
        enrolledPrograms: [..._currentUser.enrolledPrograms, newProgram],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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

                  // --- Profile Picture ---
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200], // Placeholder background
                    backgroundImage:
                        _currentUser.profileImageUrl != null &&
                            _currentUser.profileImageUrl!.isNotEmpty
                        ? NetworkImage(_currentUser.profileImageUrl!)
                        : null, // Use NetworkImage if URL exists
                    child:
                        _currentUser.profileImageUrl == null ||
                            _currentUser.profileImageUrl!.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey[600],
                          ) // Fallback icon
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // --- User Name ---
                  Text(
                    _currentUser.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // --- User Email ---
                  Text(
                    _currentUser.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 32),

                  // --- "My Programs" Heading ---
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

                  // --- List of Enrolled Programs ---
                  ListView.builder(
                    shrinkWrap:
                        true, // Important for nested ListView in SingleChildScrollView
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable internal scrolling
                    itemCount: _currentUser.enrolledPrograms.length,
                    itemBuilder: (context, index) {
                      final program = _currentUser.enrolledPrograms[index];
                      return ProgramStatusCard(program: program);
                    },
                  ),
                  const SizedBox(height: 32), // Space before logout button
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
                  // TODO: Implement actual logout logic
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
      // --- Bottom Navigation Bar (reused) ---
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '5',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: ClipOval(
              child:
                  _currentUser.profileImageUrl != null &&
                      _currentUser.profileImageUrl!.isNotEmpty
                  ? Image.network(
                      _currentUser.profileImageUrl!,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: 24,
                      ), // Fallback if image fails to load
                    )
                  : const Icon(Icons.person, size: 24),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: 4, // Assuming 'Profile' is the current view
      ),
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
      color: Colors.white, // Explicitly white background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            // --- Checkbox/Status Placeholder ---
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              // You can customize this further based on status, e.g., a checkmark
              // if (program.status == ProgramEnrollmentStatus.completed)
              //   child: Icon(Icons.check, color: Colors.green),
            ),
            const SizedBox(width: 16),

            // --- Program Title and Status Text ---
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

            // --- Arrow Icon ---
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

// --- Main function to run the app (for testing) ---
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Profile Screen Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.grey,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           iconTheme: IconThemeData(color: Colors.black),
//           titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light grey background for the whole screen
//       ),
//       home: ProfileScreen(user: sampleUser), // Pass the sample user
//     );
//   }
// }
