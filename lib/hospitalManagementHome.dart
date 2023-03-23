import 'dart:math';

import 'package:factory_management_ctse/docter_home/add_docter_info.dart';
import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:factory_management_ctse/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(88, 44),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  // backgroundColor: Colors.blue,
);

class HospitalManagement extends StatefulWidget {
  const HospitalManagement({Key? key}) : super(key: key);

  @override
  State<HospitalManagement> createState() => _HospitalManagementState();
}

class _HospitalManagementState extends State<HospitalManagement> {
  final AuthService service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 90, 150),
        elevation: 0.0,
        title: Text('Dashboard'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              service.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            icon: Icon(
              // <-- Icon
              Icons.person_remove,
              color: Colors.white,

              size: 24.0,
            ),
            label: Text(
              'Log out Account',
              style: TextStyle(color: Colors.white),
            ), // <-- Text
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 119, 175, 120),
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddDoctor()));
                },
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.health_and_safety,
                        size: 70.0,
                      ),
                      Text("Docter Records Managements",
                          style: new TextStyle(fontSize: 13.0))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        size: 70.0,
                      ),
                      Text("Hospital Branch Management",
                          style: new TextStyle(fontSize: 13.0))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.grass,
                        size: 70.0,
                      ),
                      Text("Drug Management",
                          style: new TextStyle(fontSize: 13.0))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.person_2,
                        size: 70.0,
                      ),
                      Text("Appoinment Management",
                          style: new TextStyle(fontSize: 13.0))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
