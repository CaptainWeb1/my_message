
import 'package:flutter/material.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/widgets/icon_widget.dart';

class TextFieldWidget extends StatefulWidget {

  final TextFieldParameters textFieldParameters;

  TextFieldWidget({
    Key? key,
    required this.textFieldParameters,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

  late TextFieldParameters _textFieldParameters;

  @override
  void initState() {
    super.initState();
    _textFieldParameters = widget.textFieldParameters;
    if (_textFieldParameters is PasswordTextFieldParameters) {
      _textFieldParameters.iconTap = _revealObscureText;
    }
  }
  
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
        style: MyTextStyles.formPlaceHolder,
        decoration: InputDecoration(
          hintText: _textFieldParameters.hintText,
          hintStyle: _textFieldParameters.textStyle ?? MyTextStyles.formPlaceHolder,
          suffixIcon: GestureDetector(
            onTap: _textFieldParameters.iconTap,
            child: Padding(
              padding: const EdgeInsets.only(right: 23.0),
              child:
                (_textFieldParameters is PasswordTextFieldParameters)
                  ? (_textFieldParameters.obscureText)
                    ? IconWidget(icon: Icons.visibility)
                    : IconWidget(icon: Icons.visibility_off)
                  : _textFieldParameters.iconWidget
            ),
          ),
        ),
        obscureText: _textFieldParameters.obscureText,
        autocorrect: _textFieldParameters.autoCorrect,
      )
    );
  }

   void _revealObscureText() {
    setState(() {
      if (_textFieldParameters.obscureText) {
        _textFieldParameters.iconWidget = IconWidget(icon: Icons.visibility_off);
      } else {
        _textFieldParameters.iconWidget = IconWidget(icon: Icons.visibility);
      }
      _textFieldParameters.obscureText = !_textFieldParameters.obscureText;
    });
  }
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
      icon: Icons.visibility,
    ),
  }) : super(
      hintText: hintText,
      obscureText: true,
      autoCorrect: false,
      iconWidget: iconWidget
  );

}

class TextFieldParameters {

  final String? hintText;
  IconWidget? iconWidget;
  VoidCallback? iconTap;
  final TextStyle? textStyle;
  bool obscureText;
  final bool autoCorrect;

  TextFieldParameters({
    required this.hintText,
    this.iconWidget,
    this.iconTap,
    this.textStyle,
    this.obscureText = false,
    this.autoCorrect = true,
  });
  
}