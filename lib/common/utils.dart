

/// Преобразует значение `timestamp` в `DateTime`
DateTime fromTimestamp(num time){
   return DateTime.fromMicrosecondsSinceEpoch(time, isUtc: true);
}

/// Преобразует значение `DateTime` в `timestamp`
int toTimestamp(DateTime date) {
  return date.millisecondsSinceEpoch;
}