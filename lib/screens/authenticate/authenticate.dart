import 'package:factory_management_ctse/screens/authenticate/register.dart';
import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:factory_management_ctse/screens/home/home.dart';
import 'package:factory_management_ctse/services/auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn();
    } else {
      return Register();
    }
  }
}
