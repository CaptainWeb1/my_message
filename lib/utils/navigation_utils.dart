
import 'package:flutter/material.dart';
import 'package:my_message/resources/strings.dart';

class NavigationUtils {

  static void showMyDialog({
    required BuildContext context,
    required String bodyText,
    VoidCallback? onClick
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(bodyText),
          actions: [
           Center(
             child: ElevatedButton(
                 onPressed: onClick ?? () => Navigator.of(context).pop(),
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

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }

  static void hideDialog(BuildContext context) {
    if(Navigator.of(context).canPop()){
      Navigator.of(context).pop();
    }
  }

}