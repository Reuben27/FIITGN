import 'package:fiitgn/Workouts/models/Workout_Data_Log_Model.dart';
import 'package:flutter/material.dart';

class WorkoutsHistory3 extends StatefulWidget {
  static const routeName = 'workoutHistory3';

  @override
  _WorkoutsHistory3State createState() => _WorkoutsHistory3State();
}

class _WorkoutsHistory3State extends State<WorkoutsHistory3> {
  @override
  Widget build(BuildContext context) {
    final List<Workout_Data_Model> args =
        ModalRoute.of(context).settings.arguments as List<Workout_Data_Model>;
    return Scaffold();
  }
}
