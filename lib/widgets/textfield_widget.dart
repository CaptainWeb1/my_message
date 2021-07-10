
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            fillColor: MyColors.containerColor,
            hintText: _textFieldParameters.hintText,
            hintStyle: _textFieldParameters.textStyle,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 23.0),
              child: _textFieldParameters.iconWidget,
            ),
        ),
        obscureText: _textFieldParameters.obscureText,
        autocorrect: _textFieldParameters.autoCorrect,
        inputFormatters: _textFieldParameters.textInputFormatters,
      ),
    );
  }
}

class NameTextFieldParameters extends TextFieldParameters {
  final String? hintText;

  NameTextFieldParameters({
    this.hintText = Strings.name
  }) : super(
    hintText: hintText,
    textInputFormatters: [
      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9]"))
    ],
    keyboardType: TextInputType.name
  );
}

class EmailTextFieldParameters extends TextFieldParameters {
  final String? hintText;

  EmailTextFieldParameters({
    this.hintText = Strings.email
  }) : super(
    hintText: hintText,
    keyboardType: TextInputType.emailAddress
  );
}

class PasswordTextFieldParameters extends TextFieldParameters {
  final String? hintText;
  final IconWidget? iconWidget;

  PasswordTextFieldParameters({
    this.hintText = Strings.password,
    this.iconWidget = const IconWidget(
        icon: Icons.visibility
    )
  }) : super(
    hintText: hintText,
    obscureText: true,
    autoCorrect: false,
    iconWidget: iconWidget
  );
}

class SearchTextFieldParameters extends TextFieldParameters {

  final String? hintText;
  final IconWidget? iconWidget;

  SearchTextFieldParameters({
    this.hintText,
    this.iconWidget = const IconWidget(
        icon: Icons.search
    )
  }) : super(
    hintText: hintText,
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
    this.keyboardType
  });
}
