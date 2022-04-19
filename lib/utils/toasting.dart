import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasting {
  static void notifyToast(
      {required BuildContext context,
      required String message,
      gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        fontSize: 16.0);
  }
}
