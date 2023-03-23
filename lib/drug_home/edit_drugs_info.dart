import 'package:factory_management_ctse/data/models/apponment_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/appoinment_helper.dart';
import 'package:flutter/material.dart';

class EditAppoinmentnfo extends StatefulWidget {
  final AppoinmentModel appoinment;
  const EditAppoinmentnfo({Key? key, required this.appoinment}) : super(key: key);

  @override
  State<EditAppoinmentnfo> createState() => _EditAppoinmentnfoState();
}

class _EditAppoinmentnfoState extends State<EditAppoinmentnfo> {
  TextEditingController? _doctorNamecontroller;
  TextEditingController? _hospitalNamecontroller;
  TextEditingController? _datecontroller;
  TextEditingController? _resoncontroller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _doctorNamecontroller = TextEditingController(text: widget.appoinment.doctorName);
    _hospitalNamecontroller = TextEditingController(text: widget.appoinment.hospitalName);
    _datecontroller = TextEditingController(text: widget.appoinment.date);
    _resoncontroller = TextEditingController(text: widget.appoinment.reson);
    //init state
    super.initState();
  }

  @override
  void dispose() {
    _doctorNamecontroller!.dispose();
    _hospitalNamecontroller!.dispose();
    _datecontroller!.dispose();
    _resoncontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Appoinment Info"),
          backgroundColor: const Color.fromARGB(255, 17, 90, 150),
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _hospitalNamecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Hospital"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _doctorNamecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Doctor Name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _datecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Date"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _resoncontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Reson for appoinment"),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    AppoinmentHelper.update(AppoinmentModel(
                            id: widget.appoinment.id,
                            hospitalName: _hospitalNamecontroller!.text,
                            doctorName: _doctorNamecontroller!.text, 
                            date: _datecontroller!.text, 
                            reson: _resoncontroller!.text, 
                            ))
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
                      children: const [
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
