
import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            children: [
              Text(
                "Bonsoir",
                style: MyTextStyles.body,
              ),
              Text(
                "Bonsoir",
                style: MyTextStyles.title1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
