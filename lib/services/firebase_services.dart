import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:userlogin_web/pages/loginpage.dart';

import '../pages/homepage.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      );

  Future<void> signInWithGoogle(context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      debugPrint(authResult.user?.email);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomePage(
                  isSignOut: true,
                )),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);

      rethrow;
    }
  }

  Future<void> signOut(context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
