import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/screens/home/update_form.dart';
import 'package:factory_management_ctse/screens/home/user_list.dart';
import 'package:factory_management_ctse/services/auth.dart';
import 'package:factory_management_ctse/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/fuser.dart';

class Home extends StatelessWidget {
  final AuthService service = AuthService();

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    backgroundColor: Color.fromARGB(255, 3, 33, 57),
  );

  get initialData => null;

  @override
  Widget build(BuildContext context) {
    void _showUpdatesPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: UpdateForm(),
            );
          });
    }

    return StreamProvider<List<FUser>?>.value(
      value: DatabaseService(uid: "").users,
      initialData: null,
      catchError: (_, err) {
        print("errr");
        return null;
      },
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
            ),
            TextButton(
              style: flatButtonStyle,
              onPressed: () => _showUpdatesPanel(),
              child: Icon(Icons.update),
            ),
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
