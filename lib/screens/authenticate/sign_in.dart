import 'dart:convert';

import 'package:factory_management_ctse/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Colors.blue,
  );

  final AuthService _authService = AuthService();
  //text feild
  String email = '';
  String password = '';
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in Factory Management'),
        actions: <Widget>[
          TextButton(
            style: flatButtonStyle,
            onPressed: () {
              print('Register');
              widget.toggleView();
              //service.signOut();
            },
            child: Icon(Icons.person),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 29.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    print("fetching inside sign in button");
                    const url = "http://10.0.2.2:4000/getdeep/";
                    final uri = Uri.parse(url);
                    try {
                      final responce = await http.get(uri);
                      final body = responce.body;
                      final json = jsonDecode(body);
                      print(json);
                      print(email);
                      print(password);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
