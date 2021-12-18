import 'package:fiitgn/Workouts/models/Workout_Data_Log_Model.dart';
import 'package:fiitgn/Workouts/models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'historyScreen2.dart';

class WorkoutsHistory1 extends StatefulWidget {
  // const WorkoutsHistory1({Key? key}) : super(key: key);
  static const routeName = 'workoutHistory1';

  @override
  _WorkoutsHistory1State createState() => _WorkoutsHistory1State();
}

class _WorkoutsHistory1State extends State<WorkoutsHistory1> {
  List<String> getPlanNames(
      Map<String, Map<int, List<Workout_Data_Model>>> plan_logs) {
    List<String> planNames = [];
    for (String name in plan_logs.keys) {
      planNames.add(name);
    }
    return planNames;
  }

  Map<String, Map<int, List<Workout_Data_Model>>> plan_logs = Map();
  List<String> planNames = [];

  @override
  void initState() {
    in_init();
    // TODO: implement initState
    super.initState();
  }

  void in_init() async {
    final workouts_provider =
        Provider.of<Workouts_Provider>(context, listen: false);

    await workouts_provider.getWorkoutLogFromDB();
    plan_logs = workouts_provider.user_workout_logs;
    planNames = getPlanNames(plan_logs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('History Page 1'),
        ),
        body: ListView.builder(
            itemCount: planNames.length,
            itemBuilder: (ctx, i) {
              return InkWell(
                onTap: () {
                  Map<int, List<Workout_Data_Model>> args =
                      plan_logs[planNames[i]];
                  Navigator.pushNamed(context, WorkoutHistory2.routeName,
                      arguments: args);
                },
                child: ListTile(
                  title: Text(planNames[i]),
                ),
              );
            }));
  }
}
