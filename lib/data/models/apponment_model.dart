import 'package:cloud_firestore/cloud_firestore.dart';

class AppoinmentModel {
  final String? id;
  final String? doctorName;
  final String? hospitalName;
  final String? date;
  final String? reson;

  AppoinmentModel({this.doctorName, this.hospitalName,this.date,this.reson , this.id});
  factory AppoinmentModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AppoinmentModel(
      doctorName: snapshot['doctorName'],
      hospitalName: snapshot['hospitalName'],
      date: snapshot['date'],
      reson: snapshot['reson'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {"doctorName": doctorName, "hospitalName": hospitalName, "date": date, "reson":reson,  "id": id};
}
