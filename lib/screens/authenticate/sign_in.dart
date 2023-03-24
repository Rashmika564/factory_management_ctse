import 'dart:convert';
import 'dart:ui';

import 'package:factory_management_ctse/hospitalManagementHome.dart';
import 'package:factory_management_ctse/screens/authenticate/register.dart';
import 'package:factory_management_ctse/services/auth.dart';
import 'package:factory_management_ctse/services/database.dart';
import 'package:factory_management_ctse/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../docter_home/add_docter_info.dart';
import '../../shared/constants.dart';

class SignIn extends StatefulWidget {
  //final Function toggleView;
  //SignIn();
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              title: const Text('Sign in'),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  icon: const Icon(
                    // <-- Icon
                    Icons.person_add,
                    color: Colors.white,

                    size: 24.0,
                  ),
                  label: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ), // <-- Text
                ),
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(vertical: 29.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 400,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('green.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
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
                      const SizedBox(
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
                      const SizedBox(height: 20.0),
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
                        child: ElevatedButton (
                          
                          onPressed: () async { 
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.update,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(error,
                          style: const TextStyle(color: Colors.red, fontSize: 14.0)),
                    ],
                  ),
                )),
          );
  }
}
