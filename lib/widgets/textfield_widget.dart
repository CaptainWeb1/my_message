
import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';

class TextFieldWidget extends StatelessWidget {

  final String hintText;

  const TextFieldWidget({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: MyShapes.circularBorders,
        color: MyColors.containerColor,
      ),
      constraints: BoxConstraints(
          minHeight: MySizes.minimumHeightInputs
      ),
      child: TextField(
        decoration: InputDecoration(
            fillColor: MyColors.containerColor,
            hintText: hintText,
            hintStyle: MyTextStyles.buttonPlaceHolder,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            border: InputBorder.none
        ),
      ),
    );
  }
}