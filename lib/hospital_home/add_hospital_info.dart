//import 'dart:ffi';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/hospital_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/hospital_helper.dart';
import 'package:factory_management_ctse/hospital_home/edit_hospital_info.dart';
import 'package:factory_management_ctse/hospitalManagementHome.dart';
import 'package:factory_management_ctse/hospital_home/list_hospital.dart';
import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

//import '../data/models/hospital_model.dart';
//import '../data/remote_data_source/hospital_helper.dart';
import '../constants.dart';
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
  TextEditingController _hospitaladdresscontroller = TextEditingController();
  TextEditingController _telephonecontroller = TextEditingController();
  final AuthService service = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? hospitalbranch = 'Select the Hospital Location';

  @override
  void dispose() {
    _hospitalnamecontroller.dispose();
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
        body: SingleChildScrollView(
          child: Form(
          key: _formKey,
          child: Column(
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
              const Text("Welcome",
                  style: TextStyle(
                      fontSize: 24.0,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 10.0),
              const Text("Add Hospital From Hear",
                  style: TextStyle(fontSize: 16.0, color: Colors.black)),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    child: const Text(
                      "View all",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HospitalList()));
                    }),
              ),
              // const Schedule(),
              const SizedBox(height: 30.0),
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? 'Hospital Name cannot be empty' : null,
                controller: _hospitalnamecontroller,
                keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Hospital Name",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
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
                keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Hospital Address",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? 'Telephone Number cannot be empty' : null,
                controller: _telephonecontroller,
                decoration: const InputDecoration(
                    hintText: "Telephone Number",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  print("Create Hospital");
                  if (_formKey.currentState!.validate()) {

                    HospitalHelper.create(HospitalModel(
                        hospitalname: _hospitalnamecontroller.text,
                        hospitalbranch: hospitalbranch,
                        hospitaladdress: _hospitaladdresscontroller.text,
                        telephone: _telephonecontroller.text));

                    _hospitalnamecontroller.clear();
                    _hospitaladdresscontroller.clear();
                    _telephonecontroller.clear();

                 
                    hospitalbranch = 'Select the Hospital Location';

                  

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
                    children: const [
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

  // Future _create() async {
  //   final doctorCollection = FirebaseFirestore.instance.collection("doctors");
  //   final docRef = doctorCollection.doc();
  //   await docRef.set({
  //     "fullname": _fullnamecontroller.text,
  //     "age": _agecontroller.text,
  //   });
  // }
}
