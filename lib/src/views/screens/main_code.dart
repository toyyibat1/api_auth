import 'dart:convert';

import 'package:api_auth/src/model/user.dart';
import 'package:api_auth/src/services/api.dart';
import 'package:flutter/material.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({ Key? key }) : super(key: key);

  @override
  _MyListScreenState createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  // ignore: deprecated_member_use
  var users = <User>[];

  _getUsers(){
    API.getUsers().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model)=> User.fromJson(model)).toList();
      });
    });
  }
  @override
  initState(){
    super.initState();
    _getUsers();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List'),),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
        return ListTile(title: Text(users[index].name!),);
      }) ,
    );
  }
}