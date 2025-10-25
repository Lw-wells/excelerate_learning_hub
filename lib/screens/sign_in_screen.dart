import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Light grey background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Avatar Placeholder
                // Container(
                //   width: 90,
                //   height: 90,
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.black26,
                //   ),
                // ),

                // ✅ Logo Image
                Image.asset(
                  'assets/excelerate.jpeg', // your image path
                  height: 100, // adjust size as needed
                ),
                const SizedBox(height: 24),

                // App Title
                Text(
                  "Excelerate_Hub",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  "Create an account",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                // Small helper text
                Text(
                  "Enter your email to sign up for this app",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Email Input
                TextField(
                  decoration: InputDecoration(
                    hintText: "email@domain.com",
                    hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF4F46E5),
                        width: 1.5,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: // inside SignInScreen: where the Continue button is defined
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Replace current screen so user can't go back to sign-in
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Text(
                      "Continue",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Divider with "or"
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "or",
                        style: GoogleFonts.inter(color: Colors.grey[600]),
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 16),

                // Google Button
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Image.network(
                    'data:image/png;base64,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',
                    height: 20,
                  ),
                  label: Text(
                    "Continue with Google",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Apple Button
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.apple, size: 22, color: Colors.black),
                  label: Text(
                    "Continue with Apple",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Terms and Privacy
                Text.rich(
                  TextSpan(
                    text: "By clicking continue, you agree to our ",
                    style: GoogleFonts.inter(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms of Service",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
