import 'dart:convert';

import 'package:factory_management_ctse/hospitalManagementHome.dart';
import 'package:factory_management_ctse/services/auth.dart';
import 'package:factory_management_ctse/services/database.dart';
import 'package:factory_management_ctse/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../docter_home/add_docter_info.dart';
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
    // backgroundColor: Colors.blue,
  );

  bool loading = false;
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text feild
  String email = '';
  String password = '';
  String error = '';
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 17, 90, 150),
              elevation: 0.0,
              title: Text('Sign in'),
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
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
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
                        validator: (val) => val!.length < 6
                            ? 'Enter an password  g than 6 '
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () async {
                          DatabaseService(uid: "").users;
                          if (_formKey.currentState!.validate()) {
                            //setState(() => loading = true);
                            print(email);
                            print(password);
                            dynamic result =
                                await _authService.SignInWithEmailPassword(
                                    email, password);

                            print(result);
                            if (result == null) {
                              print("fgj");
                              setState(() {
                                error =
                                    'Could Not sign in with these credintials';
                                loading = false;
                              });
                            } else {
                              // setState(() {
                              //   loading = false;
                              // });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HospitalManagement()));
                            }
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.green),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.update,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
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
