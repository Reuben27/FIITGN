import 'package:flutter/material.dart';
import 'schedueCalendar.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = '\calendarScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () async {
          await CalendarSchedule().reloadEvents();
          print("code ran");
        },
        child: Center(
          child: Text("Click to create event"),
        ),
      ),
    );
  }
}
