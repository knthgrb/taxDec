import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tax/constants/colors.dart';
import 'package:tax/main.dart';
import 'package:tax/screens/home_screen.dart';
import 'package:tax/utils/error_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // late final StreamSubscription<AuthState> _authSubscription;

  // @override
  // void initState() {
  //   super.initState();
  //   _redirect();
  // }

  // Future<void> _redirect() async {
  //   _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
  //     final session = event.session;

  //     if (session != null) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const HomeScreen()),
  //       );
  //     }
  //   });
  // }

  // log in function
  Future<void> signInWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final User? user = res.user;
      if (!mounted) return;

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on AuthException catch (error) {
      showErrorDialog(context, "Sign In Error", error.message);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: screenWidth * 0.5,
            decoration: BoxDecoration(color: purpleColor),
            child: Center(
              child: Image.asset(
                "assets/images/image1.png",
                height: 480,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.5,
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      "taxDec",
                      style: TextStyle(
                          fontFamily: "Viga", fontSize: 30, color: purpleColor),
                    )),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Hello, Admin!",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          fontSize: 35,
                          color: darkTextColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Log in to view documents.",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: lightTextColor),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _emailController,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                            hintText: "johndoe@gmail.com",
                            hintStyle: TextStyle(
                                fontFamily: "Inter",
                                color: lightTextColor,
                                fontWeight: FontWeight.normal),
                            labelStyle: TextStyle(
                              color: lightTextColor,
                              letterSpacing: 0,
                              fontFamily: "Inter",
                            ),
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: borderColor, width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _passwordController,
                        cursorHeight: 20,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: lightTextColor,
                                letterSpacing: 0,
                                fontFamily: "Inter"),
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: borderColor, width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 50,
                      child: FilledButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(purpleColor),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: signInWithEmail,
                          child: const Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(fontSize: 16, letterSpacing: 1),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
