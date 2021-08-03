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
  String user_id;
  bool completted = false;
  bool delivered = false;
  bool cancelled = false;
  bool outfordelivery = false;
  bool ready=false;
  Order(
      {@required this.total,
      @required this.name,
      @required this.address,
      @required this.items,
      @required this.date,
      this.cancelled,
      this.outfordelivery,
      this.delivered,
      @required this.user_id,
      this.ready,
      this.completted});

  Order copyWith({
    String total,
    String name,
    String address,
    List<Product> items,
    bool cancelled,
    bool delivered,
    bool outfordelivey,
    String date,
    String user_id,
    bool completed,
    bool ready,
  }) {
    return Order(
      user_id: user_id ?? this.user_id,
      completted: completted ?? this.completted,
      total: total ?? this.total,
      name: name ?? this.name,
      address: address ?? this.address,
      items: items ?? this.items,
      date: date ?? this.date,
      delivered: delivered ?? this.delivered,
      outfordelivery: outfordelivery ?? this.outfordelivery,
      cancelled: cancelled ?? this.cancelled,
      ready: ready??this.ready,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'name': name,
      'address': address,
      'completted': false,
      'outfordelivery': false,
      'cancelled': false,
      'delivered': false,
      'items': items?.map((x) => x.toMap())?.toList(),
      'date': date,
      'ready':ready,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      total: map['total'],
      user_id: map['user_id'],
      delivered: map['delivered'],
      cancelled: map['cancelled'],
      outfordelivery: map['outfordelivery'],
      completted: map['completted'],
      name: map['name'],
      address: map['address'],
      date: map['date'],
      ready: map['ready'],
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
