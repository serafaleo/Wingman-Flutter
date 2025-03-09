import 'package:flutter/material.dart';
import 'package:wingman/core/utils/extension_methods/show_snackbar.dart';

final class Failure {
  final String message;
  Failure([this.message = 'An unexpected error occured.']);

  void show(BuildContext context) {
    showSnackBar(context, message, Colors.red);
  }
}
