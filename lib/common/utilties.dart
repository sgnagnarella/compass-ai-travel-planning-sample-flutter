import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

// Date Formatters

final DateFormat dateFormatter = DateFormat('MMMM dd, yyyy');
final DateFormat shortenedDateFormatter = DateFormat('MMM dd, yyyy');
final DateFormat datesWithSlash = DateFormat('MM/dd/yyyy');

String prettyDate(String dateStr) {
  return dateFormatter.format(DateTime.parse(dateStr));
}

String shortenedDate(String dateStr) {
  return shortenedDateFormatter.format(DateTime.parse(dateStr));
}

// App Behaviors

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}