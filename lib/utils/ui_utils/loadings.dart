import 'package:flutter/material.dart';

class LoaderDialog {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 20.0),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); // Pop the loading dialog
  }

  static void showError(BuildContext context, [String error = '']) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text((error.isEmpty) ? 'An error occurred.' : error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the error dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
