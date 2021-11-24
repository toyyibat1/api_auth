// ignore_for_file: prefer_const_constructors

import 'package:api_auth/src/views/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Column(
        children: [
          Text("Here is your home"),
          ElevatedButton(
              onPressed: () async {
                // Create storage
                final storage = FlutterSecureStorage();
                // Delete value
                await storage.delete(key: 'token');
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => SigninScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            )
        ],
      ),
    );
  }
}
