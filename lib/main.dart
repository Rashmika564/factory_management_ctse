import 'package:factory_management_ctse/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBAjsk73MKqixM6TE3oYNC0rz6I96_jNKo',
    appId: '1:784861629962:android:e0bd14388a72fa162759f3',
    messagingSenderId: 'rashmikarajapaksha228@gmail.com',
    projectId: 'fir-ctse',
  ));

  //FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('its ok'),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            ),
          );
        }
        return MaterialApp(
          title: 'Hospital Management',
          home: Wrapper(),
        );
      },
    );
  }
}
