import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);


final textInputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(width: 1.5)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
            color: const Color.fromARGB(255, 17, 90, 150), width: 1.5)));
