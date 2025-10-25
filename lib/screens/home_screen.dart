import 'package:flutter/material.dart';
import 'program_listing_screen.dart' hide Program;
import 'program_details_screen.dart';
import 'package:excelerate_app/models/programs.dart';
import 'explore_screen.dart';
import 'profile_screen.dart';

//

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens for bottom navigation
  List<Widget> get _screens => [
    _buildHomeContent(),
    const ExploreScreen(),
    ProfileScreen(user: sampleUser),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- Main Home Content ---
  Widget _buildHomeContent() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Welcome message
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Welcome, Learner!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),

        // Upcoming Programs
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.brown[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upcoming Programs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Stay updated with the latest learning opportunities',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Featured Programs
        const Text(
          'Featured Programs',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        _buildProgramCard(
          context,
          Program(
            title: 'Web Development Bootcamp',
            description:
                'A hands-on bootcamp to build full-stack web apps using HTML, CSS, JS, and MERN.',
            durationWeeks: 12,
            image: 'assets/web.jpg',
            category: '',
          ),
        ),
        _buildProgramCard(
          context,
          Program(
            title: 'Mobile Development Bootcamp',
            description:
                'Learn how to create cross-platform mobile apps with Flutter and Dart.',
            durationWeeks: 10,
            image: 'assets/mobile.jpg',
            category: '',
          ),
        ),
        _buildProgramCard(
          context,
          Program(
            title: 'Data Science Fundamentals',
            description:
                'Explore Python, data visualization, and machine learning basics.',
            durationWeeks: 8,
            image: 'assets/datascience.jpg',
            category: '',
          ),
        ),
        const SizedBox(height: 20),

        // View All Programs Button
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProgramListingScreen(),
                ),
              );
            },
            child: const Text(
              'View All Programs',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Excelerate_Hub',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/excelerate.jpeg'),
            ),
          ),
        ],
      ),

      // Main body switches between tabs
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // --- Reusable Program Card Widget ---
  Widget _buildProgramCard(BuildContext context, Program program) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 4),
            const Text(
              'Technology Program',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Text(
              program.description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[800],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProgramDetailsScreen(
                      program: program,
                      title: '',
                      date: '',
                      category: '',
                      description: '',
                    ),
                  ),
                );
              },
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'program_listing_screen.dart';
// import 'program_details_screen.dart';
// import 'package:excelerate_app/models/programs.dart' hide Program;

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         title: const Text(
//           'Excelerate_Hub',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Colors.black),
//           onPressed: () {},
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: CircleAvatar(
//               radius: 16,
//               backgroundImage: AssetImage('assets/profile.jpg'),
//             ),
//           ),
//         ],
//       ),

//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           // Welcome message
//           Container(
//             padding: const EdgeInsets.all(12.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               'Welcome, Learner!',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Upcoming Programs
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.brown[800],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Upcoming Programs',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Stay updated with the latest learning opportunities',
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Featured Programs
//           const Text(
//             'Featured Programs',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),

//           _buildProgramCard(
//             context,
//             Program(
//               title: 'Web Development Bootcamp',
//               description:
//                   'A hands-on bootcamp to build full-stack web apps using HTML, CSS, JS, and MERN.',
//               durationWeeks: 12,
//               image: 'assets/web.jpg',
//             ),
//           ),
//           _buildProgramCard(
//             context,
//             Program(
//               title: 'Mobile Development Bootcamp',
//               description:
//                   'Learn how to create cross-platform mobile apps with Flutter and Dart.',
//               durationWeeks: 10,
//               image: 'assets/mobile.jpg',
//             ),
//           ),
//           _buildProgramCard(
//             context,
//             Program(
//               title: 'Data Science Fundamentals',
//               description:
//                   'Explore Python, data visualization, and machine learning basics.',
//               durationWeeks: 8,
//               image: 'assets/datascience.jpg',
//             ),
//           ),

//           const SizedBox(height: 20),

//           // View All Programs Button
//           Center(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.brown[800],
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 40,
//                   vertical: 14,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const ProgramListingScreen(),
//                   ),
//                 );
//               },

//               child: const Text(
//                 'View All Programs',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.brown[800],
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: ''),
//         ],
//       ),
//     );
//   }

//   Widget _buildProgramCard(BuildContext context, Program program) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               program.title,
//               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Technology Program',
//               style: const TextStyle(color: Colors.grey, fontSize: 13),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               program.description,
//               style: const TextStyle(fontSize: 14, color: Colors.black87),
//             ),
//             const SizedBox(height: 12),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.brown[800],
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   '/programDetails',
//                   arguments: program,
//                 );
//               },
//               child: const Text('View Details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }











// import 'package:flutter/material.dart';
// import 'program_listing_screen.dart';
// import 'package:excelerate_app/models/programs.dart' hide Program;
// import 'program_details_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         title: const Text(
//           'Excelerate_Hub',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.menu, color: Colors.black),
//           onPressed: () {},
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: CircleAvatar(
//               radius: 16,
//               backgroundImage: AssetImage('assets/profile.jpg'),
//             ),
//           ),
//         ],
//       ),

//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           // Welcome message
//           Container(
//             padding: const EdgeInsets.all(12.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Text(
//               'Welcome, Learner!',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Upcoming Programs
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.brown[800],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Upcoming Programs',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Stay updated with the latest learning opportunities',
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Featured Programs
//           const Text(
//             'Featured Programs',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),

//           _buildProgramCard(
//             context,
//             Program(
//               title: 'Web Development Bootcamp',
//               description:
//                   'A hands-on bootcamp to build full-stack web apps using HTML, CSS, JS, and MERN.',
//               durationWeeks: 12,
//               image: 'assets/web.jpg',
//             ),
//           ),
//           _buildProgramCard(
//             context,
//             Program(
//               title: 'Mobile Development Bootcamp',
//               description:
//                   'Learn how to create cross-platform mobile apps with Flutter and Dart.',
//               durationWeeks: 10,
//               image: 'assets/mobile.jpg',
//             ),
//           ),
//           _buildProgramCard(
//             context,
//             Program(
//               title: 'Data Science Fundamentals',
//               description:
//                   'Explore Python, data visualization, and machine learning basics.',
//               durationWeeks: 8,
//               image: 'assets/datascience.jpg',
//             ),
//           ),

//           const SizedBox(height: 20),

//           // View All Programs Button
//           Center(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.brown[800],
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 40,
//                   vertical: 14,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const ProgramListingScreen(),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'View All Programs',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.brown[800],
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: ''),
//         ],
//       ),
//     );
//   }

//   /// Builds a single program card with image and details
//   Widget _buildProgramCard(BuildContext context, Program program) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ✅ Image section
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.asset(
//               program.image,
//               width: double.infinity,
//               height: 160,
//               fit: BoxFit.cover,
//             ),
//           ),

//           // ✅ Text and button section
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   program.title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${program.durationWeeks} weeks | Technology',
//                   style: const TextStyle(color: Colors.grey, fontSize: 13),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   program.description,
//                   style: const TextStyle(fontSize: 14, color: Colors.black87),
//                 ),
//                 const SizedBox(height: 12),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.brown[800],
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/programDetails',
//                       arguments: program,
//                     );
//                   },
//                   child: const Text('View Details'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
