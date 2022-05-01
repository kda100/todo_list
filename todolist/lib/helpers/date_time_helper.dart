import 'package:intl/intl.dart';

///class containing functions used on the date time object.

class DateTimeHelper {
  ///gets current day.
  static DateTime today() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// changes "Sat 30 Apr 2022" format -> DateTime Object.
  static DateTime? formatStringToDateTime(String? dateTime) {
    if (dateTime != null && dateTime.isNotEmpty) {
      DateFormat format = DateFormat("EE dd MMM yyyy");
      return format.parse(dateTime);
    }
    return null;
  }

  /// changes DateTime Object to "Sat 30 Apr 2022" format.
  static String formatDateTimeToString(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat("EE dd MMM yyyy").format(dateTime);
    }
    return "";
  }
}
