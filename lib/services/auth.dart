import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/muser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user obj based on f user
  MUser? _userFromFirebase(User user) {
    return user != null ? MUser(uid: user.uid) : null;
  }

  User? get user {
    User? user = _auth.currentUser;
    if (user == null) {
      return null;
    } else {
      return user;
    }
  }
  //auth changes user stream
  // Stream<User>? get user {
  //   User? user = _auth.currentUser;

  //   return user;
  //   // _auth.authStateChanges().listen((User? user) {
  //   //   if (user == null) {
  //   //     print('User is currently signed out!');
  //   //     return null;
  //   //   } else {
  //   //     print('User is signed in!');
  //   //     return user;
  //   //   }
  //   // });
  // }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password

  //register with email &password
  Future RegisterWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      return null;
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
