import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/fuser.dart';

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

  //userlist snap
  List<FUser> factoryUserSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FUser(
          fullName: doc['fullName'] ?? '',
          mobile: doc['mobile'] ?? '',
          age: doc['age'] ?? 0);
    }).toList();
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
  Stream<List<FUser>> get users {
    print("hello");
    print(userCollection.snapshots());
    userCollection.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            print("jkk");
            print(querySnapshot.docs.length);
            print(doc['fullName']);
          })
        });
    // print("jhol");
    // print(userCollection.snapshots().map((factoryUserSnapshot)));
    // ignore: unnecessary_null_comparison
    return userCollection.snapshots().map((factoryUserSnapshot));
  }
}
