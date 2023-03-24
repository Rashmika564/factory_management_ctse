import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalModel {
  final String? id;
  final String? hospitalname;
  final String? branch;
  final String? hospitaladdress;
  final String? telephone;

  HospitalModel(
      {this.id,
      this.hospitalname,
      this.branch,
      this.hospitaladdress,
      this.telephone});
  factory HospitalModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return HospitalModel(
      id: snapshot['id'],
      hospitalname: snapshot['hospitalname'],
      branch: snapshot['branch'],
      hospitaladdress: snapshot['hospitaladdress'],
      telephone: snapshot['telephone'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalname": hospitalname,
        "branch": branch,
        "hospitaladdress": hospitaladdress,
        "telephone": telephone,
      };
}
