//import 'dart:ffi';

import 'package:factory_management_ctse/appoinment_home/edit_apoinment_info.dart';
import 'package:factory_management_ctse/docter_home/add_docter_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/models/apponment_model.dart';
import '../data/models/doctor_model.dart';
import '../data/remote_data_source/appoinment_helper.dart';
import '../data/remote_data_source/doctor_helper.dart';
import '../services/auth.dart';
import 'edit_docter_info.dart';

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

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final TextEditingController _fullnamecontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
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
          title: const Text("Appoinment List"),
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
        body: Stack(
          children: 
            [

              Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      height: 300.0,
                      decoration: const BoxDecoration(
                          color: Colors.yellow,
                          image: DecorationImage(
                            image: AssetImage("assets/images/onlinedoctorbro.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(250),
                          )),
                    ),
                    const SizedBox(height: 20.0),
                    const Text("Welcome",
                        style: TextStyle(
                            fontSize: 24.0,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(height: 10.0),
                    const Text("See Doctor List",
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          child: const Text(
                            "Add New Doctor",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddDoctor()));
                          }),
                    ),
                    // const Schedule(),
                    const SizedBox(height: 30.0),
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
                                        // backgroundImage: AssetImage('images.png'),
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
          ],
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
