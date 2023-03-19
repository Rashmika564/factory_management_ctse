import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

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
    backgroundColor: Colors.blue,
  );
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text feild
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register Factory Management'),
        actions: <Widget>[
          TextButton(
            style: flatButtonStyle,
            onPressed: () {
              print('login in');
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
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print(email);
                      print(password);
                      dynamic result =
                          await _authService.RegisterWithEmailPassword(
                              email, password);
                      print(result);
                      if (result == null) {
                        print("fgj");
                        setState(() => error = 'Please enter valid email');
                      } else {}
                    }
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
    ;
  }
}
