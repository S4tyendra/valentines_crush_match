// main.dart (Entry point of your app)
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valentines_crush_match/firebase_options.dart';
import 'package:valentines_crush_match/screens/home_screen.dart'; // Assuming starting screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Valentine\'s Crush Match',
      theme: ThemeData(
          // Choose a theme
          ),
      home: LoginScreen(),
    );
  }
}
