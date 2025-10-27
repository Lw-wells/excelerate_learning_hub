import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart';
import 'screens/home_screen.dart';
import 'screens/program_listing_screen.dart';
import 'screens/program_details_screen.dart';
import 'services/program_service.dart';

void main() async {
  // ✅ Ensure Flutter is fully initialized before loading assets
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Optional: Preload mock data (for debugging or testing)
  final programs = await ProgramService().loadPrograms();
  debugPrint('Loaded ${programs.length} programs from JSON!');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Programs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      // ✅ Start from Sign In Screen
      initialRoute: '/signIn',

      routes: {
        '/signIn': (context) => const SignInScreen(),
        '/home': (context) => const HomeScreen(),
        '/programListing': (context) => const ProgramListingScreen(),
      },

      // ✅ Handle dynamic route for Program Details (with data)
      onGenerateRoute: (settings) {
        if (settings.name == '/programDetails') {
          final dynamic program = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => ProgramDetailsScreen(
              program: program,
              title: '',
              date: '',
              category: '',
              description: '',
            ),
          );
        }
        return null;
      },
    );
  }
}









// import 'package:flutter/material.dart';
// import 'screens/sign_in_screen.dart';
// import 'screens/home_screen.dart';
// import 'screens/program_listing_screen.dart';
// import 'screens/program_details_screen.dart';
// import 'services/program_service.dart';

// // import 'screens/program_listing_screen.dart' show Program;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Excelerate Programs',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.grey,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           foregroundColor: Colors.black,
//           titleTextStyle: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),

//       // ✅ Start from Sign In Screen
//       initialRoute: '/signIn',

//       routes: {
//         '/signIn': (context) => const SignInScreen(),
//         '/home': (context) => const HomeScreen(),
//         '/programListing': (context) => const ProgramListingScreen(),
//       },

//       // ✅ Handle dynamic route for Program Details (with data)
//       onGenerateRoute: (settings) {
//         if (settings.name == '/programDetails') {
//           final dynamic program = settings.arguments;
//           return MaterialPageRoute(
//             builder: (context) => ProgramDetailsScreen(
//               program: program,
//               title: '',
//               date: '',
//               category: '',
//               description: '',
//             ),
//           );
//         }
//         return null;
//       },
//     );
//   }
// }

