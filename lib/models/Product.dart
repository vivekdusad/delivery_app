import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  String category;
  String subcategory;
  // ignore: non_constant_identifier_names
  final String image_url;
  final String price;

  Product({
    @required this.id,
    @required this.category,
    @required this.subcategory,
    // ignore: non_constant_identifier_names
    @required this.image_url,
    @required this.name,
    @required this.price,
  });

  Product copyWith({
    String id,
    String name,
    String images,
    String price,
    String category,
    String subcategory,

  }) {
    return Product(
      category: category??this.category,
      subcategory: subcategory??this.category,
      id: id ?? this.id,
      name: name ?? this.name,
      image_url: images ?? this.image_url,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_url': image_url,
      'price': price,
      'subcategory':subcategory,
      'category':category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      subcategory: map['subcategory'],
      category: map['category'],
      id: map['id'],
      name: map['name'],
      image_url: map['image_url'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, images: $image_url, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.image_url == image_url &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ image_url.hashCode ^ price.hashCode;
  }
}

// Our demo Products
const url =
    "https://firebasestorage.googleapis.com/v0/b/deliveryapp-6b08d.appspot.com/o/moong.jpg?alt=media&token=6c21c753-492a-415c-9330-332f41b1b63c";



const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
