
import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';

class IconWidget extends StatelessWidget {

  final IconData icon;

  const IconWidget({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 33,
      color: MyColors.iconColors,
    );
  }
}