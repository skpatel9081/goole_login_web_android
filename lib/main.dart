import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:userlogin_web/firebase_options.dart';
import 'package:userlogin_web/pages/widgittree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.purple,
    ),
    debugShowCheckedModeBanner: false,
    home: const WidgitTree(),
  ));
}
