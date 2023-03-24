import 'package:factory_management_ctse/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBAjsk73MKqixM6TE3oYNC0rz6I96_jNKo',
    appId: '1:784861629962:android:e0bd14388a72fa162759f3',
    messagingSenderId: 'rashmikarajapaksha228@gmail.com',
    projectId: 'fir-ctse',
  ));

  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
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
              primaryColor: const Color(0xFFF1E6FF),
              textTheme:
                  Theme.of(context).textTheme.apply(displayColor: const Color(0)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0, backgroundColor: kPrimaryColor,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Color(0xFFF1E6FF),
                iconColor: Color(0xFF6F35A5),
                prefixIconColor: Color(0xFF6F35A5),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              )),
          home: Wrapper(),
        );
      },
    );
  }
}
