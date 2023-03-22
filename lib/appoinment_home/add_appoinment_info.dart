//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/doctor_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/doctor_helper.dart';
import 'package:factory_management_ctse/docter_home/edit_docter_info.dart';
import 'package:flutter/material.dart';

import '../data/models/apponment_model.dart';
import '../data/remote_data_source/appoinment_helper.dart';
import '../services/auth.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(88, 44),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
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
  TextEditingController _doctorNamecontroller = TextEditingController(); 
  TextEditingController _hospitalNamecontroller = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _resoncontroller = TextEditingController();
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
          title: Text("Add New Appoinment"),
          backgroundColor: const Color.fromARGB(255, 17, 90, 150),
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Hospital"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _doctorNamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Doctor Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _datecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Date"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _resoncontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Reson for appoinment"),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print("Create Data");
                    //_create();
                    AppoinmentHelper.create(AppoinmentModel(
                        doctorName: _doctorNamecontroller.text,
                        hospitalName: _hospitalNamecontroller.text,
                        date: _datecontroller.text,
                        reson: _resoncontroller.text));
                  },
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                SizedBox(
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
