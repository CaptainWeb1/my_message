
import 'package:flutter/material.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/utils/app_config.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:my_message/widgets/button_widget.dart';
import 'package:my_message/widgets/textfield_widget.dart';

class SignInScreen extends StatefulWidget {


  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

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
                      TextFieldWidget(
                        textFieldParameters: PasswordTextFieldParameters(),
                        valueChanged: (value) {
                          _password = value;
                        },
                      ),
                      ButtonWidget(
                        buttonText: Strings.signIn,
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            AuthenticationProvider().signIn(
                                email: _email,
                                password: _password,
                                context: context
                            );
                          } else {
                            NavigationUtils.showMyDialog(context: context, bodyText: "Erreur d'authentification");
                          }
                      },),
                    ],
                  ),
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

