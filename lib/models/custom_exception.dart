import 'package:flutter/material.dart';

class CustomException {
  final String message;
  final String path;
  CustomException({
    @required this.message,
    @required this.path,
  });

  CustomException copyWith({
    String message,
  }) {
    return CustomException(
      message: message ?? this.message,
      path: path??this.path,
    );
  }

  @override
  String toString() => 'CustomException(message: $message)';

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomException && other.message == message;
  }
}
