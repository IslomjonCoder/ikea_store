import 'package:flutter/material.dart';
import 'package:ikea_store/main.dart';

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        alignment: Alignment.center,
        child: const SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
}
