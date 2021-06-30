import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/screens/messages_screen.dart';
import 'package:my_message/screens/sign_in_screen.dart';
import 'package:my_message/utils/navigation_utils.dart';
import 'package:my_message/utils/route_generator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (initFirebaseContext, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          showDialog(
              context: initFirebaseContext,
              builder: (_) {
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
              ChangeNotifierProvider(create: (contextProvider) => AuthenticationProvider())
            ],
            builder: (providerContext, widget) {
              return MaterialApp(
                title: 'My Message',
                theme: theme,
                onGenerateRoute: RouteGenerator.generateRoute,
                home: StreamBuilder(
                  stream: AuthenticationProvider().listenUserStateChange(),
                  builder: (authStreamContext, snapshot) {
                    if (snapshot.hasError) {
                      NavigationUtils.showMyDialog(context: context, bodyText: snapshot.error.toString());
                      return SignInScreen();
                    } else {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        if(snapshot.data != null) {
                          return MessagesScreen();
                        } else {
                          return SignInScreen();
                        }
                      }
                    }
                  },
                ),
                debugShowCheckedModeBanner: false,
              );
            },
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );

  }
}