
import 'package:flutter/material.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/utils/app_config.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:my_message/widgets/button_widget.dart';
import 'package:my_message/widgets/checkbox_widget.dart';
import 'package:my_message/widgets/icon_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';
import 'package:my_message/utils/navigation_utils.dart';

class SignUpScreen extends StatefulWidget {

  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _name = "";
  String _birthDate = "";

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFieldWidget(
                        textFieldParameters: EmailTextFieldParameters(),
                        valueChanged: (value) {
                          _email = value;
                        },
                      ),
                      Spacer(),
                      TextFieldWidget(
                        textFieldParameters: PasswordTextFieldParameters(),
                        valueChanged: (value) {
                          _password = value;
                        },
                      ),
                      Spacer(),
                      TextFieldWidget(
                        textFieldParameters: NameTextFieldParameters(),
                        valueChanged: (value) {
                          _name = value;
                        },
                      ),
                      Spacer(),
                      TextFieldWidget(
                        textFieldParameters: TextFieldParameters(
                            hintText: Strings.dateSelect,
                            iconWidget: IconWidget(icon: Icons.calendar_today)
                        ),
                        valueChanged: (value) {
                          _birthDate = value;
                        },
                      ),
                      Spacer(),
                      ButtonWidget(
                        buttonText: Strings.signUp,
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            AuthenticationProvider().register(
                                email: _email,
                                password: _password,
                                context: context
                            );
                          } else {
                            NavigationUtils.showMyDialog(context: context, bodyText: "Erreur d'inscription");
                          }
                        }
                      ),
                    ],
                  ),
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
                    onPressed: () => Navigator.pushNamed(context, PAGE_SIGN_IN),
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