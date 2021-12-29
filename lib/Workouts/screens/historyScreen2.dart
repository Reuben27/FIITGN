import 'package:fiitgn/Workouts/models/Workout_Data_Log_Model.dart';
import 'package:fiitgn/Workouts/screens/historyScreen3.dart';
import 'package:flutter/material.dart';

class WorkoutHistory2 extends StatefulWidget {
  static const routeName = 'workoutHistory2';

  @override
  _WorkoutHistory2State createState() => _WorkoutHistory2State();
}

class _WorkoutHistory2State extends State<WorkoutHistory2> {
  List<String> getDays(Map<int, List<Workout_Data_Model>> args) {
    List<String> days = [];
    for (int dayNum in args.keys) {
      if (dayNum == 0) {
        days.add('Monday');
      } else if (dayNum == 1) {
        days.add('Tuesday');
      } else if (dayNum == 2) {
        days.add('Wednesday');
      } else if (dayNum == 3) {
        days.add('Thursday');
      } else if (dayNum == 4) {
        days.add('Friday');
      } else if (dayNum == 5) {
        days.add('Saturday');
      } else if (dayNum == 6) {
        days.add('Sunday');
      }
    }
    return days;
  }

  int getNumDay(String day) {
    if (day == 'Monday') {
      return 0;
    } else if (day == 'Tuesday') {
      return 1;
    } else if (day == 'Wednesday') {
      return 2;
    } else if (day == 'Thursday') {
      return 3;
    } else if (day == 'Friday') {
      return 4;
    } else if (day == 'Saturday') {
      return 5;
    } else if (day == 'Sunday') {
      return 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    final MediaQueryData data = MediaQuery.of(context);
    final Map<int, List<Workout_Data_Model>> args = ModalRoute.of(context)
        .settings
        .arguments as Map<int, List<Workout_Data_Model>>;
    List<String> days = getDays(args);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF93B5C6),
          title: Text(
            'DAYS IN PLAN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: ListView.builder(
            itemCount: days.length,
            itemBuilder: (ctx, i) {
              return Container(
                width: _screenWidth,
                height: _screenHeight / 7,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 0.00625 * _screenHeight,
                    bottom: 0.00625 * _screenHeight,
                    left: 0.03 * _screenWidth,
                    right: 0.03 * _screenWidth,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC9CCD5),
                      borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          int day = getNumDay(days[i]);
                          List<Workout_Data_Model> toPass = args[day];
                          print("args is");
                          print(args[day]);
                          Navigator.pushNamed(
                              context, WorkoutsHistory3.routeName,
                              arguments: toPass);
                        },
                        child: Text(
                          days[i].toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 0.04 * _screenHeight,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
