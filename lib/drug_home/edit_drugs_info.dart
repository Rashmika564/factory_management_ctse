import 'package:factory_management_ctse/data/models/drugs_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/drug_helper.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

class EditDruginfo extends StatefulWidget {
  final DrugsModel drug;
  const EditDruginfo({Key? key, required this.drug}) : super(key: key);

  @override
  State<EditDruginfo> createState() => _EditDruginfoState();
}


final List<String> drugcategories = [
    'Select a Category',
    'Blood Pressure',
    'Blood Cholesterol',
    'Blood Glucose',
    'Antibiotics',
    'Painkillers',
    'Other Drugs',
  ];
   String? selectedValue = 'Select a Category';

  final List<String> drugStatus = [
    'Select a Status',
    'Available',
    'Unavailable'
  ];
   String? selectedValueStatus = 'Select a Status';

class _EditDruginfoState extends State<EditDruginfo> {
  TextEditingController? _drCodecontroller;
  TextEditingController? _drNamecontroller;
  TextEditingController? _unitPriceontroller;
  TextEditingController? _drCategorycontroller;
  TextEditingController? _drStatuscontroller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _drCodecontroller = TextEditingController(text: widget.drug.drCode);
    _drNamecontroller = TextEditingController(text: widget.drug.drName);
    _unitPriceontroller = TextEditingController(text: widget.drug.unitPrice);
  

    selectedValue = widget.drug.drCategory;
    selectedValueStatus = widget.drug.drStatus;
    //init state
    super.initState();
  }

  @override
  void dispose() {
    _drCodecontroller!.dispose();
    _drNamecontroller!.dispose();
    _unitPriceontroller!.dispose();
    _drCategorycontroller!.dispose();
    _drStatuscontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Drug Info"),
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
                  validator: (val) =>
                      val!.isEmpty ? 'Drug Name Cant be empty' : null,
                  controller: _drNamecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Drug Name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Drug Code Cant be empty' : null,
                  controller: _drCodecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Drug Code"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Unit price Cant be empty' : null,
                  controller: _unitPriceontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Unit Price"),
                ),
                const SizedBox(
                  height: 10,
                ),
                // TextFormField(
                //   validator: (value) =>
                //       value!.isEmpty ? 'Drug Category Cant be empty' : null,
                //   controller: _drCategorycontroller,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(), hintText: "Drug Category"),
                // ),
                DropdownButtonFormField(
                    validator: (value) => value!.toString() == 'Select a Category'
                        ? 'category Cant be empty'
                        : null,
                    decoration: textInputDecoration,
                    value: selectedValue,
                    items: drugcategories.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // print(value);
                      selectedValue = value as String?;
                      // setState(() => doctorcategory = value as String?);
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                // TextFormField(
                //   validator: (val) =>
                //       val!.isEmpty ? 'Drug Status Cant be empty' : null,
                //   controller: _drStatuscontroller,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(), hintText: "Drug Status"),
                // ),
                DropdownButtonFormField(
                    validator: (value) => value!.toString() == 'Select a Category'
                        ? 'category Cant be empty'
                        : null,
                    decoration: textInputDecoration,
                    value: selectedValueStatus,
                    items: drugStatus.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // print(value);
                      selectedValueStatus = value as String?;
                      // setState(() => doctorcategory = value as String?);
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    DrugHelper.update(DrugsModel(
                            id: widget.drug.id,
                            drCode: _drCodecontroller!.text,
                            drName: _drNamecontroller!.text,
                            unitPrice: _unitPriceontroller!.text,
                            drCategory: selectedValue,
                            drStatus: selectedValueStatus))
                        .then((value) {
                      final snackBar = SnackBar(
                        content: const Text(
                            'Drug Record Record Updated Successfully'),
                        backgroundColor: const Color.fromARGB(255, 17, 90, 150),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
