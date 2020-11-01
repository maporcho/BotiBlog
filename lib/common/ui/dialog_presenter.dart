import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

abstract class DialogPresenter {
  showWarningDialog(
    BuildContext context, {
    String title,
    String description,
    String okButtonText,
    String cancelButtonText,
    VoidCallback onConfirm,
  });

  showSuccessDialog(
    BuildContext context, {
    String title,
    String description,
    String okButtonText,
    VoidCallback onConfirm,
  });
}
