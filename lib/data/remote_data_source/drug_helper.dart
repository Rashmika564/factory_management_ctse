import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/drugs_model.dart';
import 'package:flutter/foundation.dart';

class DrugHelper {
  static Stream<List<DrugsModel>> read() {
    final drugCollection = FirebaseFirestore.instance.collection("drug");
    return drugCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => DrugsModel.fromSnapshot(e)).toList());
  }

  static Future create(DrugsModel drug) async {
    final drugsCollection = FirebaseFirestore.instance.collection("drug");

    final did = drugsCollection.doc().id;
    final drugRef = drugsCollection.doc(did);

    final newdrug = DrugsModel(
            id: did,
            drCode: drug.drCode,
            drName: drug.drName,
            unitPrice: drug.unitPrice,
            drCategory: drug.drCategory)
        .toJson();

    try {
      await drugRef.set(newdrug);
    } catch (e) {
      if (kDebugMode) {
        print("some error occured when create appoinment");
      }
    }
  }

  static Future update(DrugsModel drug) async {
    final drugCollection = FirebaseFirestore.instance.collection("drug");

    final drugRef = drugCollection.doc(drug.id);

    final updateAppoinmentRec = DrugsModel(
            id: drug.id,
            drCode: drug.drCode,
            drName: drug.drName,
            unitPrice: drug.unitPrice,
            drCategory: drug.drCategory)
        .toJson();

    try {
      await drugRef.update(updateAppoinmentRec);
    } catch (e) {
      if (kDebugMode) {
        print("some error occured");
      }
    }
  }

  static Future delete(DrugsModel drug) async {
    final drugCollection = FirebaseFirestore.instance.collection("drug");
    final drugRef = drugCollection.doc(drug.id).delete();
  }
}
