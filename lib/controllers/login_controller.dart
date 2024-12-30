import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../screens/dashboard_screen.dart';

class LoginController {
  static Future<void> loginAccount({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    // Check if email or password is empty
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(
        context,
        message: "Email and password cannot be empty.",
        color: Colors.red,
      );
      return;
    }

    /// Logs in a user with the provided email and password using Firebase Authentication.
    /// Displays appropriate messages for success or failure.
    try {
      // Attempt to sign in the user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Show success message
      _showSnackBar(
        context,
        message: "Login Successfully",
        color: Colors.green,
      );

      // Navigate to the Dashboard screen after a short delay
      await Future.delayed(const Duration(seconds: 1));
      Provider.of<UserProvider>(context,listen: false).getUserDetails();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found with this email.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password. Please try again.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'user-disabled':
          errorMessage = "This user account has been disabled.";
          break;
        default:
          errorMessage = "An unknown error occurred. (${e.message})";
      }

      _showSnackBar(
        context,
        message: errorMessage,
        color: Colors.red,
      );
    } catch (e) {
      // Handle any other errors
      _showSnackBar(
        context,
        message: "An error occurred: ${e.toString()}",
        color: Colors.red,
      );
    }
  }

  /// Helper method to display a SnackBar
  static void _showSnackBar(BuildContext context,
      {required String message, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
