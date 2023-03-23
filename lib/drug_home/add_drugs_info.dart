import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:factory_management_ctse/appoinment_home/appoinment_list.dart';
import 'package:factory_management_ctse/data/models/drugs_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/drug_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/models/drugs_model.dart';
import '../data/remote_data_source/drug_helper.dart';
import '../services/auth.dart';
import 'package:intl/intl.dart';

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

class AddDrugs extends StatefulWidget {
  const AddDrugs({Key? key}) : super(key: key);

  @override
  State<AddDrugs> createState() => _AddDrugsState();
}

class _AddDrugsState extends State<AddDrugs> {
  TextEditingController _drCodecontroller = TextEditingController();
  final TextEditingController _drNamecontroller = TextEditingController();
  final TextEditingController _unitPriceontroller = TextEditingController();
  final TextEditingController _drCategorycontroller = TextEditingController();
  final TextEditingController _drStatuscontroller = TextEditingController();

  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  final AuthService service = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _drCodecontroller.dispose();
    _drNamecontroller.dispose();
    _unitPriceontroller.dispose();
    _drCategorycontroller.dispose();
    _drStatuscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Drug Details"),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 300.0,
                  decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(250),
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
                const Text("Book Your Doctor Appoinment Hear",
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
                                builder: (context) => const AppoinmentList()));
                      }),
                ),
                // const Schedule(),
                const SizedBox(height: 30.0),
                // const Image(image: AssetImage('graphics/background.png')),
                TextFormField(
                  controller: _drNamecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Hospital"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _drCodecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Doctor Name"),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      // setState(() {
                      selectedValue = value as String?;
                      // });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller:
                      _unitPriceontroller, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      if (kDebugMode) {
                        print(pickedDate);
                      } //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      if (kDebugMode) {
                        print(formattedDate);
                      } //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        _unitPriceontroller.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      if (kDebugMode) {
                        print("Date is not selected");
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _drCategorycontroller,
                  minLines:
                      6, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Reson for appoinment"),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print("Create Data");
                    }
                    //_create();
                    DrugHelper.create(DrugsModel(
                        drCode: _drCodecontroller.text,
                        drName: _drNamecontroller.text,
                        unitPrice: _unitPriceontroller.text,
                        drCategory: _drCategorycontroller.text,
                        drStatus: _drStatuscontroller.text));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppoinmentList()));
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Book",
                          style: TextStyle(color: Colors.black),
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
}
