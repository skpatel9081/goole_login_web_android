import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:userlogin_web/pages/auth.dart';
import 'package:userlogin_web/services/firebase_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.isSignOut}) : super(key: key);
  final bool isSignOut;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    if (widget.isSignOut == true) {
      debugPrint("yes");
      await FirebaseServices().signOut(context);
    } else {
      debugPrint("no");
      await Auth().signOut();
    }
  }

  // Widget _title() {
  Widget _userUid() {
    return Text(user?.email ?? "User email");
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text("Sign Out "),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8A2387),
              Color(0xFFE94057),
              Color(0xFFF27121),
            ],
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userUid(),
            const SizedBox(
              height: 20,
            ),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
