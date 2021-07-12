import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:delivery_app/models/Product.dart';

class Order {
  String total;
  String name;
  String address;

  List<Product> items;
  String date;
  Order({
    @required this.total,
    @required this.name,
    @required this.address,
    @required this.items,
    @required this.date,
  });

  Order copyWith({
    String total,
    String name,
    String address,
    List<Product> items,
    String date,
  }) {
    return Order(
      total: total ?? this.total,
      name: name ?? this.name,
      address: address ?? this.address,
      items: items ?? this.items,
      date: date??this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'name': name,
      'address': address,
      'items': items?.map((x) => x.toMap())?.toList(),
      'date':date,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      total: map['total'],
      name: map['name'],
      address: map['address'],
      date: map['date'],
      items: List<Product>.from(map['items']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(total: $total, name: $name, address: $address, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.total == total &&
        other.name == name &&
        other.address == address &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return total.hashCode ^ name.hashCode ^ address.hashCode ^ items.hashCode;
  }
}
