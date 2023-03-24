import 'dart:ui';

import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:factory_management_ctse/services/database.dart';
import 'package:flutter/material.dart';

import '../../docter_home/add_docter_info.dart';
import '../../hospitalManagementHome.dart';
import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';

class Register extends StatefulWidget {
  // final Function toggleView;
  // Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    // backgroundColor: Colors.blue,
  );
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text feild
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 17, 90, 150),
              elevation: 0.0,
              title: Text('Sign Up'),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  icon: Icon(
                    // <-- Icon
                    Icons.person,
                    color: Colors.white,

                    size: 24.0,
                  ),
                  label: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ), // <-- Text
                ),
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 29.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('Hospital-building-bro-green.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      SizedBox(
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
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            print(email);
                            print(password);
                            print("register");
                            dynamic result =
                                await _authService.RegisterWithEmailPassword(
                                    email, password);
                            print("after egtting result");
                            print(result);
                            if (result == null) {
                              print("fgj");
                              setState(() {
                                error = 'Please enter valid email';
                                loading = false;
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HospitalManagement()));
                            }
                          }
                        },
                        child: ElevatedButton(
                          
                          onPressed: () {  },
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
                                "Sign Up",
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
    ;
  }
}
