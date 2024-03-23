import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String message, int seconds) {
  toastification.show(
    context: context,
    title: message,
    alignment: const Alignment(0.5, 0.9),
    showProgressBar: false,
    autoCloseDuration: Duration(seconds: seconds),
  );
}
