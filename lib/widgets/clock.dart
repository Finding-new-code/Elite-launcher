import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String? timer_string;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) => getCurrentDate());
    timer_string =
        "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
    greetingMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(greetingMessage()),
        Text(getCurrentDate(),
            style: GoogleFonts.robotoFlex(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              color: Colors.white70,
            )),
      ],
    );
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm\nEEE d MMM').format(now);

    return formattedDate;
  }

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
}
