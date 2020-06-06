
import 'package:intl/intl.dart';

/// Преобразует значение `timestamp` в `DateTime`
DateTime fromTimestamp(num time){
   return DateTime.fromMillisecondsSinceEpoch(time, isUtc: true);
}

/// Преобразует значение `DateTime` в `timestamp`
int toTimestamp(DateTime date, {bool formatted: false}) {
  return date.millisecondsSinceEpoch;
}

/// Преобразует дату `date` в текст.
String formatDate(DateTime date, [String format = 'yyyy.MM.dd']) {
  return DateFormat(format).format(date);
}