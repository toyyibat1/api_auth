// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;
  var errorMsg;
  //keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//TextEditing controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late ScaffoldMessengerState scaffoldMessenger;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Signup Screen"),
      ),
      body: Form(
        key: _formKey,
        child: _isLoading ?
        Center(child: CircularProgressIndicator())
        :Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,

                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {     
                  setState(() {
                  _isLoading = true;
                });
                  register(_emailController.text, _passwordController.text);
                }
              },
              child: Text(
                'Signup',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  register(String email, pass) async{
    FlutterSecureStorage _storage = FlutterSecureStorage();
    Map data = {
      'email': email,
      'password': pass
    };
    // ignore: avoid_init_to_null
    var jsonResponse = null;
    var response = await http.post(Uri.parse("https://reqres.in/api/register"), 
    headers: {
          "Accept": "application/json",
          // "Content-Type": "application/x-www-form-urlencoded"
        },

    body: data);
    if(response.statusCode == 200){
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null){
        setState(() {
          _isLoading = false;
        });
        await _storage.write(key: "token", value: jsonResponse['token'] );

    // final readregister = await _storage.read(key: "token");
         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SigninScreen()));

      }
       else {
      setState(() {
        _isLoading = false;
      });
      errorMsg = response.body;
      print("The error message is: ${response.body}");
    }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      errorMsg = response.body;
      print("The error message is: ${response.body}");
    }
  }

}
