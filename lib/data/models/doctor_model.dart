import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String? id;
  final String? fullname;
  final String? age;
  final String? doctorcategory;
  final String? mobilenumber;
  final String? livingaddress;
  final String? noofassignednurses;

  DoctorModel(
      {this.fullname,
      this.age,
      this.id,
      this.doctorcategory,
      this.mobilenumber,
      this.livingaddress,
      this.noofassignednurses});
  factory DoctorModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return DoctorModel(
      fullname: snapshot['fullname'],
      age: snapshot['age'],
      id: snapshot['id'],
      doctorcategory: snapshot['doctorcategory'],
      mobilenumber: snapshot['mobilenumber'],
      livingaddress: snapshot['livingaddress'],
      noofassignednurses: snapshot['noofassignednurses'],
    );
  }

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "age": age,
        "id": id,
        "doctorcategory": doctorcategory,
        "mobilenumber": mobilenumber,
        "livingaddress": livingaddress,
        "noofassignednurses": noofassignednurses
      };
}
