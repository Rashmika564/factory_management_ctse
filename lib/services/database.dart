import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //collection ref
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String fullName, String mobile, int age) async {
    return await userCollection.doc(uid).set({
      'fullName': fullName,
      'mobile': mobile,
      'age': age,
    });
  }

  // Future updatePrductData(
  //     String productName, String productType, int price) async {
  //   return await productCollection.doc(uid).set({
  //     productName: productName,
  //     productType: productType,
  //     price: price,
  //   });
  // }

  //get users stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
