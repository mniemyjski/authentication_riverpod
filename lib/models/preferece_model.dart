import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Preference extends Equatable {
  Preference({
    required this.darkMode,
    required this.localeApp,
  });

  final bool darkMode;
  final String localeApp;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [darkMode, localeApp];

  factory Preference.fromMap(Map<String, dynamic> map) {
    return new Preference(
      darkMode: map['darkMode'] as bool,
      localeApp: map['localeApp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'darkMode': this.darkMode,
      'localeApp': this.localeApp,
    } as Map<String, dynamic>;
  }

  Preference copyWith({
    bool? darkMode,
    String? localeApp,
  }) {
    if ((darkMode == null || identical(darkMode, this.darkMode)) && (localeApp == null || identical(localeApp, this.localeApp))) {
      return this;
    }

    return new Preference(
      darkMode: darkMode ?? this.darkMode,
      localeApp: localeApp ?? this.localeApp,
    );
  }
}
