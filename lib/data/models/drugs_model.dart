import 'package:cloud_firestore/cloud_firestore.dart';

class DrugsModel {
  final String? id;
  final String? drCode;
  final String? drName;
  final String? unitPrice;
  final String? drCategory;
  final String? drStatus;

  DrugsModel(
      {this.drCode,
      this.drName,
      this.unitPrice,
      this.drCategory,
      this.drStatus,
      this.id});
  factory DrugsModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return DrugsModel(
      drCode: snapshot['drCode'],
      drName: snapshot['drName'],
      unitPrice: snapshot['unitPrice'],
      drCategory: snapshot['drCategory'],
      drStatus: snapshot['drStatus'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "drCode": drCode,
        "drName": drName,
        "unitPrice": unitPrice,
        "drCategory": drCategory,
        "drStatus": drStatus,
        "id": id
      };
}
