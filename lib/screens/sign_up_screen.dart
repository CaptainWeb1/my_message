
import 'package:flutter/material.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/utils/app_config.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:my_message/widgets/button_widget.dart';
import 'package:my_message/widgets/checkbox_widget.dart';
import 'package:my_message/widgets/icon_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen() : super();

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
              Spacer(flex: 2,),
              Text(
                Strings.signUpTitle,
                style: Theme.of(context).textTheme.headline1,
              ),
              Spacer(),
              Expanded(
                flex: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFieldWidget(hintText: Strings.email,),
                    Spacer(),
                    TextFieldWidget(hintText: Strings.password,),
                    Spacer(),
                    TextFieldWidget(hintText: Strings.name,),
                    Spacer(),
                    TextFieldWidget(hintText: Strings.dateSelect, iconData: IconWidget(icon: Icons.calendar_today)),
                    Spacer(),
                    ButtonWidget(buttonText: Strings.signUp,),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CheckboxWidget(),
                  Text(
                      Strings.acceptConditions,
                      style: TextStyle(
                        fontSize: 13
                      ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      Strings.alreadyAccount,
                      style: TextStyle(
                          fontSize: 16
                      ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, PAGE_SIGN_UP),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero
                    ),
                    child: Text(
                      " " + Strings.signIn,
                      style: MyTextStyles.bodyLink.copyWith(
                        fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}