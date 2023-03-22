//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/doctor_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/doctor_helper.dart';
import 'package:factory_management_ctse/docter_home/edit_docter_info.dart';
import 'package:flutter/material.dart';

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

class AppoinmentList extends StatefulWidget {
  const AppoinmentList({Key? key}) : super(key: key);

  @override
  State<AppoinmentList> createState() => _AppoinmentListState();
}

class _AppoinmentListState extends State<AppoinmentList> {
  TextEditingController _fullnamecontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();
  final AuthService service = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullnamecontroller.dispose();
    _agecontroller.dispose();
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
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle),
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
                                                                age:
                                                                    singledoctor
                                                                        .age,
                                                                id: singledoctor
                                                                    .id),
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
