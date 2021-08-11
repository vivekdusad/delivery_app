import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user.g.dart';
@HiveType(typeId : 1)
class Users {
  @HiveField(0)
  String name;
  @HiveField(1)
  String id;
  @HiveField(2)
  String address;
  @HiveField(3)
  String phone;
  
  Users({
    @required this.name,
    @required this.id,
    @required this.address,
    @required this.phone,   
    

  });

  Users copyWith({
    String name,
    String id,
    String address,
    String phone,

  }) {
    return Users(
      name: name ?? this.name,
      id: id ?? this.id,
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'address': address,
      'phone': phone,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'],
      id: map['id'],
      address: map['address'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, id: $id, address: $address, phone: $phone,)';
  } 

  
}
