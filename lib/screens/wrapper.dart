import 'package:factory_management_ctse/docter_home/add_docter_info.dart';
import 'package:factory_management_ctse/hospitalManagementHome.dart';
import 'package:factory_management_ctse/screens/Login/login_screen.dart';
import 'package:factory_management_ctse/screens/Welcome/welcome_screen.dart';
import 'package:factory_management_ctse/screens/authenticate/authenticate.dart';
import 'package:factory_management_ctse/screens/home/home.dart';
import 'package:flutter/material.dart';

import '../appoinment_home/add_appoinment_info.dart';
import '../appoinment_home/appoinment_list.dart';
import '../services/auth.dart';
import 'about.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return home or authenticate widgets

    final user = AuthService().user;

    if (user == null) {
      //return Authenticate();
      return About();
    } else {
      return About();
    }

    // return Container(
    //   child: Text('home'),
    // );
  }
}
