import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String? id;
  final String? fullname;
  final String? age;

  DoctorModel({this.fullname, this.age, this.id});
  factory DoctorModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return DoctorModel(
      fullname: snapshot['fullname'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {"fullname": fullname, "age": age, "id": id};
}
