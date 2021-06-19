
import 'package:flutter/material.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/widgets/icon_widget.dart';

class TextFieldWidget extends StatelessWidget {

  final TextFieldParameters textFieldParameters;

  TextFieldWidget({
    Key? key,
    required this.textFieldParameters,
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
        textAlignVertical: TextAlignVertical.center,
        decoration: _createInputDecoration(textFieldParameters: textFieldParameters),
      )
    );
  }
}

InputDecoration _createInputDecoration({required TextFieldParameters textFieldParameters}) {
  return InputDecoration(
    hintText: textFieldParameters.hintText,
    hintStyle: textFieldParameters.textStyle ?? MyTextStyles.buttonPlaceHolder,
    suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 23.0),
        child: textFieldParameters.iconData
    ),
  );
}

class EmailTextFieldParameters extends TextFieldParameters {

  final String? hintText;

  EmailTextFieldParameters({
    this.hintText = Strings.email
  }) : super(hintText: hintText);

}

class PasswordTextFieldParameters extends TextFieldParameters {

  final String? hintText;
  final IconWidget? iconWidget;

  PasswordTextFieldParameters({
    this.hintText = Strings.password,
    this.iconWidget = const IconWidget(
      icon: Icons.remove_red_eye_sharp,
    ),
  }) : super(
      hintText: hintText,
      obscureText: true,
      autoCorrect: false
  );

}

class TextFieldParameters {

  final String? hintText;
  final IconWidget? iconData;
  final TextStyle? textStyle;
  final bool obscureText;
  final bool autoCorrect;

  TextFieldParameters({
    required this.hintText,
    this.iconData,
    this.textStyle,
    this.obscureText = false,
    this.autoCorrect = true,
  });
  
}