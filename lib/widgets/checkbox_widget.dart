
import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: false,
        onChanged: (value) {
          //changer selon checkbox
        },
        shape: RoundedRectangleBorder(
            borderRadius: MyShapes.checkboxBorders
        )
    );
  }
}