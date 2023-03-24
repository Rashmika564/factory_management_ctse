import 'dart:ui';

import 'package:factory_management_ctse/data/models/doctor_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/doctor_helper.dart';
import 'package:factory_management_ctse/docter_home/doctor_list.dart';
import 'package:factory_management_ctse/screens/authenticate/sign_in.dart';
import 'package:factory_management_ctse/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

final List<String> categories = [
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

class EditDocterInfo extends StatefulWidget {
  final DoctorModel doctor;
  const EditDocterInfo({Key? key, required this.doctor}) : super(key: key);

  @override
  State<EditDocterInfo> createState() => _EditDocterInfoState();
}

class _EditDocterInfoState extends State<EditDocterInfo> {
  TextEditingController? _fullnamecontroller;
  TextEditingController? _agecontroller;
  TextEditingController? _mobilenumbercontroller;
  TextEditingController? _livingaddresscontroller;
  TextEditingController? _noofnursescontroller;
  final AuthService service = AuthService();

  final _formKey = GlobalKey<FormState>();
  String? doctorcategory;

  @override
  void initState() {
    _fullnamecontroller = TextEditingController(text: widget.doctor.fullname);
    _agecontroller = TextEditingController(text: widget.doctor.age);
    _mobilenumbercontroller =
        TextEditingController(text: widget.doctor.mobilenumber);
    _livingaddresscontroller =
        TextEditingController(text: widget.doctor.livingaddress);
    _noofnursescontroller =
        TextEditingController(text: widget.doctor.noofassignednurses);

    doctorcategory = widget.doctor.doctorcategory;
    //init state
    super.initState();
  }

  @override
  void dispose() {
    _fullnamecontroller!.dispose();
    _agecontroller!.dispose();
    _mobilenumbercontroller!.dispose();
    _livingaddresscontroller!.dispose();
    _noofnursescontroller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Docter Info"),
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
                        height: 300.0,
                        decoration: const BoxDecoration(
                            color: Colors.yellow,
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/onlinedoctorbro.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(150),
                              bottomRight: Radius.circular(150),
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
                      const Text("Edit Doctor From Hear",
                          style: TextStyle(fontSize: 16.0, color: Colors.black)),
                      const SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            child: const Text(
                              "Back",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DoctorList()));
                            }),
                      ),
                      // const Schedule(),
                      const SizedBox(height: 30.0),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Full Name Cant be empty' : null,
                  controller: _fullnamecontroller,
                  decoration: InputDecoration(
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
                    print(value);
                    setState(() => doctorcategory = value as String?);
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(width: 1.5)),
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
                    if (_formKey.currentState!.validate()) {
                      DoctorHelper.update(DoctorModel(
                              id: widget.doctor.id,
                              fullname: _fullnamecontroller!.text,
                              age: _agecontroller!.text,
                              doctorcategory: doctorcategory,
                              mobilenumber: _mobilenumbercontroller!.text,
                              livingaddress: _livingaddresscontroller!.text,
                              noofassignednurses: _noofnursescontroller!.text))
                          .then((value) {
                        Navigator.pop(context);
                        final snackBar = SnackBar(
                          content:
                              const Text('Docter Record Modified Successfully'),
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
                    width: 330,
                    height: 34,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
