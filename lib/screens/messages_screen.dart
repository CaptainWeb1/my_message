import 'package:flutter/material.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/widgets/icon_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(flex: 2,),
          Text(
            Strings.titleApp,
            style: Theme.of(context).textTheme.headline1,
          ),
          TextFieldWidget(
            hintText: Strings.search,
            iconData: IconWidget(
            icon: Icons.search,
          ),
          )
        ],
      ),
    );
  }
}
