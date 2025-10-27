import 'package:flutter/material.dart';
import 'package:excelerate_app/models/program_model.dart';
import 'package:excelerate_app/screens/program_details_screen.dart';
import 'package:excelerate_app/services/program_service.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  late Future<List<Program>> _futurePrograms;

  @override
  void initState() {
    super.initState();
    // ✅ Properly load programs from JSON or API
    _futurePrograms = ProgramService().loadPrograms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'All Programs',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12),

            // --- Search Bar ---
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search programs...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFEFEFEF),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            // --- Dynamic Program List ---
            Expanded(
              child: FutureBuilder<List<Program>>(
                future: _futurePrograms,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // 🌀 Loading state
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // ⚠️ Error state
                    return Center(
                      child: Text(
                        'Unable to load programs. Please try again later.',
                        style: TextStyle(color: Colors.red[700], fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // 📭 Empty state
                    return const Center(
                      child: Text(
                        'No programs available at the moment.',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    );
                  } else {
                    // ✅ Success: Display data
                    final programs = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: programs.length,
                      itemBuilder: (context, index) {
                        return ProgramCard(program: programs[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Reusable Program Card ---
class ProgramCard extends StatelessWidget {
  final Program program;

  const ProgramCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // --- Program Image ---
          Image.asset(
            program.image,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // --- Title ---
                Text(
                  program.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // --- Description ---
                Text(
                  program.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 12),

                // --- Duration and Date ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${program.duration} weeks • ${program.date}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),

                    // --- View Details Button ---
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/programDetails',
                          arguments: program,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('View Details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





//REPLACED CODE
// import 'package:excelerate_app/models/programs.dart';
// import 'package:flutter/material.dart';
// import 'program_details_screen.dart';

// // --- Data Model for a Program ---
// // class Program {
// //   final String title;
// //   final String description;
// //   final int durationWeeks;
// //   final String image;

// //   const Program({
// //     required this.title,
// //     required this.description,
// //     required this.durationWeeks,
// //     required this.image,
// //   });
// // }

// // --- Sample Data ---
// final List<Program> mockPrograms = [
//   Program(
//     title: 'Advanced Javascript Course',
//     description:
//         'Master modern Javascript concepts and frameworks for web development.',
//     durationWeeks: 8,
//     image: 'assets/javascript.jpg',
//     category: '',
//   ),
//   Program(
//     title: 'UX Design Principles',
//     description:
//         'Learn user experience design fundamentals and create intuitive interfaces.',
//     durationWeeks: 6,
//     image: 'assets/uxui.jpg',
//     category: '',
//   ),
//   Program(
//     title: 'Project Management Certification',
//     description:
//         'Comprehensive project management training with industry certification.',
//     durationWeeks: 12,
//     image: 'assets/project.jpg',
//     category: '',
//   ),
//   Program(
//     title: 'Mobile App Development',
//     description:
//         'Build native and cross-platform mobile applications from scratch.',
//     durationWeeks: 10,
//     image: 'assets/mobile.jpg',
//     category: '', // ✅ fixed typo here
//   ),
// ];

// // --- Main Program Listing Screen ---
// class ProgramListingScreen extends StatelessWidget {
//   const ProgramListingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text(
//           'All Programs',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         foregroundColor: Colors.black,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const SizedBox(height: 12),

//             // --- Search Bar ---
//             const Padding(
//               padding: EdgeInsets.only(bottom: 16.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search programs...',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Color(0xFFEFEFEF),
//                   contentPadding: EdgeInsets.symmetric(vertical: 0),
//                 ),
//               ),
//             ),

//             // --- Program List ---
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: mockPrograms.length,
//                 itemBuilder: (context, index) {
//                   return ProgramCard(program: mockPrograms[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),

      // --- Bottom Navigation Bar ---
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   currentIndex: 1,
      //   selectedItemColor: Colors.brown[800],
      //   unselectedItemColor: Colors.grey,
      // //   items: const [
      // //     BottomNavigationBarItem(
      // //       icon: Icon(Icons.home_outlined),
      // //       label: 'Home',
      // //     ),
      // //     BottomNavigationBarItem(
      // //       icon: Icon(Icons.explore_outlined),
      // //       label: 'Explore',
      // //     ),
      // //     BottomNavigationBarItem(
      // //       icon: Icon(Icons.shopping_cart_outlined),
      // //       label: 'Cart',
      // //     ),
      // //     BottomNavigationBarItem(
      // //       icon: Icon(Icons.notifications_outlined),
      // //       label: 'Notifications',
      // //     ),
      // //     BottomNavigationBarItem(
      // //       icon: Icon(Icons.person_outlined),
      // //       label: 'Profile',
      // //     ),
      // //   ],
      // // ),
//     );
//   }
// }

// // --- Program Card Widget ---
// class ProgramCard extends StatelessWidget {
//   final Program program;

//   const ProgramCard({super.key, required this.program});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
//       ),
//       elevation: 0,
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // --- Program Image ---
//           Image.asset(
//             program.image,
//             height: 180,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),

//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 // --- Title ---
//                 Text(
//                   program.title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // --- Description ---
//                 Text(
//                   program.description,
//                   style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                 ),
//                 const SizedBox(height: 12),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     // --- Duration ---
//                     Text(
//                       '${program.durationWeeks} weeks',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),

//                     // --- View Details Button ---
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProgramDetailsScreen(
//                               program: program,
//                               title: '',
//                               date: '',
//                               category: '',
//                               description: '',
//                             ),
//                           ),
//                         );
//                       },

//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black87,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 10,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: const Text('View Details'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




//OLD CODE
// import 'package:flutter/material.dart';
// import 'program_details_screen.dart';

// // --- Data Model for a Program ---
// class Program {
//   final String title;
//   final String description;
//   final int durationWeeks;

//   const Program({
//     required this.title,
//     required this.description,
//     required this.durationWeeks,
//     required String image,
//   });
// }

// // --- Sample Data ---
// const List<Program> mockPrograms = [
//   Program(
//     title: 'Advanced Javascript Course',
//     description:
//         'Master modern Javascript concepts and frameworks for web development',
//     durationWeeks: 8,
//     image: 'assets/javascript.jpg',
//   ),
//   Program(
//     title: 'UX Design Principles',
//     description:
//         'Learn user experience design fundamentals and create intuitive interfaces',
//     durationWeeks: 6,
//     image: 'assets/uxui.jpg',
//   ),
//   Program(
//     title: 'Project Management Certification',
//     description:
//         'Comprehensive project management training with industry certification',
//     durationWeeks: 12,
//     image: 'assets/project.jpg',
//   ),
//   Program(
//     title: 'Mobile App Development',
//     description:
//         'Build native and cross-platform mobile applications from scratch',
//     durationWeeks: 10,
//     image: 'assests/mobile.jpg',
//   ),
// ];

// // --- Main Program Listing Screen ---
// class ProgramListingScreen extends StatelessWidget {
//   const ProgramListingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text(
//           'All Programs',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         foregroundColor: Colors.black,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const SizedBox(height: 12),

//             // --- Search Bar ---
//             const Padding(
//               padding: EdgeInsets.only(bottom: 16.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search programs...',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Color(0xFFEFEFEF),
//                   contentPadding: EdgeInsets.symmetric(vertical: 0),
//                 ),
//               ),
//             ),

//             // --- Program List ---
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: mockPrograms.length,
//                 itemBuilder: (context, index) {
//                   return ProgramCard(program: mockPrograms[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),

//       // --- Bottom Navigation Bar ---
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         currentIndex: 1,
//         selectedItemColor: Colors.brown[800],
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore_outlined),
//             label: 'Explore',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart_outlined),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_outlined),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outlined),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // --- Program Card Widget ---
// class ProgramCard extends StatelessWidget {
//   final Program program;

//   const ProgramCard({super.key, required this.program});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
//       ),
//       elevation: 0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // --- Title ---
//             Text(
//               program.title,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),

//             // --- Description ---
//             Text(
//               program.description,
//               style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//             ),
//             const SizedBox(height: 12),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 // --- Duration ---
//                 Text(
//                   '${program.durationWeeks} weeks',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),

//                 // --- View Details Button ---
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ProgramDetailsScreen(
//                           program: program,
//                           title: '',
//                           date: '',
//                           category: '',
//                           description: '',
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black87,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text('View Details'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import '../models/programs.dart';
// import 'program_details_screen.dart';

// class ProgramListingScreen extends StatelessWidget {
//   final List<Program> programs = [
//     Program(
//       title: "Mobile App Development with Flutter",
//       description:
//           "Learn to build cross-platform apps for Android and iOS using Dart and Flutter.",
//       imageUrl:
//           "https://images.unsplash.com/photo-1587620962725-abab7fe55159?auto=format&fit=crop&w=800&q=60",
//       durationWeeks: 10,
//     ),
//     Program(
//       title: "Full-Stack Web Development (MERN)",
//       description:
//           "Master MongoDB, Express, React, and Node.js to become a full-stack engineer.",
//       imageUrl:
//           "https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=800&q=60",
//       durationWeeks: 12,
//     ),
//     Program(
//       title: "AI for Software Engineering",
//       description:
//           "Explore how AI is transforming software development and automation.",
//       imageUrl:
//           "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=60",
//       durationWeeks: 8,
//     ),
//   ];

//   ProgramListingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Available Programs")),
//       body: ListView.builder(
//         itemCount: programs.length,
//         itemBuilder: (context, index) {
//           final program = programs[index];
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 3,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: ListTile(
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   program.imageUrl,
//                   width: 70,
//                   height: 70,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               title: Text(
//                 program.title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               subtitle: Text(
//                 program.description,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               trailing: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           ProgramDetailsScreen(program: program),
//                     ),
//                   );
//                 },
//                 child: const Text("View Details"),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
