
import 'package:intl/intl.dart';

class FormatUtils {}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension DateToString on DateTime {
  String parseDateToString() {
    return DateFormat("dd/MM/yy - HH:mm").format(this);
  }
}

extension StringToDate on String {
  DateTime parseStringToDate() {
   String _date = this;
   DateFormat _format = DateFormat("EEE MMM dd HH:mm:ss yyyy");
   return _format.parse(_date);
  }
}