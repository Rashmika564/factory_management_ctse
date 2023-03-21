//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/doctor_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/doctor_helper.dart';
import 'package:factory_management_ctse/docter_home/edit_docter_info.dart';
import 'package:flutter/material.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  TextEditingController _fullnamecontroller = TextEditingController();
  TextEditingController _agecontroller = TextEditingController();

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
          title: Text("Add New Doctor"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _fullnamecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "full Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _agecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Age"),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  print("Create Data");
                  //_create();
                  DoctorHelper.create(DoctorModel(
                      fullname: _fullnamecontroller.text,
                      age: _agecontroller.text));
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
                        color: Colors.green,
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
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      shape: BoxShape.circle),
                                ),
                                title: Text("${singledoctor.fullname}"),
                                subtitle: Text("${singledoctor.age}"),
                                trailing: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditDocterInfo(
                                                    doctor: DoctorModel(
                                                        fullname: singledoctor
                                                            .fullname,
                                                        age: singledoctor.age,
                                                        id: singledoctor.id),
                                                  )));
                                    },
                                    child: Icon(Icons.edit)),
                              ),
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
