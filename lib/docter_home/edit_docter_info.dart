import 'package:factory_management_ctse/data/models/doctor_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditDocterInfo extends StatefulWidget {
  final DoctorModel doctor;
  const EditDocterInfo({Key? key, required this.doctor}) : super(key: key);

  @override
  State<EditDocterInfo> createState() => _EditDocterInfoState();
}

class _EditDocterInfoState extends State<EditDocterInfo> {
  TextEditingController? _fullnamecontroller;
  TextEditingController? _agecontroller;

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
          title: Text("Edit Docter Info"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
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
                  // DoctorHelper.create(DoctorModel(
                  //     fullname: _fullnamecontroller.text,
                  //     age: _agecontroller.text));
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
    );
  }
}
