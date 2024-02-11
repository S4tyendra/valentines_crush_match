// main.dart (Entry point of your app)
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valentines_crush_match/auth/gauth.dart';
import 'package:valentines_crush_match/firebase_options.dart';
import 'package:valentines_crush_match/screens/home_screen.dart';
import 'package:valentines_crush_match/screens/login_screen.dart'; // Assuming starting screen

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
    bool loggedin = GAuth().currentUser != null;
    return GetMaterialApp(
      title: 'Valentine\'s Crush Match',
      theme: ThemeData(),
      home: loggedin ? HomeScreen() : LoginScreen(),
    );
  }
}
