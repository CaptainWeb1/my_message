
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_message/screens/messages_screen.dart';
import 'package:my_message/screens/room_screen.dart';
import 'package:my_message/screens/search_screen.dart';
import 'package:my_message/screens/sign_in_screen.dart';
import 'package:my_message/screens/sign_up_screen.dart';
import 'package:my_message/screens/unknown_screen.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final _arguments = settings.arguments;
    switch(settings.name) {
      case PAGE_SIGN_IN : return MaterialPageRoute(builder: (_) => SignInScreen());
      case PAGE_SIGN_UP : return MaterialPageRoute(builder: (_) => SignUpScreen());
      case PAGE_MESSAGES : return MaterialPageRoute(builder: (_) => MessagesScreen());
      case PAGE_ROOM : return MaterialPageRoute(builder: (_) => RoomScreen(peerUserArgument: _arguments));
      case PAGE_SEARCH : return MaterialPageRoute(builder: (_) => SearchScreen());
      default: return MaterialPageRoute(builder: (_) => UnknownScreen());
    }
  }

}

const String PAGE_SIGN_IN = "/SignIn";
const String PAGE_SIGN_UP = "/SignUp";
const String PAGE_MESSAGES = "/Messages";
const String PAGE_ROOM = "/Room";
const String PAGE_SEARCH = "/Search";