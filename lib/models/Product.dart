import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String images;
  final String price;

  Product({
    @required this.id,
    @required this.images,
    @required this.name,
    @required this.price,
  });

  Product copyWith({
    int id,
    String name,
    String images,
    String price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      images: images ?? this.images,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'images': images,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      images: map['images'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, images: $images, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.images == images &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ images.hashCode ^ price.hashCode;
  }
}

// Our demo Products
const url =
    "https://firebasestorage.googleapis.com/v0/b/deliveryapp-6b08d.appspot.com/o/moong.jpg?alt=media&token=6c21c753-492a-415c-9330-332f41b1b63c";

List<Product> demoProducts = [
  Product(
    id: "1",
    images: url,
    name: "Mung Daal",
    price: "250",
  ),
  Product(
    id: "2",
    images: url,
    name: "Surf Excel",
    price: "120",
  ),
  Product(
    id: "3",
    images: url,
    name: "Mung Daal",
    price: "64",
  ),
  Product(
    id: "4",
    images: url,
    name: "Rajma",
    price: "50",
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
