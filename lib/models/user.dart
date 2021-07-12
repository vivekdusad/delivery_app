import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:delivery_app/models/order.dart';

class User {
  String name;
  String address;
  String mobile;
  Order orders;
  User({
    @required this.name,
    @required this.address,
    @required this.mobile,
    @required this.orders,
  });

  User copyWith({
    String name,
    String address,
    String mobile,
    Order orders,
  }) {
    return User(
      name: name ?? this.name,
      address: address ?? this.address,
      mobile: mobile ?? this.mobile,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'mobile': mobile,
      'orders': orders.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      address: map['address'],
      mobile: map['mobile'],
      orders: Order.fromMap(map['orders']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, address: $address, mobile: $mobile, orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.address == address &&
      other.mobile == mobile &&
      other.orders == orders;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      address.hashCode ^
      mobile.hashCode ^
      orders.hashCode;
  }
}
