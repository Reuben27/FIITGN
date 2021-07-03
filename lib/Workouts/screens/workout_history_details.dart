import 'package:flutter/material.dart';
import './workouts_history.dart';
import '../models/Workouts_Log_Model.dart';

class Workout_History_Details extends StatelessWidget {
  static const routeName = '/workout_details';
  // const Workout_History_Details({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Workout_Log_Model> workout_details =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(workout_details[0].exerciseName),
          ),
          Center(
            child: Text(workout_details[0].setNumber.toString()),
          ),
          Center(
            child: Text(workout_details[0].numOfReps.toString()),
          ),
        ],
      ),
    );
  }
}
