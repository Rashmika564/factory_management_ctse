//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/doctor_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/doctor_helper.dart';
import 'package:factory_management_ctse/docter_home/edit_docter_info.dart';
import 'package:factory_management_ctse/hospitalManagementHome.dart';
import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

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
  'Select a Category',
  'Family medicine',
  'Internal Medicine',
  'Pediatrician',
  'gynecologist (OBGYNs)',
  'Cardiologist',
  'Oncologist',
  'Gastroenterologist',
  'Pulmonologist',
  'Infectious disease',
  'Nephrologist',
  'Endocrinologist',
  'Ophthalmologist',
  'Otolaryngologist',
  'Dermatologist',
  'Psychiatrist',
  'Neurologist',
  'Radiologist',
  'Anesthesiologist',
  'Surgeon',
  'Physician executive',
];

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  TextEditingController _fullnamecontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();
  TextEditingController _mobilenumbercontroller = TextEditingController();
  TextEditingController _livingaddresscontroller = TextEditingController();
  TextEditingController _noofnursescontroller = TextEditingController();
  final AuthService service = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? doctorcategory = 'Select a Category';

  @override
  void dispose() {
    _fullnamecontroller.dispose();
    _agecontroller.dispose();
    _mobilenumbercontroller.dispose();
    _livingaddresscontroller.dispose();
    _noofnursescontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add New Doctor"),
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
                      val!.isEmpty ? 'Full Name Cant be empty' : null,
                  controller: _fullnamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "full Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'age cant be empty' : null,
                  controller: _agecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Age"),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  validator: (value) => value!.toString() == 'Select a Category'
                      ? 'category Cant be empty'
                      : null,
                  decoration: textInputDecoration,
                  value: doctorcategory,
                  items: categories.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // print(value);
                    doctorcategory = value as String?;
                    // setState(() => doctorcategory = value as String?);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'mobile number cant be empty' : null,
                  controller: _mobilenumbercontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Mobile Number"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Living Addresss cant be empty' : null,
                  controller: _livingaddresscontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Living Address"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Number Of Nurses cant be empty' : null,
                  controller: _noofnursescontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "No of Assigned Nurses"),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print("Create Data");
                    if (_formKey.currentState!.validate()) {
//_create();
                      DoctorHelper.create(DoctorModel(
                          fullname: _fullnamecontroller.text,
                          age: _agecontroller.text,
                          doctorcategory: doctorcategory,
                          mobilenumber: _mobilenumbercontroller.text,
                          livingaddress: _livingaddresscontroller.text,
                          noofassignednurses: _noofnursescontroller.text));

                      _agecontroller.clear();
                      _fullnamecontroller.clear();
                      _mobilenumbercontroller.clear();
                      _livingaddresscontroller.clear();
                      _noofnursescontroller.clear();

                      // setState(() {
                      doctorcategory = 'Select a Category';

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
                            const Text('Docter Record Created Successfully'),
                        backgroundColor: const Color.fromARGB(255, 17, 90, 150),
                        action: SnackBarAction(
                          label: 'close',
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
                StreamBuilder<List<DoctorModel>>(
                    stream: DoctorHelper.read(),
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
                        final docterdata = snapshot.data;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: docterdata!.length,
                            itemBuilder: (context, Index) {
                              final singledoctor = docterdata[Index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 22.0,
                                      backgroundColor: Colors.green,
                                      backgroundImage: AssetImage('images.png'),
                                    ),
                                    title: Text("${singledoctor.fullname}"),
                                    subtitle: Text("${singledoctor.age}"),
                                    trailing: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditDocterInfo(
                                                            doctor: DoctorModel(
                                                                fullname:
                                                                    singledoctor
                                                                        .fullname,
                                                                age: singledoctor
                                                                    .age,
                                                                id: singledoctor
                                                                    .id,
                                                                doctorcategory:
                                                                    singledoctor
                                                                        .doctorcategory,
                                                                mobilenumber:
                                                                    singledoctor
                                                                        .mobilenumber,
                                                                livingaddress:
                                                                    singledoctor
                                                                        .livingaddress,
                                                                noofassignednurses:
                                                                    singledoctor
                                                                        .noofassignednurses),
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
                                                            DoctorHelper.delete(
                                                                    singledoctor)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                            });

                                                            final snackBar =
                                                                SnackBar(
                                                              content: const Text(
                                                                  'Docter Record Deleted Successfully'),
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
