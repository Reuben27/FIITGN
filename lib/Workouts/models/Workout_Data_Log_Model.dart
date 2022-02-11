import 'package:flutter/foundation.dart';
import 'Workouts_Log_Model.dart';
// import 'WorkoutLogModel.dart';

class Workout_Data_Model {
  final String planName;
  final int planDay; // 0 for monday , 1 for tuesday, etc.
  String databaseId = "";
  final String planId;
  final String uid;
  final String user_name;
  final String date;
  final List<Workout_Log_Model> listOfSetsRepsWeights;
  final String workoutName;
  final String duration_hours;
  final String duration_minutes;
  final String duration_seconds;

  Workout_Data_Model({
    @required this.planName,
    @required this.planDay,
    @required this.planId,
    @required this.duration_seconds,
    @required this.duration_hours,
    @required this.duration_minutes,
    @required this.databaseId,
    @required this.uid,
    @required this.user_name,
    @required this.workoutName,
    @required this.date,
    @required this.listOfSetsRepsWeights,
  });
}
