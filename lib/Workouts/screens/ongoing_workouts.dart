import 'package:flutter/material.dart';
import './workout_logging.dart';
import '../models/Exercise_db_model.dart';
import 'package:provider/provider.dart';

class Ongoing_Workouts extends StatelessWidget {
  static const routeName = '\Ongoing_workouts';
  @override
  Widget build(BuildContext context) {
    final exercise_provier =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context);
    return Scaffold(
      body: InkWell(
        onTap: () {
          Map<String, dynamic> map = Map();
          map['workoutName'] = 'Fake Workout';
          List<ExerciseDbModel> exercises =
              exercise_provier.exercisesBasesOnId(['1', '2', '3', '4']);
          map['exercises'] = exercises;
          Navigator.pushNamed(context, Workout_Logging.routeName,
              arguments: map);
        },
        child: Center(
          child: Text('OnGoing Workouts'),
        ),
      ),
    );
  }
}
