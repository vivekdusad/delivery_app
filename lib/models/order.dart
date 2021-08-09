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
  String token;
  List<Product> items=[];
  String date;
  // ignore: non_constant_identifier_names
  String user_id;
  bool completted = false;
  bool delivered = false;
  bool cancelled = false;
  bool outfordelivery = false;
  bool ready = false;
  List<int> counts=[];
  Order({
    @required this.total,
    @required this.order_id,
    @required this.name,
    @required this.address,
    @required this.token,
    @required this.items,
    @required this.date,
    @required this.user_id,
     this.completted=false,
     this.delivered=false,
     this.cancelled=false,
     this.outfordelivery=false,
     this.ready=false,
     this.counts,
  });

  Order copyWith({
    String total,
    String order_id,
    String name,
    String address,
    String token,
    List<Product> items,
    String date,
    String user_id,
    bool completted,
    bool delivered,
    bool cancelled,
    bool outfordelivery,
    bool ready,
    List<String> counts,
  }) {
    return Order(
      total: total ?? this.total,
      order_id: order_id ?? this.order_id,
      name: name ?? this.name,
      address: address ?? this.address,
      token: token ?? this.token,
      items: items ?? this.items,
      date: date ?? this.date,
      user_id: user_id ?? this.user_id,
      completted: completted ?? this.completted,
      delivered: delivered ?? this.delivered,
      cancelled: cancelled ?? this.cancelled,
      outfordelivery: outfordelivery ?? this.outfordelivery,
      ready: ready ?? this.ready,
      counts: counts ?? this.counts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'order_id': order_id,
      'name': name,
      'address': address,
      'token': token,
      'items': items?.map((x) => x.toMap())?.toList(),
      'date': date,
      'user_id': user_id,
      'completted': completted,
      'delivered': delivered,
      'cancelled': cancelled,
      'outfordelivery': outfordelivery,
      'ready': ready,
      'counts': counts,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      total: map['total'],
      order_id: map['order_id'],
      name: map['name'],
      address: map['address'],
      token: map['token'],
      items: List<Product>.from(map['items']?.map((x) => Product.fromMap(x))),
      date: map['date'],
      user_id: map['user_id'],
      completted: map['completted'],
      delivered: map['delivered'],
      cancelled: map['cancelled'],
      outfordelivery: map['outfordelivery'],
      ready: map['ready'],
      counts: List<int>.from(map['counts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(total: $total, order_id: $order_id, name: $name, address: $address, token: $token, items=[]: $items=[], date: $date, user_id: $user_id, completted: $completted, delivered: $delivered, cancelled: $cancelled, outfordelivery: $outfordelivery, ready: $ready, counts=[]: $counts=[])';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Order &&
      other.total == total &&
      other.order_id == order_id &&
      other.name == name &&
      other.address == address &&
      other.token == token &&
      listEquals(other.items=[], items=[]) &&
      other.date == date &&
      other.user_id == user_id &&
      other.completted == completted &&
      other.delivered == delivered &&
      other.cancelled == cancelled &&
      other.outfordelivery == outfordelivery &&
      other.ready == ready &&
      listEquals(other.counts=[], counts=[]);
  }

  
}
