import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/screens/sign_in_screen.dart';
import 'package:my_message/utils/route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Message',
      theme: theme,
      initialRoute: PAGE_SIGN_IN,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}