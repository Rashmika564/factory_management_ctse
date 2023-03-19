import 'dart:convert';

import 'package:factory_management_ctse/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

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
  final _formKey = GlobalKey<FormState>();
  //text feild
  String email = '';
  String password = '';
  String error = '';
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
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'password'),
                  obscureText: true,
                  validator: (val) =>
                      val!.length < 6 ? 'Enter an password  g than 6 ' : null,
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
                    if (_formKey.currentState!.validate()) {
                      print(email);
                      print(password);
                      dynamic result =
                          await _authService.SignInWithEmailPassword(
                              email, password);

                      print(result);
                      if (result == null) {
                        print("fgj");
                        setState(() =>
                            error = 'Could Not sign in with these credintials');
                      } else {}
                    }
                    // const url = "http://10.0.2.2:4000/getdeep/";
                    // final uri = Uri.parse(url);
                    // try {
                    //   final responce = await http.get(uri);
                    //   final body = responce.body;
                    //   final json = jsonDecode(body);
                    //   print(json);
                    //   print(email);
                    //   print(password);
                    // } catch (e) {
                    //   print(e.toString());
                    // }
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0)),
              ],
            ),
          )),
    );
  }
}
