//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/doctor_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/doctor_helper.dart';
import 'package:factory_management_ctse/docter_home/doctor_list.dart';
import 'package:factory_management_ctse/docter_home/edit_docter_info.dart';
import 'package:factory_management_ctse/hospitalManagementHome.dart';
import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../drug_home/drugs_list.dart';
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
        body: SingleChildScrollView(
          
          child: Form(
            key: _formKey,
            child: Column(
              
              children: [
                Container(
                    height: 200.0,
                    decoration: const BoxDecoration(
                        color: Colors.yellow,
                        image: DecorationImage(
                          image: AssetImage("assets/images/onlinedoctorbro.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(250),
                          bottomRight: Radius.circular(0),
                        )),
                  ),
                  const SizedBox(height: 10.0),
                const Text("Welcome",
                    style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 10.0),
                const Text("Add Doctor",
                    style: TextStyle(fontSize: 16.0, color: Colors.black)),
                const SizedBox(height: 10.0),
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
                                builder: (context) => const DoctorList()));
                      }),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Full Name Cant be empty' : null,
                  controller: _fullnamecontroller,
                  keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.person),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(width: 1.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 17, 90, 150),
                              width: 1.5)),
                      hintText: "full Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'age cant be empty' : null,
                  controller: _agecontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.person),
                      ),
                      border: OutlineInputBorder(
                        
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(width: 1.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 17, 90, 150),
                              width: 1.5)),
                      hintText: "Age"),
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
                    prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.person),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(width: 1.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 17, 90, 150),
                              width: 1.5)),
                      hintText: "Mobile Number"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Living Addresss cant be empty' : null,
                  controller: _livingaddresscontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.person),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(width: 1.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 17, 90, 150),
                              width: 1.5)),
                      hintText: "Living Address"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Number Of Nurses cant be empty' : null,
                  controller: _noofnursescontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.person),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 17, 90, 150),
                              width: 1.5)),
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
                    width: 330,
                    height: 34,
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
