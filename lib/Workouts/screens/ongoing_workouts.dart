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
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);
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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueGrey[300],
            title: Text(
              'Ongoing Workouts',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Gilroy'),
            ),
          ),
          body: ongoingWorkouts.length == 0
              ? Center(
                  child: Text('No current workouts'),
                )
              : ListView.builder(
                  itemCount: ongoingWorkouts.length,
                  itemBuilder: (ctx, i) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[200],
                          borderRadius: BorderRadius.circular(20)),
                     // margin: EdgeInsets.only(top:10,bottom:10,left: 10, right: 15),
                     margin: EdgeInsets.only(top:10,bottom:10,left: 10, right: 10),
                      child: Container(
                        margin: EdgeInsets.only(top:20,bottom:20,left: 10, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ongoingWorkouts[i].workoutName.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "by " + ongoingWorkouts[i].creator_name,
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      start_workout(ongoingWorkouts[i]);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Begin",
                                          style: TextStyle(
                                              fontFamily: 'Gilroy', fontSize: 20,color: Colors.black),
                                        ),
                                        Icon(Icons.fitness_center,color: Colors.black,)
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      workouts_provider
                                          .removeWorkoutFromOngoingDB(
                                              ongoingWorkouts[i],
                                              ongoingWorkouts[i].workoutId);
                                      print(
                                          "removed workout from ongoing succesfully");
                                      ///// removing the notification for the workout
                                      String token = data_provider.notif_token;
                                      notiRemove(
                                          token, ongoingWorkouts[i].workoutName);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Remove",
                                          style: TextStyle(color: Colors.black,
                                              fontFamily: 'Gilroy', fontSize: 20),
                                        ),
                                        Icon(Icons.delete_outline,color: Colors.black,)
                                      ],
                                    ),
                                  ),
                                ),
                                // RaisedButton(
                                //   child: Text('Start Workout'),
                                //   onPressed: () {
                                //     start_workout(ongoingWorkouts[i]);
                                //   },
                                // ),
                                // RaisedButton(
                                //   child: Text('Remove Workout'),
                                //   onPressed: () {
                                //     workouts_provider.removeWorkoutFromOngoingDB(
                                //         ongoingWorkouts[i],
                                //         ongoingWorkouts[i].workoutId);
                                //     print(
                                //         "removed workout from ongoing succesfully");
                                //     ///// removing the notification for the workout
                                //     String token = data_provider.notif_token;
                                //     notiRemove(
                                //         token, ongoingWorkouts[i].workoutName);
                                //   },
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
