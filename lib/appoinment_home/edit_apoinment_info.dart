import 'package:factory_management_ctse/data/models/doctor_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/doctor_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditAppoinmentnfo extends StatefulWidget {
  final DoctorModel doctor;
  const EditAppoinmentnfo({Key? key, required this.doctor}) : super(key: key);

  @override
  State<EditAppoinmentnfo> createState() => _EditAppoinmentnfoState();
}

class _EditAppoinmentnfoState extends State<EditAppoinmentnfo> {
  TextEditingController? _fullnamecontroller;
  TextEditingController? _agecontroller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fullnamecontroller = TextEditingController(text: widget.doctor.fullname);
    _agecontroller = TextEditingController(text: widget.doctor.age);
    //init state
    super.initState();
  }

  @override
  void dispose() {
    _fullnamecontroller!.dispose();
    _agecontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Appoinment Info"),
          backgroundColor: const Color.fromARGB(255, 17, 90, 150),
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _fullnamecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Hospital"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _agecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Doctor Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _agecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Date"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _agecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Reson for appoinment"),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    DoctorHelper.update(DoctorModel(
                            id: widget.doctor.id,
                            fullname: _fullnamecontroller!.text,
                            age: _agecontroller!.text))
                        .then((value) {
                      Navigator.pop(context);
                    });
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
