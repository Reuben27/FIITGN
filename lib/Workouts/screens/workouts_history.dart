import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Workout_provider.dart';
import '../models/Workout_Data_Log_Model.dart';
import 'package:intl/intl.dart';
import './workout_history_details.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  static const routeName = 'workout_history';

  @override
  _WorkoutHistoryScreenState createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  List<Workout_Data_Model> workout_histories = List.empty(growable: true);

  @override
  void initState() {
    final workouts_provider =
        Provider.of<Workouts_Provider>(context, listen: false);
    workout_histories = workouts_provider.loggedWorkouts;
    print('##');
    print(workout_histories[0].workoutName);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: workout_histories.length,
            itemBuilder: (ctx, i) {
              String formattedDate = DateFormat('yyyy-MM-dd – kk:mm')
                  .format(DateTime.parse(workout_histories[i].date));
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, Workout_History_Details.routeName,
                      arguments: workout_histories[i].listOfSetsRepsWeights);
                },
                child: ListTile(
                  title: Text(workout_histories[i].workoutName),
                  subtitle: Text(formattedDate),
                ),
              );
            }));
  }
}
