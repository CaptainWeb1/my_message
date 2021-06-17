import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/providers/authentication_state.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/screens/messages_screen.dart';
import 'package:my_message/screens/sign_in_screen.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          showDialog(
              context: context,
              builder: (_){
                return Dialog(
                  child: Text(Strings.errorFirebaseInit),
                );
              }
            );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
            ],
            child: MaterialApp(
              title: 'My Message',
              theme: theme,
              initialRoute: PAGE_SIGN_IN,
              onGenerateRoute: RouteGenerator.generateRoute,
              home: Consumer<AuthenticationState?>(
                builder: (context, data, child) {
                  if (data is SignedInState) {
                    return MessagesScreen();
                  } else if (data is SignedOutState || data is InitAuthState) {
                    return SignInScreen();
                  } else if (data is ErrorAuthState) {
                    return Center(child: Text(data.message));
                  } else {// loading state
                    return const CircularProgressIndicator();
                  }
                },
              ),
              debugShowCheckedModeBanner: false,
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );

  }
}