// import 'package:factory_management_ctse/data/models/drugs_model.dart';
// import 'package:factory_management_ctse/data/remote_data_source/drug_helper.dart';
// import 'package:flutter/material.dart';

// class EditDruginfo extends StatefulWidget {
//   final DrugsModel drug;
//   const EditDruginfo({Key? key, required this.drug}) : super(key: key);

//   @override
//   State<EditDruginfo> createState() => _EditDruginfoState();
// }

// class _EditDruginfoState extends State<EditDruginfo> {
//   TextEditingController? _drCodecontroller;
//   TextEditingController? _drNamecontroller;
//   TextEditingController? _unitPriceontroller;
//   TextEditingController? _drCategorycontroller;
//   TextEditingController? _drStatuscontroller;
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     _drCodecontroller = TextEditingController(text: widget.drug.drCode);
//     _drNamecontroller = TextEditingController(text: widget.drug.drName);
//     _unitPriceontroller = TextEditingController(text: widget.drug.unitPrice);
//     _drCategorycontroller = TextEditingController(text: widget.drug.drCategory);
//     _drStatuscontroller = TextEditingController(text: widget.drug.drStatus);
//     //init state
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _drCodecontroller!.dispose();
//     _drNamecontroller!.dispose();
//     _unitPriceontroller!.dispose();
//     _drCategorycontroller!.dispose();
//     _drStatuscontroller!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Edit Drug Info"),
//           backgroundColor: const Color.fromARGB(255, 17, 90, 150),
//           elevation: 0.0,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: _drNamecontroller,
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Drug Name"),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _drCodecontroller,
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Drug Code"),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _unitPriceontroller,
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Unit Price"),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _drCategorycontroller,
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Drug Category"),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: _drStatuscontroller,
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(), hintText: "Drug Status"),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     DrugHelper.update(DrugsModel(
//                             id: widget.drug.id,
//                             drCode: _drCodecontroller!.text,
//                             drName: _drNamecontroller!.text,
//                             unitPrice: _unitPriceontroller!.text,
//                             drCategory: _drCategorycontroller!.text,
//                             drStatus: _drStatuscontroller!.text
//                             ))
//                         .then((value) {
//                       Navigator.pop(context);
//                     });
//                   },
//                   child: Container(
//                     width: 100,
//                     height: 30,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.green),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Icon(
//                           Icons.update,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           "Modify",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }