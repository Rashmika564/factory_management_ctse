import 'package:factory_management_ctse/data/models/drugs_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/drug_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/auth.dart';
import 'drugs_list.dart';

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
        body: Stack(
          children: 
            [Form(
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
                  const Text("Add Drug",
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
                                  builder: (context) => const DrugsList()));
                        }),
                  ),
                  // const Schedule(),
                  const SizedBox(height: 30.0),
                  // const Image(image: AssetImage('graphics/background.png')),
                  TextFormField(
                    controller: _drNamecontroller,
                    keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Drug Name",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _drCodecontroller,
                    keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Drug Code",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
                  ),
                  const SizedBox(
                      height: 10,
                    ),
                  TextFormField(
                    controller: _unitPriceontroller,
                    keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Unit Price",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _drCategorycontroller,
                    keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Drug Category",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _drStatuscontroller,
                    keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Drug Status",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
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
                              builder: (context) => const DrugsList()));
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
          ],
        ),
      ),
    );
  }
}
