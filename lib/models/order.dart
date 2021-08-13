import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Product.dart';

class Order {
  String total;
  // ignore: non_constant_identifier_names
  String order_id;
  String name;
  String address;
  String phone;
  String code;
  String token;
  String lat;
  String long;
  List<Product> items = [];
  String date;
  String track;
  // ignore: non_constant_identifier_names
  String user_id;

  List<int> counts = [];
  Order({
    @required this.total,
    // ignore: non_constant_identifier_names
    @required this.order_id,
    @required this.name,
    @required this.address,
    @required this.token,
    @required this.items,
    @required this.date,
    @required this.code,
    @required this.phone,
    // ignore: non_constant_identifier_names
    @required this.user_id,
    @required this.lat,
    @required this.long,
    @required this.track,
    this.counts,
  });

  Order copyWith({
    String total,
    // ignore: non_constant_identifier_names
    String order_id,
    String name,
    String address,
    String token,
    List<Product> items,
    String date,
    // ignore: non_constant_identifier_names
    String user_id,
    String track,
    List<String> counts,
    String code,
    String phone,
  }) {
    return Order(
      track: track ?? this.track,
      total: total ?? this.total,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      order_id: order_id ?? this.order_id,
      name: name ?? this.name,
      address: address ?? this.address,
      token: token ?? this.token,
      items: items ?? this.items,
      date: date ?? this.date,
      user_id: user_id ?? this.user_id,
      counts: counts ?? this.counts,
      code: code??this.code,
      phone: phone??this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'order_id': order_id,
      'name': name,
      'lat': lat,
      'long': long,
      'address': address,
      'token': token,
      'items': items?.map((x) => x.toMap())?.toList(),
      'date': date,
      'user_id': user_id,
      'phone':phone,
      'code':code,
      'counts': counts,
      'track': track,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      long: map['long'],
      lat: map['lat'],
      total: map['total'],
      order_id: map['order_id'],
      name: map['name'],
      address: map['address'],
      token: map['token'],
      track: map['track'],
      items: List<Product>.from(map['items']?.map((x) => Product.fromMap(x))),
      date: map['date'],
      user_id: map['user_id'],
      code: map['code'],
      phone: map['phone'],
      counts: List<int>.from(map['counts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(total: $total, order_id: $order_id, name: $name, address: $address, token: $token, items=[]: $items=[], date: $date, user_id: $user_id,counts=[]: $counts=[])';
  }
}
