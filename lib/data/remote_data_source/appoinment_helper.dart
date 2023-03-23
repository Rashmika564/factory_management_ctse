import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/apponment_model.dart';


class AppoinmentHelper {
  static Stream<List<AppoinmentModel>> read() {
    final doctorCollection = FirebaseFirestore.instance.collection("appoinments");
    return doctorCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => AppoinmentModel.fromSnapshot(e)).toList());
  }

  static Future create(AppoinmentModel appoinment) async {
    final appoinmenntCollection = FirebaseFirestore.instance.collection("appoinments");

    final did = appoinmenntCollection.doc().id;
    final appoinementRef = appoinmenntCollection.doc(did);

    final newAppoinment = AppoinmentModel(
      id: did,
      doctorName: appoinment.doctorName,
      hospitalName: appoinment.hospitalName,
      date: appoinment.date,
      reson: appoinment.reson
    ).toJson();

    try {
      await appoinementRef.set(newAppoinment);
    } catch (e) {
      print("some error occured when create appoinment");
    }
  }

  static Future update(AppoinmentModel appoinment) async {
    final appoinmenntCollection = FirebaseFirestore.instance.collection("appoinments");

    final appoinmentRef = appoinmenntCollection.doc(appoinment.id);

    final updateAppoinmentRec = AppoinmentModel(
      id: appoinment.id,
      doctorName: appoinment.doctorName,
      hospitalName: appoinment.hospitalName,
      date: appoinment.date,
      reson: appoinment.reson
    ).toJson();

    try {
      await appoinmentRef.update(updateAppoinmentRec);
    } catch (e) {
      print("some error occured");
    }
  }

  static Future delete(AppoinmentModel appoinment) async {
    final appoinmenntCollection = FirebaseFirestore.instance.collection("appoinments");
    final appoinmentRef = appoinmenntCollection.doc(appoinment.id).delete();
  }
  
}
