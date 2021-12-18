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

  @override
  Widget build(BuildContext context) {
    final Map<int, List<Workout_Data_Model>> args = ModalRoute.of(context)
        .settings
        .arguments as Map<int, List<Workout_Data_Model>>;
    List<String> days = getDays(args);
    return Scaffold(
      appBar: AppBar(
        title: Text('History 2'),
      ),
      body: ListView.builder(
          itemCount: days.length,
          itemBuilder: (ctx, i) {
            return InkWell(
                onTap: () {
                  List<Workout_Data_Model> toPass = args[i];
                  Navigator.pushNamed(context, WorkoutsHistory3.routeName,
                      arguments: toPass);
                },
                child: Text(days[i]));
          }),
    );
  }
}
