import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackError({String? title, required String message}) {
  Get.snackbar(
    title ?? 'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: Colors.red,
  );
}

void snackSuceed({String? title, required String message}) {
  Get.snackbar(
    title ?? 'Success',
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: Colors.blue,
  );
}
