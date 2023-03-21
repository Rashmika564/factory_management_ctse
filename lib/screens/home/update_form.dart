import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> phones = ['119', '911'];

  String? fullName;
  String? mobile;
  int? age;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update are Done here',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'full name'),
            validator: (val) => val!.isEmpty ? 'Please enter the name ' : null,
            onChanged: (val) {
              setState(() => fullName = val);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          //dropdown
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: mobile,
            items: phones.map((p) {
              return DropdownMenuItem(
                value: p,
                child: Text(p),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => mobile = value as String?);
            },
          ),
          //slider
          ElevatedButton(
            child: Text(
              'update',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              print(fullName);
              print(mobile);
              // if (_formKey.currentState!.validate()) {
              //   // setState(() => loading = true);

              // }
            },
          ),
        ],
      ),
    );
  }
}
