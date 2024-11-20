import 'package:flutter/material.dart';
import 'package:riders_app/views/authScreens/signin_screen.dart';
import 'package:riders_app/views/authScreens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import '../mainScreens/home_screen.dart'; // Import HomeScreen

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    // Listen to authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in, navigate to home screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Dishi Hub",
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white),
                text: "Sign In",
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.white),
                text: "Sign Up",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5,
          ),
        ),
        body: Container(
          color: Colors.black87,
          child: const TabBarView(
            children: [
              SigninScreen(),
              SignupScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
