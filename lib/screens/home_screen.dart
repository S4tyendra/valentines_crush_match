// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valentines_crush_match/auth/gauth.dart';

class LoginScreen extends StatelessWidget {
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
                const Text("❤️", style: TextStyle(fontSize: 100), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(200, 86, 244, 54),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  ),
                  icon: Image.asset(
                    'assets/google_logo.webp',
                    height: 24,
                  ),
                  label: const Text('Sign in with Google'),
                  onPressed: _handleSignIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      var authData = await GAuth().signInWithGoogle();
      log(authData.toString());
    } catch (e) {
      Get.dialog(
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
    }
  }
}

Future<void> logout() async {
  GAuth().signOut();
}
