import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat/screens/dashboard_screen.dart';
import 'package:global_chat/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    /// check for user login
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (currentUser == null) {
          openLogin();
        } else {
          openDashboard();
        }
      },
    );
    super.initState();
  }

  void openLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void openDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
