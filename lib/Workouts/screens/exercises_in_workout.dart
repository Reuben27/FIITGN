// import 'package:Fiitgn1/Workouts/models/Exercise_db_model.dart';
import 'package:flutter/material.dart';
import '../models/Exercise_db_model.dart';

class Exercises_in_Workout extends StatelessWidget {
  static const routeName = '\Exercises_in_workout';

  @override
  Widget build(BuildContext context) {
    final List<ExerciseDbModel> exercises =
        ModalRoute.of(context).settings.arguments as List<ExerciseDbModel>;
    return Scaffold(
      body: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (_, i) {
            return ListTile(
              title: Text(exercises[i].exerciseName),
            );
          }),
    );
  }
}
