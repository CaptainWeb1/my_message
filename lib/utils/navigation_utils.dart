
import 'package:flutter/material.dart';
import 'package:my_message/resources/strings.dart';

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
           Center(
             child: ElevatedButton(
                 onPressed: () => Navigator.of(context).pop(),
                 child: Text(
                     Strings.ok,
                    textAlign: TextAlign.center,
                 )
             ),
           )
          ],
        );
      }
    );
  }

  static void openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: CircularProgressIndicator(),
        );
      },
    );
  }

}