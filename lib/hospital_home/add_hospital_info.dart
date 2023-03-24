//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/hospital_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/hospital_helper.dart';
import 'package:factory_management_ctse/hospital_home/edit_hospital_info.dart';
import 'package:factory_management_ctse/hospitalManagementHome.dart';
import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

import '../data/models/hospital_model.dart';
import '../data/remote_data_source/hospital_helper.dart';
import '../services/auth.dart';
import '../shared/constants.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(88, 44),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  //backgroundColor: Color.fromARGB(255, 3, 33, 57),
);

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

class AddHospital extends StatefulWidget {
  const AddHospital({Key? key}) : super(key: key);

  @override
  State<AddHospital> createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  TextEditingController _hospitalnamecontroller = TextEditingController();
  TextEditingController _branchcontroller = TextEditingController();
  TextEditingController _hospitaladdresscontroller = TextEditingController();
  TextEditingController _telephonecontroller = TextEditingController();
  final AuthService service = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? hospitalbranch = 'Select a Location';

  @override
  void dispose() {
    _hospitalnamecontroller.dispose();
    _branchcontroller.dispose();
    _hospitaladdresscontroller.dispose();
    _telephonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add A New Hospital Location"),
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
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Hospital Name cannot be empty' : null,
                  controller: _hospitalnamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Hospital Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Branch cannot be empty' : null,
                  controller: _branchcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Select a branch"),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  validator: (value) => value!.toString() == 'Select a branch'
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
                    // print(value);
                    hospitalbranch = value as String?;
                    // setState(() => doctorcategory = value as String?);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Hospital Address cannot be empty' : null,
                  controller: _hospitaladdresscontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Hospital Address"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Telephone Number cannot be empty' : null,
                  controller: _telephonecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Telephone Number cannot be empty"),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print("Create Hospital");
                    if (_formKey.currentState!.validate()) {
//_create();
                      HospitalHelper.create(HospitalModel(
                          hospitalname: _hospitalnamecontroller.text,
                          branch: hospitalbranch,
                          hospitaladdress: _hospitaladdresscontroller.text,
                          telephone: _telephonecontroller.text));

                      _hospitalnamecontroller.clear();
                      _branchcontroller.clear();
                      _hospitaladdresscontroller.clear();
                      _telephonecontroller.clear();

                      // setState(() {
                      hospitalbranch = 'Select a branch location';

                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: Text("Delete Confirm"),
                      //         content: Text("Are You sure You want to delete"),
                      //         actions: [
                      //           ElevatedButton(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text("Delete"))
                      //         ],
                      //       );
                      //     });

                      final snackBar = SnackBar(
                        content:
                            const Text('Hospital Branch Created Successfully'),
                        backgroundColor: const Color.fromARGB(255, 17, 90, 150),
                        action: SnackBarAction(
                          label: 'Close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Create",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<List<HospitalModel>>(
                    stream: HospitalHelper.read(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Some error occured"),
                        );
                      }
                      if (snapshot.hasData) {
                        final hospitaldata = snapshot.data;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: hospitaldata!.length,
                            itemBuilder: (context, Index) {
                              final singlehospital = hospitaldata[Index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 22.0,
                                      backgroundColor: Colors.green,
                                      backgroundImage: AssetImage('images.png'),
                                    ),
                                    title:
                                        Text("${singlehospital.hospitalname}"),
                                    subtitle:
                                        Text("${singlehospital.telephone}"),
                                    trailing: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditHospitalInfo(
                                                            hospital: HospitalModel(
                                                                hospitalname:
                                                                    singlehospital
                                                                        .hospitalname,
                                                                branch:
                                                                    singlehospital
                                                                        .branch,
                                                                id: singlehospital
                                                                    .id,
                                                                hospitaladdress:
                                                                    singlehospital
                                                                        .hospitaladdress,
                                                                telephone:
                                                                    singlehospital
                                                                        .telephone),
                                                          )));
                                            },
                                            child: Icon(Icons.edit)),
                                        // SizedBox(
                                        //   height: 0.5,
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            //call your onpressed function here
                                            print('Button Pressed');
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text("Delete Confirm"),
                                                    content: Text(
                                                        "Are You sure You want to delete"),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            HospitalHelper.delete(
                                                                    singlehospital)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                            });

                                                            final snackBar =
                                                                SnackBar(
                                                              content: const Text(
                                                                  'Hospital Record Deleted Successfully'),
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      17,
                                                                      90,
                                                                      150),
                                                              action:
                                                                  SnackBarAction(
                                                                label: 'close',
                                                                onPressed: () {
                                                                  // Some code to undo the change.
                                                                },
                                                              ),
                                                            );

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          },
                                                          child: Text("Delete"))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future _create() async {
  //   final doctorCollection = FirebaseFirestore.instance.collection("doctors");
  //   final docRef = doctorCollection.doc();
  //   await docRef.set({
  //     "fullname": _fullnamecontroller.text,
  //     "age": _agecontroller.text,
  //   });
  // }
}
