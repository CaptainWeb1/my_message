
import 'package:flutter/material.dart';

class NavigationUtils {

  static void showMyDialog({
    required BuildContext context,
    required String bodyText
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(bodyText),
          actions: [
           // ElevatedButton(onPressed: print(), child: child)
          ],
        );
      }
    );
  }

}