import 'package:intl/intl.dart';

class FormatDates {
  static String dateFormatShortMonthDayYear(String date) {
    return DateFormat.yMMMd().format(DateTime.parse(date));
  }

  static String dateFormatDayNumber(String date) {
    return DateFormat.d().format(DateTime.parse(date));
  }

  static String dateFormatShortDayName(String date) {
    return DateFormat.E().format(DateTime.parse(date));
  }
}
