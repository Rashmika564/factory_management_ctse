import 'dart:ui';

import 'package:factory_management_ctse/data/models/hospital_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/hospital_helper.dart';
import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:factory_management_ctse/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

final List<String> categories = [
  'Select the Hospital Location',
  'Colombo',
  'Jaffna',
  'Galle',
  'Kandy',
  'Sri Jayawardenapura Kotte',
  'Trincomalee',
  'Anuradhapura',
  'Nugegoda',
  'Gampola',
];

class EditHospitalInfo extends StatefulWidget {
  final HospitalModel hospital;
  const EditHospitalInfo({Key? key, required this.hospital}) : super(key: key);

  @override
  State<EditHospitalInfo> createState() => _EditHospitalInfoState();
}

class _EditHospitalInfoState extends State<EditHospitalInfo> {
  TextEditingController? _hospitalnamecontroller;
  TextEditingController? _hospitaladdresscontroller;
  TextEditingController? _telephonecontroller;
  final AuthService service = AuthService();

  final _formKey = GlobalKey<FormState>();
  String? branch;
  String? hospitalbranch = 'Select the Hospital Location';

  @override
  void initState() {
    _hospitalnamecontroller =
        TextEditingController(text: widget.hospital.hospitalname);
    _hospitaladdresscontroller =
        TextEditingController(text: widget.hospital.hospitaladdress);
    _telephonecontroller =
        TextEditingController(text: widget.hospital.telephone);

    branch = widget.hospital.hospitalbranch;
    //init state
    super.initState();
  }

  @override
  void dispose() {
    _hospitalnamecontroller!.dispose();
    _hospitaladdresscontroller!.dispose();
    _telephonecontroller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Hospital Information"),
          backgroundColor: const Color.fromARGB(255, 17, 90, 150),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                service.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              icon: Icon(
                // <-- Icon
                Icons.person_remove,
                color: Colors.white,

                size: 24.0,
              ),
              label: Text(
                'Log out Account',
                style: TextStyle(color: Colors.white),
              ), // <-- Text
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Hospital Name Cannot  be empty' : null,
                  controller: _hospitalnamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Hospital Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  validator: (value) =>
                      value!.toString() == 'Select the Hospital Location'
                          ? 'Branch Cant be empty'
                          : null,
                  decoration: textInputDecoration,
                  value: hospitalbranch,
                  items: categories.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                    setState(() => branch = value as String?);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Address cant be empty' : null,
                  controller: _hospitaladdresscontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Address"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Phone cant be empty' : null,
                  controller: _telephonecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Teelephone"),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      HospitalHelper.update(HospitalModel(
                              id: widget.hospital.id,
                              hospitalname: _hospitalnamecontroller!.text,
                              hospitaladdress: _hospitaladdresscontroller!.text,
                              telephone: _telephonecontroller!.text))
                          .then((value) {
                        Navigator.pop(context);
                        final snackBar = SnackBar(
                          content:
                              const Text('Branch Record Modified Successfully'),
                          backgroundColor:
                              const Color.fromARGB(255, 17, 90, 150),
                          action: SnackBarAction(
                            label: 'close',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
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
                          Icons.update,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Modify",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: window.physicalSize.width / 2,
                  height: window.physicalSize.height / 4.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Doctors-bro.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
