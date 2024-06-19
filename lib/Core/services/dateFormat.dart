import 'package:intl/intl.dart';

class MyDatetimeUtilities {
  static String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(dateTime);
  }
  static String formatDateTime(String timestamp) {
    DateTime parsedDate = DateTime.parse(timestamp);
    return "${parsedDate.hour}:${parsedDate.minute}  ${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
  }

}
