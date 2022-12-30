import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:userlogin_web/pages/auth.dart';
import 'package:userlogin_web/services/firebase_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = "";

  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      // isSignOut = true;
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().creatUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
    Icon icon,
    bool title1,
  ) {
    return TextField(
      obscureText: title1,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        suffixIcon: icon,
      ),
    );
  }

  Widget _errorMessege() {
    return Text(
      errorMessage == '' ? '' : 'humm ? $errorMessage',
      style: const TextStyle(color: Colors.red),
    );
  }

  // Widget _submitButton() {
  //   return ElevatedButton(
  //     onPressed:
  //         isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
  //     child: Text(isLogin ? 'Login' : 'Register'),
  //   );
  // }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                FontAwesomeIcons.userAstronaut,
                color: Colors.black,
                size: 70,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Your Logo",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                width: 350,
                // height: MediaQuery.of(context).size.height * 0.7,
                // width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Hello",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please Login to your Account",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: _entryField(
                          'email',
                          _controllerEmail,
                          const Icon(
                            FontAwesomeIcons.envelope,
                            size: 17,
                          ),
                          false),
                    ),
                    SizedBox(
                      width: 250,
                      child: _entryField(
                          'password',
                          _controllerPassword,
                          const Icon(
                            FontAwesomeIcons.eyeSlash,
                            size: 17,
                          ),
                          true),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forget Password",
                            style: TextStyle(
                                fontSize: 15, color: Colors.orangeAccent[700]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _errorMessege(),
                    // _submitButton(),
                    _loginOrRegisterButton(),
                    GestureDetector(
                        onTap: isLogin
                            ? signInWithEmailAndPassword
                            : createUserWithEmailAndPassword,
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF8A2387),
                                  Color(0xFFE94057),
                                  Color(0xFFF27121),
                                ]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              isLogin ? 'Login' : 'Register',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Or Login using Social Media",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.orangeAccent[700],
                        ),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseServices().signInWithGoogle(context);
                            // ignore: use_build_context_synchronously
                          },
                          child: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.orangeAccent[700],
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.solidEnvelope,
                          color: Colors.orangeAccent[700],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
