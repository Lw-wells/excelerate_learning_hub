import 'package:flutter/material.dart';
import 'package:excelerate_app/models/program_model.dart';
import 'enrollment_form.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final Program program;

  const ProgramDetailsScreen({
    super.key,
    required this.program,
  });

  @override
  Widget build(BuildContext context) {
    final isNetworkImage =
        program.image.startsWith('http') || program.image.startsWith('https');

    int _selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(program.title),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Program Banner Image ---
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: isNetworkImage
                      ? NetworkImage(program.image)
                      : AssetImage(program.image) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // --- Program Details Content ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // --- Program Title ---
                  Text(
                    program.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // --- Category and Date ---
                  Row(
                    children: [
                      const Icon(
                        Icons.category_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        program.category,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.date_range_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        program.date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- About this Program ---
                  const Text(
                    'About this Program',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    program.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // --- Duration ---
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${program.duration} weeks',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // --- Register Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EnrollmentFormScreen(
                              programTitle: program.title,
                            ),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Register for Program',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Feedback Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Feedback feature coming soon!'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.brown[800],
                        side: const BorderSide(
                          color: Color(0xFFDADADA),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Give Feedback',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
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
}

void _onItemTapped(int index) {
  // no-op for now; update to navigate or show state changes if this screen becomes StatefulWidget
}









// import 'package:flutter/material.dart';
// import 'package:excelerate_app/models/programs.dart';

// class ProgramDetailsScreen extends StatelessWidget {
//   final Program program;

//   const ProgramDetailsScreen({
//     super.key,
//     required this.program,
//     required String title,
//     required String date,
//     required String category,
//     required String description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(program.title),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // --- Program Banner Image ---
//             Container(
//               height: 220,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(program.image),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // --- Program Details Content ---
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//                 vertical: 20,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   // --- Program Title ---
//                   Text(
//                     program.title,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // --- Category and Duration ---
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.category_outlined,
//                         color: Colors.grey[600],
//                         size: 18,
//                       ),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           program.description,
//                           style: TextStyle(color: Colors.grey[700]),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 2,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Icon(
//                         Icons.timer_outlined,
//                         color: Colors.grey[600],
//                         size: 18,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         '${program.durationWeeks} weeks',
//                         style: TextStyle(color: Colors.grey[700]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // --- About this Program ---
//                   const Text(
//                     'About this Program',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),

//                   Text(
//                     program.description,
//                     style: const TextStyle(fontSize: 16, height: 1.5),
//                   ),
//                   const SizedBox(height: 40),

//                   // --- Register Button ---
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Registered for ${program.title}!'),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.brown[800],
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: const Text(
//                         'Register for Program',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // --- Feedback Button ---
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: OutlinedButton(
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Feedback feature coming soon!'),
//                           ),
//                         );
//                       },
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: Colors.brown[800],
//                         side: const BorderSide(
//                           color: Color(0xFFDADADA),
//                           width: 1,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: const Text(
//                         'Give Feedback',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
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
//         currentIndex: 0,
//         selectedItemColor: Colors.brown[800],
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),

//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_outlined),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }


