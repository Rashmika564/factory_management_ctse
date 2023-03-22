
import 'package:factory_management_ctse/appoinment_home/appoinment_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/models/apponment_model.dart';
import '../data/remote_data_source/appoinment_helper.dart';
import '../services/auth.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // ignore: deprecated_member_use
  primary: Colors.white,
  minimumSize: const Size(88, 44),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  //backgroundColor: Color.fromARGB(255, 3, 33, 57),
);

class AddAppoinment extends StatefulWidget {
  const AddAppoinment({Key? key}) : super(key: key);

  @override
  State<AddAppoinment> createState() => _AddAppoinmentState();
}

class _AddAppoinmentState extends State<AddAppoinment> {
  final TextEditingController _doctorNamecontroller = TextEditingController(); 
  final TextEditingController _hospitalNamecontroller = TextEditingController();
  final TextEditingController _datecontroller = TextEditingController();
  final TextEditingController _resoncontroller = TextEditingController();
  final AuthService service = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _doctorNamecontroller.dispose();
    _hospitalNamecontroller.dispose();
    _datecontroller.dispose();
    _resoncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Appoinment"),
          backgroundColor: const Color.fromARGB(255, 17, 90, 150),
          elevation: 0.0,
          actions: <Widget>[
            TextButton(
              style: flatButtonStyle,
              onPressed: () async {
                if (kDebugMode) {
                  print('sign out');
                }
                service.signOut();
              },
              child: const Icon(Icons.person),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _hospitalNamecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Hospital"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _doctorNamecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Doctor Name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _datecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Date"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _resoncontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Reson for appoinment"),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print("Create Data");
                    }
                    //_create();
                    AppoinmentHelper.create(AppoinmentModel(
                        doctorName: _doctorNamecontroller.text,
                        hospitalName: _hospitalNamecontroller.text,
                        date: _datecontroller.text,
                        reson: _resoncontroller.text));

                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                  const AppoinmentList()));
                  },
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "create",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
