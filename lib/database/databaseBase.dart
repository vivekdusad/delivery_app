import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/constants/apipath.dart';
import 'package:delivery_app/constants/provider.dart';
import 'package:delivery_app/database/database.dart';
import 'package:delivery_app/models/Product.dart';
import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/models/user.dart';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatabaseBase implements Database {
  final _firestore = FirebaseFirestore.instance;
  final String uid;
  List<DocumentSnapshot> productsSnapshot = [];
  List<Product> product = [];
  DatabaseBase({
    this.uid,
  }) : assert(uid != null);

  @override
  Stream<List<Product>> getSuggestions(String query) {
    try {
      final refrence = _firestore.collection(ApiPath.products);
      final snaps =
          refrence.where("name", isGreaterThanOrEqualTo: query).snapshots();
      var results = snaps.map(
          (event) => event.docs.map((e) => Product.fromMap(e.data())).toList());
      return results;
    } on SocketException catch (e) {
      throw SocketException("internet Error");
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin, message: e.message);
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  @override
  Future<List<Product>> readProducts(String apiPath) async {
    var collectionRef;
    print("calledcalled");
    try {
      if (productsSnapshot.length == 0) {
        collectionRef = _firestore.collection(ApiPath.products).limit(10);
      } else {
        print("object");
        collectionRef = _firestore
            .collection(ApiPath.products)
            .startAfterDocument(productsSnapshot[productsSnapshot.length - 1])
            .limit(10);
      }

      final snapshots = await collectionRef.get();
      snapshots.docs.forEach((element) {
        productsSnapshot.add(element);
      });

      var result =
          snapshots.docs.map((event) => Product.fromMap(event.data())).toList();

      result.forEach((element) {
        product.add(element);
      });
      return product;
    } on SocketException catch (e) {
      print("socket");
      throw SocketException("internet Error");
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin, message: e.message);
    } catch (e) {
      print(e);
      throw Exception("Something Went Wrong");
    }
  }

  Future<void> updateUser(Users user) async {
    try {
      print(ApiPath.users(uid));
      final collectionRef = _firestore.collection(ApiPath.users(uid)).doc(uid);
      final id = collectionRef.id;
      await collectionRef
          .update(user.copyWith(id: id).toMap())
          .then((value) => print("success"));
    } on SocketException catch (e) {
      throw SocketException("internet Error");
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin, message: e.message);
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  Future<String> saveOrder(Order order) async {
    try {
      final document = _firestore.collection(ApiPath.orders(uid)).doc();
      final id = document.id;
      await document
          .set(order.copyWith(order_id: id).toMap())
          .then((value) => {});

      var token = await FirebaseMessaging.instance.getToken();
      Dio().post("https://a34c21ee09b6.ngrok.io", data: {
        "user_id": "$uid",
        "order_id": "$id",
        "order": "${order.toMap()}",
        'token': "$token",
      });
      return id;
    } on SocketException catch (e) {
      throw SocketException("internet Error");
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin, message: e.message);
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  // ignore: non_constant_identifier_names
  Stream<Order> orderTracker(String order_id) {
    try {
      print(uid);
      print(order_id);
      final document = _firestore.doc(ApiPath.orders(uid) + "/$order_id");
      document.update({'name': 'vivek'});
      return document.snapshots().map((event) => Order.fromMap(event.data()));
    } on SocketException catch (e) {
      throw SocketException("internet Error");
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin, message: e.message);
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  Stream<List<Order>> getHistory() {
    try {
      final collectionRef = _firestore.collection(ApiPath.orders(uid));
      final snapshots = collectionRef.snapshots();
      var result = snapshots.map(
          (event) => event.docs.map((e) => Order.fromMap(e.data())).toList());
      return result;
    } on SocketException catch (e) {
      throw SocketException("internet Error");
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin, message: e.message);
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  Future<void> saveUser({Users user}) async {
    final doc = _firestore.collection(ApiPath.users(uid)).doc();
    final id = doc.id;
    //todo: change number
    await doc
        .set(user.copyWith(id: id, phone: "8302135675").toMap())
        .then((value) {
      print("sucess");
    });
    await ProviderContainer()
        .read(localStorageProvider)
        .saveUserToStorage(user);
  }
}
