import 'dart:convert';
import 'package:flutter/material.dart';

class User {
  String name;
  String id;
  
  String lat;
  String long;

  String address;
  String phone;
  // ignore: non_constant_identifier_names
  String pin_code;
  User({
    @required this.name,
    @required this.id,
    @required this.address,
    @required this.phone,
    @required this.lat,
    @required this.long,
    
    // ignore: non_constant_identifier_names
    @required this.pin_code,
  });

  User copyWith({
    String name,
    String id,
    String address,
    String phone,
    // ignore: non_constant_identifier_names
    String pin_code,
  }) {
    return User(
      lat: lat??this.lat,
      long: long??this.long,

      name: name ?? this.name,
      id: id ?? this.id,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      pin_code: pin_code ?? this.pin_code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'long':long,
      'lat':lat,
      'address': address,
      'phone': phone,
      'pin_code': pin_code,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      lat: map['lat'],
      long: map['long'],
      id: map['id'],
      address: map['address'],
      phone: map['phone'],
      pin_code: map['pin_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, id: $id, address: $address, phone: $phone, pin_code: $pin_code)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.id == id &&
        other.address == address &&
        other.phone == phone &&
        other.pin_code == pin_code;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        pin_code.hashCode;
  }
}
