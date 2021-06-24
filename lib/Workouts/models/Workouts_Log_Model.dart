import 'package:flutter/foundation.dart';

class Workout_Log_Model {
  final String exerciseName;
  final String exerciseId;
  final int setNumber;
  final int numOfReps;
  final int weight;

  Workout_Log_Model({
    @required this.exerciseName,
    @required this.exerciseId,
    @required this.numOfReps,
    @required this.setNumber,
    @required this.weight,
  });
}
