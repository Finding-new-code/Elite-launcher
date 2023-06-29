import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 11.59) {
    return 'Good Morning,';
  } else if (timeNow > 12 && timeNow <= 16) {
    return 'Good Afternoon,';
  } else if (timeNow > 16 && timeNow < 20) {
    return 'Good Evening,';
  } else {
    return 'Good Night,';
  }
}


