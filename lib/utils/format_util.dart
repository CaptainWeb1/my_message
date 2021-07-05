
import 'package:intl/intl.dart';

class FormatUtil {}

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