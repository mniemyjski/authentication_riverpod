import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Preference extends Equatable {
  Preference();

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [];

  factory Preference.fromMap(Map<String, dynamic> map) {
    return new Preference();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {} as Map<String, dynamic>;
  }
}
