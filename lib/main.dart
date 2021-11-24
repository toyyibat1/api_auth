// ignore_for_file: prefer_const_constructors

import 'package:api_auth/src/views/screens/signup_screen.dart';
import 'package:flutter/material.dart';


  void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group 11 log In page for Abbey Foods',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SignupScreen(),
    );
  }
}

