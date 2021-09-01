import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:delivery_app/models/product.dart';

class OrderTrack {
  String name;
  String date;
  String address;
  String total;
  // ignore: non_constant_identifier_names
  String order_id;
  // ignore: non_constant_identifier_names
  String user_id;
  List<Product> items;
  bool isReady = false;
  bool outForDelivery = false;
  bool cancelled = false;
  bool completted = false;
  OrderTrack({
    @required this.name,
    @required this.total,
    // ignore: non_constant_identifier_names
    @required this.order_id,
    // ignore: non_constant_identifier_names
    @required this.user_id,
    @required this.items,
    @required this.isReady,
    @required this.outForDelivery,
    @required this.cancelled,
    @required this.completted,
  });

  OrderTrack copyWith({
    String name,
    String total,
    // ignore: non_constant_identifier_names
    String order_id,
    // ignore: non_constant_identifier_names
    String user_id,
    List<Product> items,
    bool isReady,
    bool outForDelivery,
    bool cancelled,
    bool completted,
  }) {
    return OrderTrack(
      name: name ?? this.name,
      total: total ?? this.total,
      order_id: order_id ?? this.order_id,
      user_id: user_id ?? this.user_id,
      items: items ?? this.items,
      isReady: isReady ?? this.isReady,
      outForDelivery: outForDelivery ?? this.outForDelivery,
      cancelled: cancelled ?? this.cancelled,
      completted: completted ?? this.completted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'total': total,
      'order_id': order_id,
      'user_id': user_id,
      'items': items?.map((x) => x.toMap())?.toList(),
      'isReady': isReady,
      'outForDelivery': outForDelivery,
      'cancelled': cancelled,
      'completted': completted,
    };
  }

  factory OrderTrack.fromMap(Map<String, dynamic> map) {
    return OrderTrack(
      name: map['name'],
      total: map['total'],
      order_id: map['order_id'],
      user_id: map['user_id'],
      items: List<Product>.from(map['items']?.map((x) => Product.fromMap(x))),
      isReady: map['isReady'],
      outForDelivery: map['outForDelivery'],
      cancelled: map['cancelled'],
      completted: map['completted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderTrack.fromJson(String source) =>
      OrderTrack.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderTrack(name: $name, total: $total, order_id: $order_id, user_id: $user_id, items: $items, isReady: $isReady, outForDelivery: $outForDelivery, cancelled: $cancelled, completted: $completted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderTrack &&
        other.name == name &&
        other.total == total &&
        other.order_id == order_id &&
        other.user_id == user_id &&
        listEquals(other.items, items) &&
        other.isReady == isReady &&
        other.outForDelivery == outForDelivery &&
        other.cancelled == cancelled &&
        other.completted == completted;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        total.hashCode ^
        order_id.hashCode ^
        user_id.hashCode ^
        items.hashCode ^
        isReady.hashCode ^
        outForDelivery.hashCode ^
        cancelled.hashCode ^
        completted.hashCode;
  }
}
