
import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/widgets/icon_widget.dart';

class TextFieldWidget extends StatelessWidget {

  final String hintText;
  final IconWidget? iconData;
  final TextStyle textStyle;

  TextFieldWidget({
    Key? key,
    required this.hintText,
    this.iconData,
    TextStyle? textStyle,
  }) :  this.textStyle = textStyle ?? MyTextStyles.buttonPlaceHolder,
        super(key: key);

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
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            fillColor: MyColors.containerColor,
            hintText: hintText,
            hintStyle: textStyle,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 23.0),
              child: iconData,
            ),
        ),
      ),
    );
  }
}
