import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 11, 58, 96),
      child: Center(
        child: SpinKitChasingDots(
          color: const Color.fromARGB(255, 22, 101, 166),
          size: 50.0,
        ),
      ),
    );
  }
}
