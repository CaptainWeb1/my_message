
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/widgets/icon_widget.dart';

class TextFieldWidget extends StatefulWidget {

  final TextFieldParameters textFieldParameters;
  final ValueChanged<String> valueChanged;

  TextFieldWidget({
    Key? key,
    required this.textFieldParameters,
    required this.valueChanged,
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
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      style: MyTextStyles.formPlaceHolder.copyWith(
        color: Theme.of(context).primaryColor
      ),
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
      inputFormatters: _textFieldParameters.textInputFormatters,
      onFieldSubmitted: (String? value) {
        _validateForm(value ?? "");
      },
      validator: (String? value) {
        return _validateForm(value ?? "");
      },
    );
  }

   void _revealObscureText() {
    setState(() {
      _textFieldParameters.obscureText = !_textFieldParameters.obscureText;
    });
  }

  _validateForm(String value) {
    if(value == "" || value.replaceAll(" ", "") == "" ) {
      return Strings.errorEmptyField;
    } else {
      if (_textFieldParameters is PasswordTextFieldParameters && value.length < 8) {
        return Strings.errorPasswordLength;
      }
    }
    widget.valueChanged(value);
    return null;
  }
}

class NameTextFieldParameters extends TextFieldParameters {

  final String? hintText;

  NameTextFieldParameters({
    this.hintText = Strings.name,
  }) : super(
    hintText: hintText,
    textInputFormatters: [
      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9]"))
    ],
    keyboardType: TextInputType.name,
  );


}

class EmailTextFieldParameters extends TextFieldParameters {

  final String? hintText;

  EmailTextFieldParameters({
    this.hintText = Strings.email
  }) : super(
    hintText: hintText,
    keyboardType: TextInputType.emailAddress,
  );

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
      iconWidget: iconWidget,
  );

}

class TextFieldParameters {

  final String? hintText;
  IconWidget? iconWidget;
  VoidCallback? iconTap;
  final TextStyle? textStyle;
  bool obscureText;
  final bool autoCorrect;
  List<TextInputFormatter>? textInputFormatters;
  TextInputType? keyboardType;

  TextFieldParameters({
    required this.hintText,
    this.iconWidget,
    this.iconTap,
    this.textStyle,
    this.obscureText = false,
    this.autoCorrect = true,
    this.textInputFormatters,
    this.keyboardType,
  });

  
}
