
import 'package:flutter/material.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/utils/app_config.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:my_message/widgets/button_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AppConfig.heightScreen(context),
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 39),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(ImagesPaths.logoPath),
                )
              ),
              Expanded(
                child: Text(
                  Strings.titleApp,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldWidget(hintText: Strings.email,),
                    TextFieldWidget(hintText: Strings.password,),
                    ButtonWidget(buttonText: Strings.signIn, onPressed: () => Navigator.pushNamed(context, PAGE_MESSAGES),),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.noAccount
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, PAGE_SIGN_UP),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero
                    ),
                    child: Text(
                      " " + Strings.signUp,
                      style: MyTextStyles.bodyLink,
                    ),
                  ),
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: () => print("rien"),
                child: Text(
                  Strings.forgetPassword,
                  style: MyTextStyles.bodyLink,
                ),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

