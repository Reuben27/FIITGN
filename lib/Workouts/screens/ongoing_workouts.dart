import 'package:fiitgn/Workouts/models/WorkoutModel.dart';

import '../models/Workout_provider.dart';
import 'package:flutter/material.dart';
import './workout_logging.dart';
import '../models/Exercise_db_model.dart';
import 'package:provider/provider.dart';
import '../../Notifications/utils/removeNotification.dart';
import '../../Providers/DataProvider.dart';

class Ongoing_Workouts extends StatefulWidget {
  static const routeName = '\Ongoing_workouts';

  @override
  _Ongoing_WorkoutsState createState() => _Ongoing_WorkoutsState();
}

class _Ongoing_WorkoutsState extends State<Ongoing_Workouts> {
  start_workout(WorkoutModel workout) {
    final exercise_provier =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context);
    String workoutName = workout.workoutName;
    List<ExerciseDbModel> exercises =
        exercise_provier.exercisesBasesOnId(workout.listOfExercisesId);
    Map<String, dynamic> map = Map();
    map['workoutName'] = workoutName;
    map['exercises'] = exercises;
    Navigator.pushReplacementNamed(context, Workout_Logging.routeName,
        arguments: map);
  }

  @override
  Widget build(BuildContext context) {
    final workouts_provider = Provider.of<Workouts_Provider>(context);
    final data_provider = Provider.of<Data_Provider>(context, listen: false);
    final List<WorkoutModel> ongoingWorkouts =
        workouts_provider.ongoingWorkouts();
    print(ongoingWorkouts);
    print("zzzzzzzzzzzzzzzzzzzzzzz");
    return Scaffold(
        body: ongoingWorkouts.length == 0
            ? Center(
                child: Text('No current workouts'),
              )
            : ListView.builder(
                itemCount: ongoingWorkouts.length,
                itemBuilder: (ctx, i) {
                  return Container(
                      child: Column(
                    children: [
                      Text(ongoingWorkouts[i].workoutName),
                      RaisedButton(
                        child: Text('Start Workout'),
                        onPressed: () {
                          start_workout(ongoingWorkouts[i]);
                        },
                      ),
                      RaisedButton(
                        child: Text('Remove Workout'),
                        onPressed: () {
                          workouts_provider.removeWorkoutFromOngoingDB(
                              ongoingWorkouts[i], ongoingWorkouts[i].workoutId);
                          print("removed workout from ongoing succesfully");
                          ///// removing the notification for the workout
                          String token = data_provider.notif_token;
                          notiRemove(token, ongoingWorkouts[i].workoutName);
                        },
                      ),
                    ],
                  ));
                }));
  }
}
