import 'package:flutter/material.dart';

abstract class Alerter {
  showErrorAlert(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  });

  showSuccessAlert(
    BuildContext context, {
    String title,
    @required String message,
    Duration duration = const Duration(seconds: 3),
  });
}
