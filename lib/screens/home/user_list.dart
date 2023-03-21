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
  static List<FUser>? of(context, {bool allowNull = false}) {
    try {
      return Provider.of<List<FUser>>(context, listen: false);
    } catch (error) {
      if (!allowNull) throw error;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var users = [];
    try {
      users = Provider.of<List<FUser>?>(context, listen: true)!;
    } catch (e) {}
    //final users = Provider.of<List<FUser>?>(context, listen: true);
    // print(users);
    print("adoo");
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(fuser: users[index]);
      },
    );

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
  }
}
