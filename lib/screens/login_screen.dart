// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valentines_crush_match/auth/gauth.dart';
import 'package:valentines_crush_match/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _buttonController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
        CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 56, 195, 211),
                  Color.fromARGB(255, 232, 61, 216),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "❤️",
                  style: TextStyle(fontSize: 100),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                AnimatedBuilder(
                  animation: _buttonController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _buttonScaleAnimation.value,
                      child: _isLoading
                          ? ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(105, 0, 0, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                              ),
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ))
                          : ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(200, 86, 244, 54),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                              ),
                              icon: Image.asset(
                                'assets/google_logo.webp',
                                height: 24,
                              ),
                              label: const Text('Sign in with Google'),
                              onPressed: _handleSignIn,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    await _buttonController.forward();

    try {
      var authData = await GAuth().signInWithGoogle();
      log(authData.toString());
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      await Get.dialog(
        AlertDialog(
          title: Text((e as dynamic).code.toString()),
          content: Text((e as dynamic).message.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      log(e.toString());
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      _buttonController.reverse();
      setState(() {
        _isLoading = false;
      });
    }
  }
}

Future<void> logout() async {
  GAuth().signOut();
}
