import 'package:flutter/foundation.dart';
import 'Workout_Data_Log_Model.dart';
import 'Workouts_Log_Model.dart';

class Passer3_4 {
  final List<Workout_Log_Model> listOfSetsReps;
  final String duration_hours;
  final String duration_minutes;
  final String duration_seconds;

  Passer3_4({
    @required this.listOfSetsReps,
    @required this.duration_hours,
    @required this.duration_minutes,
    @required this.duration_seconds,
  });
}
