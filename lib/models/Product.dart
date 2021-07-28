import 'dart:convert';

import 'package:delivery_app/constants/enums.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final String price;
  final String category;

  Product({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.price,
    @required this.category
  });

  Product copyWith({
    int id,
    String name,
    String images,
    String category,
    String price,
  }) {
    return Product(
      id: id ?? this.id,
      category: category??this.category,
      name: name ?? this.name,
      image: images ?? this.image,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'images': image,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      category: map['category'],
      name: map['name'],
      image: map['images'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, images: $image, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ image.hashCode ^ price.hashCode;
  }
}

// Our demo Products
const url =
    "https://firebasestorage.googleapis.com/v0/b/deliveryapp-6b08d.appspot.com/o/moong.jpg?alt=media&token=6c21c753-492a-415c-9330-332f41b1b63c";

List<Product> demoProducts = [
  Product(
    id: "1",
    image: url,
    name: "Mung Daal",
    category: Category.kitchen,
    price: "250",
  ),
  Product(
    id: "2",
    image: url,
    name: "Surf Excel",
    category: Category.cleansers,
    price: "120",
  ),
  Product(
    id: "3",
    image: url,
    name: "Mung Daal",
    category: Category.kitchen,
    price: "64",
  ),
  Product(
    id: "4",
    category: Category.kitchen,
    image: url,
    name: "Rajma",
    price: "50",
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
