import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:delivery_app/models/Product.dart';

class Favorite {
  
  List<Product> favorites=[];
  Favorite({
    @required this.favorites,
  });

  Favorite copyWith({
    List<Product> items,
  }) {
    return Favorite(
      favorites: items ?? this.favorites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'favorites': favorites?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      favorites: List<Product>.from(map['favorites']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) => Favorite.fromMap(json.decode(source));

  @override
  String toString() => 'Favorite(favorites: $favorites)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Favorite &&
      listEquals(other.favorites, favorites);
  }

  @override
  int get hashCode => favorites.hashCode;
}
