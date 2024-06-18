import 'package:intl/intl.dart';

class MyDatetimeUtilities {
  static String formatDate(DateTime dateTime) {
    DateFormat formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(dateTime);
  }
}
