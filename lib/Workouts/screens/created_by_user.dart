import 'package:flutter/material.dart';
import '../models/Workout_provider.dart';
import 'package:provider/provider.dart';
import '../models/WorkoutModel.dart';

class Created_by_user extends StatelessWidget {
  static const routeName = '\workouts_created_by_user';
  @override
  Widget build(BuildContext context) {
    final workoutDataProvider = Provider.of<Workouts_Provider>(context);
    final List<WorkoutModel> user_created_workouts =
        workoutDataProvider.created_by_user();
    return Scaffold(
      body: user_created_workouts.length == 0
          ? Center(
              child: Text("None"),
            )
          : ListView.builder(
              itemCount: user_created_workouts.length,
              itemBuilder: (_, i) {
                return ListTile(
                  title: Text(user_created_workouts[i].workoutName),
                  // subtitle: Text(user_created_workouts[i].description),
                );
              }),
    );
  }
}
