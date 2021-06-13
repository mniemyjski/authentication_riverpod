import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Preference extends Equatable {
  final String uid;

  Preference({required this.uid});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [uid];

  factory Preference.fromMap(Map<String, dynamic> map) {
    return new Preference(
      uid: map['uid'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'uid': this.uid,
    } as Map<String, dynamic>;
  }
}
