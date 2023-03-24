import 'package:factory_management_ctse/appoinment_home/appoinment_list.dart';
import 'package:factory_management_ctse/data/models/apponment_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/appoinment_helper.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

class EditAppoinmentnfo extends StatefulWidget {
  final AppoinmentModel appoinment;
  const EditAppoinmentnfo({Key? key, required this.appoinment})
      : super(key: key);

  @override
  State<EditAppoinmentnfo> createState() => _EditAppoinmentnfoState();
}

class _EditAppoinmentnfoState extends State<EditAppoinmentnfo> {
  TextEditingController? _doctorNamecontroller;
  TextEditingController? _hospitalNamecontroller;
  TextEditingController? _datecontroller;
  TextEditingController? _resoncontroller;
  final _formKey = GlobalKey<FormState>();

  List<String> items = [
    'Select a Hospital',
    'Asiri Hospital',
    'Nawaloka Hospital'
  ];
  String selectedValue = 'Select a Hospital';

  List<String> itemsdoctors = [
    'Select a Doctor',
    'Dr. Narampanawa',
    'Dr. Amarasingha'
  ];
  String selectedValuedoctor = 'Select a Doctor';

  @override
  void initState() {
    _datecontroller = TextEditingController(text: widget.appoinment.date);
    _resoncontroller = TextEditingController(text: widget.appoinment.reson);

    selectedValue = widget.appoinment.hospitalName!;
    selectedValuedoctor = widget.appoinment.doctorName!;

    //init state
    super.initState();
  }

  @override
  void dispose() {
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
                        image: AssetImage("assets/images/onlinedoctorbro.png"),
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
                const Text("Edit Appoinmnet From Hear",
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
                                builder: (context) => const AppoinmentList()));
                      }),
                ),
                // const Schedule(),
                const SizedBox(height: 30.0),
                // TextFormField(
                //   validator: (val) =>
                //       val!.isEmpty ? 'Hospital Name Cant be empty' : null,
                //   controller: _hospitalNamecontroller,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(), hintText: "Hospital"),
                // ),
                DropdownButtonFormField(
                  validator: (value) => value!.toString() == 'Select a Hospital'
                      ? 'Hospital Cannot Be Empty'
                      : null,
                  decoration: textInputDecoration,
                  value: selectedValue,
                  items: items.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // print(value);
                    selectedValue = (value as String?)!;
                    // setState(() => doctorcategory = value as String?);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // TextFormField(
                //   validator: (val) =>
                //       val!.isEmpty ? 'Doctor Name Cant be empty' : null,
                //   controller: _doctorNamecontroller,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(), hintText: "Doctor Name"),
                // ),
                DropdownButtonFormField(
                  validator: (value) => value!.toString() == 'Select a Doctor'
                      ? 'Doctor Name Cannot Be Empty'
                      : null,
                  decoration: textInputDecoration,
                  value: selectedValuedoctor,
                  items: itemsdoctors.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // print(value);
                    selectedValuedoctor = (value as String?)!;
                    // setState(() => doctorcategory = value as String?);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Date Cant be empty' : null,
                  controller: _datecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Date"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Reason Cant be empty' : null,
                  controller: _resoncontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Reson for appoinment"),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    AppoinmentHelper.update(AppoinmentModel(
                      id: widget.appoinment.id,
                      hospitalName: selectedValue,
                      doctorName: selectedValuedoctor,
                      date: _datecontroller!.text,
                      reson: _resoncontroller!.text,
                    )).then((value) {
                      Navigator.pop(context);

                      final snackBar = SnackBar(
                        content: const Text(
                            'Apoinment Record modified Successfully'),
                        backgroundColor: const Color.fromARGB(255, 17, 90, 150),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
