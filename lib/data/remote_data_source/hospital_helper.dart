import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/hospital_model.dart';

class HospitalHelper {
  static Stream<List<HospitalModel>> read() {
    final hospitalCollection =
        FirebaseFirestore.instance.collection("hospital");
    return hospitalCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => HospitalModel.fromSnapshot(e)).toList());
  }

  static Future create(HospitalModel hospital) async {
    final hospitalCollection = FirebaseFirestore.instance.collection("hospital");

    final hospitalid = hospitalCollection.doc().id;
    final hosRef = hospitalCollection.doc(hospitalid);

    final newHospital = HospitalModel(
            id: hospitalid,
            hospitalname: hospital.hospitalname,
            hospitalbranch: hospital.hospitalbranch,
            hospitaladdress: hospital.hospitaladdress,
            telephone: hospital.telephone)
        .toJson();

    try {
      await hosRef.set(newHospital);
    } catch (e) {
      print("Some error occured");
    }
  }

  static Future update(HospitalModel hospital) async {
    final hospitalCollection = FirebaseFirestore.instance.collection("hospital");

    final hosRef = hospitalCollection.doc(hospital.id);

    final updateHospitalRec = HospitalModel(
            id: hospital.id,
            hospitalname: hospital.hospitalname,
            hospitalbranch: hospital.hospitalbranch,
            hospitaladdress: hospital.hospitaladdress,
            telephone: hospital.telephone)
        .toJson();

    try {
      await hosRef.update(updateHospitalRec);
    } catch (e) {
      print("some error occured");
    }
  }

  static Future delete(HospitalModel hospital) async {

    final hospitalCollection =
        FirebaseFirestore.instance.collection("hospital");
    final hosRef = hospitalCollection.doc(hospital.id).delete();
  }
}
