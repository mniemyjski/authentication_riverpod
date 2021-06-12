import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Preference extends Equatable {
  final bool init;

  Preference({required this.init});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [init];

  factory Preference.fromMap(Map<String, dynamic> map) {
    return new Preference(
      init: map['init'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'init': this.init,
    } as Map<String, dynamic>;
  }
}
