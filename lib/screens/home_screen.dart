// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valentines_crush_match/auth/gauth.dart';
import 'package:valentines_crush_match/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: prefer_final_fields
  TextEditingController _crushNameController = TextEditingController();
  bool _isLocked = false;
  String _lockedCrushName = '';

  void _lockCrushName() {
    setState(() {
      _isLocked = true;
      _lockedCrushName = _crushNameController.text;
    });
  }

  Future<void> _logout() async {
    await GAuth().signOut();
    Get.offAll(() => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valentine\'s Crush Match'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmation'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await _logout();
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _crushNameController,
              enabled: !_isLocked,
              decoration: const InputDecoration(
                labelText: 'Enter your crush name',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLocked ? null : _lockCrushName,
              child: const Text('Lock Crush Name'),
            ),
            const SizedBox(height: 16.0),
            Text(
              _isLocked ? 'Locked Crush Name: $_lockedCrushName' : '',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
