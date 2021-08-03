import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/models/orderTrack.dart';
import 'package:delivery_app/models/user.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class DatabaseBase implements Database {
  final _firestore = FirebaseFirestore.instance;
  final String uid;
  DatabaseBase({
    this.uid,
  }) : assert(uid != null);

  @override
  Stream<List<Product>> getSuggestions(String query) {
    final refrence = _firestore.collectionGroup(ApiPath.products);
    final snaps =
        refrence.where("name", isGreaterThanOrEqualTo: query).snapshots();
    var results = snaps.map(
        (event) => event.docs.map((e) => Product.fromMap(e.data())).toList());
    return results;
  }

  @override
  Stream<List<Product>> readProducts(String apiPath) {
    final collectionRef = _firestore.collection(ApiPath.products);
    final snapshots = collectionRef.snapshots();
    var result = snapshots.map(
        (event) => event.docs.map((e) => Product.fromMap(e.data())).toList());
    return result;
  }

  Future<void> updateUser(User user) async {
    print(ApiPath.users(uid));
    final collectionRef = _firestore.collection(ApiPath.users(uid)).doc(uid);
    final id = collectionRef.id;
    await collectionRef
        .update(user.copyWith(id: id).toMap())
        .then((value) => print("success"));
  }

  Future<String> saveOrder(Order order) async {
    final document = _firestore.collection(ApiPath.orders(uid)).doc();
    final id = document.id;
    await document.set(order.toMap());
    Dio().post("http://192.168.0.103:3000", data: {
      "user_id": "$uid",
      "order_id": "$id",
      "order": "${order.toMap()}"
    });
    return id;
  }

  Stream<Order> orderTracker(String order_id) {
    print(uid);
    print(order_id);
    final document = _firestore.doc(ApiPath.orders(uid) + "/$order_id");
    document.update({'name': 'vivek'});
    document.snapshots().map((event) => Order.fromMap(event.data()));
  }

  Stream<List<Order>> getHistory()  {
    final collectionRef = _firestore.collection(ApiPath.orders(uid));
    final snapshots = collectionRef.snapshots();
    var result = snapshots.map(
        (event) => event.docs.map((e) => Order.fromMap(e.data())).toList());
    return result;
  }

  Future<bool> updateFavorites({String productID}) async {
    DocumentReference favoritesReference =
        _firestore.collection(ApiPath.favorite(uid)).doc(uid);
    return _firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(favoritesReference);
      if (postSnapshot.exists) {
        Map f = postSnapshot.data();
        List favorite = f['favorites'];
        // Extend 'favorites' if the list does not contain the recipe ID:
        if (!favorite.contains(productID)) {
          print("added");
          tx.update(favoritesReference, <String, dynamic>{
            'favorites': FieldValue.arrayUnion([productID])
          });
          // Delete the recipe ID from 'favorites':
        } else {
          print("deleted");
          tx.update(favoritesReference, <String, dynamic>{
            'favorites': FieldValue.arrayRemove([productID])
          });
        }
      } else {
        // Create a document for the current user in collection 'users'
        // and add a new array 'favorites' to the document:
        print("added1");
        tx.set(favoritesReference, {
          'favorites': [productID]
        });
      }
    }).then((result) {
      return true;
    }).catchError((error) {
      print('Error: $error');
      return false;
    });
  }

  @override
  Future<List<Product>> getFavorites() async {
    DocumentReference favoritesReference =
        _firestore.doc(ApiPath.favorite(uid));
    try {
      final data = await favoritesReference.get();
      final List list = jsonDecode(data.get('favorites')) as List;
      return list.map((e) => Product.fromMap(e)).toList();
    } on FirebaseException catch (e) {
      print(e);
      return [];
    }
  }
}
