import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'Welcome/components/login_signup_btn.dart';
import 'Welcome/components/welcome_image.dart';


class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("About Us"),
            backgroundColor: const Color.fromARGB(255, 17, 90, 150),
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  // service.signOut();
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => SignIn()));
                },
                icon: const Icon(
                  // <-- Icon
                  Icons.person_remove,
                  color: Colors.white,

                  size: 24.0,
                ),
                label: const Text(
                  'Log out Account',
                  style: TextStyle(color: Colors.white),
                ), // <-- Text
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                  height: 300.0,
                  decoration: const BoxDecoration(
                      color: Colors.yellow,
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/onlinedoctorbro.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(250),
                        bottomRight: Radius.circular(0),
                      )),
                ),
                const SizedBox(height: 20.0),
                
                const SizedBox(height: 10.0),
                const Text("About US",
                    style: TextStyle(fontSize: 16.0, color: Colors.black)),
                const SizedBox(height: 20.0),
                
                // const Schedule(),
                const SizedBox(height: 30.0),
               const Center(
                 child: Text(
                   "A hospital management system enables hospitals to manage information and data relevant to all aspects of healthcare, including procedures, providers, patients, and more, enabling the efficient and successful completion of processes.",
                   style: TextStyle(
                     fontSize: 24.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                   ),
                 ),
               )
            ],
          )),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const WelcomeImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}