import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_message/providers/authentication_provider.dart';
import 'package:my_message/resources/strings.dart';
import 'package:my_message/resources/themes.dart';
import 'package:my_message/screens/messages_screen.dart';
import 'package:my_message/screens/sign_in_screen.dart';
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
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (initFirebaseContext, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          showDialog(
              context: initFirebaseContext,
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
              StreamProvider<User?>(
                create: (_) => AuthenticationProvider().userState,
                initialData: null,
                catchError: (_, error) => null,
              ),
            ],
            builder: (providerContext, widget) {
              User? _user = Provider.of<User?>(providerContext);
              return MaterialApp(
                title: 'My Message',
                theme: theme,
                onGenerateRoute: RouteGenerator.generateRoute,
                home: _user == null
                      ? SignInScreen()
                      : MessagesScreen(),
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