import 'package:factory_management_ctse/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);

const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

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
                child: CircularProgressIndicator(),
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
          debugShowCheckedModeBanner: false,
          title: 'Hospital Management',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: primaryColor,
            textTheme:
                Theme.of(context).textTheme.apply(displayColor: textColor),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.all(defaultPadding),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: textFieldBorder,
              enabledBorder: textFieldBorder,
              focusedBorder: textFieldBorder,
            ),
          ),
          home: Wrapper(),
        );
      },
    );
  }
}
