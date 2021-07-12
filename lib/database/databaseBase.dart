import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:delivery_app/models/order.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseBase implements Database {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseDatabase = FirebaseDatabase.instance.reference();
  final String uid;
  DatabaseBase({
    this.uid,
  }) : assert(uid != null);

  @override
  Stream<List<Product>> getSuggestions(String query) {
    //! Search Functanality here
    final refrence = _firestore.collectionGroup(ApiPath.products);
    final snaps =
        refrence.where("name", isGreaterThanOrEqualTo: query).snapshots();
    var results = snaps.map(
        (event) => event.docs.map((e) => Product.fromMap(e.data())).toList());
    return results;
  }

  @override
  Stream<List<Product>> readProducts(String apiPath) {
    //!List of Products here
    final collectionRef = _firestore.collection(apiPath);
    final snapshots = collectionRef.snapshots();
    var result = snapshots.map(
        (event) => event.docs.map((e) => Product.fromMap(e.data())).toList());
    return result;
  }

  Future<void> saveOrder(Order order) async {
    await _firestore.collection(ApiPath.orders(uid)).doc().set(order.toMap());
  }
}
