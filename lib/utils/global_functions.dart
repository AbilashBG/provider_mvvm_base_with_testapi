import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mvvmbasic/utils/style.dart';

class GlobalFunctions {
  static SnackbarController showGetToast(String msg, bool isSuccess) {
    return Get.snackbar(
      "",
      msg,
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    );
  }

  static showToast(String msg, bool issuccess) {
    showGetToast(msg, issuccess);
    return;
    return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: issuccess ? primaryColor : dangerColor,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static showDialogLocal(Widget child) {
    Get.dialog(child);
  }
}
