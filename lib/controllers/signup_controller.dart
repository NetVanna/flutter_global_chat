import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/dashboard_screen.dart';

class SignupController {
  static void createAccount(
      {required BuildContext context,
      required String email,
      required String password,required String name,required String country}) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty || country.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Email, Password, Name and Country cannot be empty.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    /// Creates a user account with email and password using Firebase Authentication.
    /// Displays appropriate messages if the account creation is successful or fails.
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Sign Up Successfully",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "This email is already in use.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'weak-password':
          errorMessage = "The password is too weak.";
          break;
        default:
          errorMessage = "An unknown error occurred.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Error: ${e.toString()}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
