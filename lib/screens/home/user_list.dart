import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/fuser.dart';
import 'user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<FUser>>(context);
    print(users);
    print("adoo");

    // users.forEach((u) {
    //   print(u.fullName);
    // print(u.fullName)
    //   print(u.mobile);
    //   print(u.age);
    // });
    // for (var doc in users.docs) {
    //   print(doc.data());
    //   print("of");
    // }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(fuser: users[index]);
      },
    );
  }
}
