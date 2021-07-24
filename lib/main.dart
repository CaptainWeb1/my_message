import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/screens/sign_in_screen.dart';
import 'package:my_message/utils/route_generator.dart';

import 'resources/strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (initFirebaseContext, snapshot) {
        if(snapshot.hasError) {
          showDialog(
              context: initFirebaseContext,
              builder: (_) {
                return Dialog(
                  child: Text(Strings.errorFirebaseInit),
                );
              }
          );
        }

        if(snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'My Message',
            theme: theme,
            initialRoute: PAGE_SIGN_IN,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: SignInScreen(),
            debugShowCheckedModeBanner: false,
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}