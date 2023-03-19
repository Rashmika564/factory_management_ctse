import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/screens/home/user_list.dart';
import 'package:factory_management_ctse/services/auth.dart';
import 'package:factory_management_ctse/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService service = AuthService();

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Colors.blue,
  );

  get initialData => null;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>(
      create: (_) => DatabaseService(uid: "").users,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Fac Management"),
          backgroundColor: Color.fromARGB(255, 1, 40, 72),
          elevation: 0.0,
          actions: <Widget>[
            TextButton(
              style: flatButtonStyle,
              onPressed: () async {
                print('sign out');
                service.signOut();
              },
              child: Icon(Icons.person),
            )
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
