import 'package:intl/intl.dart';

class DateUtility {
  DateUtility._();
  static final DateFormat ddMMyyyyFormatter = DateFormat('dd-MM-yyyy');
  static final DateFormat EEEEMMMyyyyFormatter = DateFormat('EEEE MMM yyyy');

  static DateTime now() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime relevantNow() {
    var now = DateTime.now();
    var relevantNow = DateTime(now.year, now.month, now.day);
    if (now.hour < 15) return relevantNow.subtract(const Duration(days: 1));
    return relevantNow;
  }

  static String toddMMyyyy(DateTime date) {
    return ddMMyyyyFormatter.format(date);
  }

  static String toEEEEMMMyyyy(DateTime date) {
    return EEEEMMMyyyyFormatter.format(date);
  }

  static Iterable<DateTime> daysOfMonth(DateTime monthAsDateTime) sync* {
    var counter = DateTime(monthAsDateTime.year, monthAsDateTime.month);
    var month = monthAsDateTime.month;
    do {
      yield counter;
      counter = DateTime(counter.year, counter.month, counter.day + 1);
    } while (counter.month == month);
    return;
  }
}
