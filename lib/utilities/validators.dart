import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Validators {
  static email(String? v) {
    if (v == null || v.isEmpty) {
      return "* Required";
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v)) {
      return 'Wrong email';
    }
    return null;
  }

  static password(String? v) {
    if (v == null || v.isEmpty) {
      return "* Required";
    } else if (v.length < 6) {
      return "Password should be at least 6 characters";
    } else if (v.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  static name(BuildContext context, String? name) {
    if (name == null || name.isEmpty) {
      return "* Required";
    }
    return null;
  }
}
