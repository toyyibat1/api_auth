// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:api_auth/src/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class SigninScreen extends StatefulWidget {
  const SigninScreen({ Key? key }) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isLoading = false;
   var errorMsg;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();

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
        title: Text('Signin Screen'),
      ),
      body: Form(
        key: _formKey,
        child: _isLoading 
        ? Center(child: CircularProgressIndicator(),)
        : Column(
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
                  hintText: 'Enter Email'
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
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _isLoading = true;

                });
                if(_emailController.text.isEmpty||_passwordController.text.isEmpty)
                  {
                    Scaffold.of(context).showSnackBar(const SnackBar(content:Text("Please Fill all fileds")));
                    return;
                  }
                login(_emailController.text, _passwordController.text);
              }, 
              child: Text('Signin',  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),) )
          ],),
      ),
    );
  }
  login(String email, pass) async{
    FlutterSecureStorage _storage = FlutterSecureStorage();
    Map data = {
      'email': email,
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.post(Uri.parse("https://reqres.in/api/login"), body: data);
    if(response.statusCode == 200){
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null){
        setState(() {
          _isLoading = false;

        });
        await _storage.write(key: "token", value: jsonResponse['token'] );

    // final readregister = await _storage.read(key: "token");
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> route) => false);
        
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