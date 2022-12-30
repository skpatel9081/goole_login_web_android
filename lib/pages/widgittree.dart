import 'package:flutter/material.dart';
import 'package:userlogin_web/pages/auth.dart';
import 'package:userlogin_web/pages/homepage.dart';
import 'package:userlogin_web/pages/loginpage.dart';

class WidgitTree extends StatefulWidget {
  const WidgitTree({Key? key}) : super(key: key);

  @override
  State<WidgitTree> createState() => _WidgitTreeState();
}

class _WidgitTreeState extends State<WidgitTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStatechange,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage(
            isSignOut: false,
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
