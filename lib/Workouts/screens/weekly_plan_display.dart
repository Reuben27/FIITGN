import 'package:fiitgn/Workouts/models/Plan_Model.dart';
import 'package:fiitgn/Workouts/models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './weekly_workout_details.dart';

class WeeklyPlanDisplay extends StatelessWidget {
  static const routeName = 'weeklyPlanDisplay';
  @override
  Widget build(BuildContext context) {
    final PlanModel plan =
        ModalRoute.of(context).settings.arguments as PlanModel;
    // final workoutDataProvider =
    //     Provider.of<Workouts_Provider>(context, listen: false);
    // List<PlanModel> plans = workoutDataProvider.plansList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Details'),
      ),
      body: ListView.builder(
          itemCount: plan.listOfPlans.length,
          itemBuilder: (_, i) {
            // i is 1
            // plan.listOfPlans[i][6].
            return Card(
                child: Container(
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        Map pass = Map();
                        pass['exercise_ids'] =
                            plan.listOfPlans[i][0].listOfExercisesId;
                        pass['workoutName'] =
                            plan.listOfPlans[i][0].workoutName;
                        Navigator.pushReplacementNamed(
                            context, WeeklyWorkoutDetails.routeName,
                            arguments: pass);
                      },
                      child: Text(plan.listOfPlans[i][0].workoutName)),
                  InkWell(
                      onTap: () {
                        Map pass = Map();
                        pass['exercise_ids'] =
                            plan.listOfPlans[i][1].listOfExercisesId;
                        pass['workoutName'] =
                            plan.listOfPlans[i][1].workoutName;
                        Navigator.pushReplacementNamed(
                            context, WeeklyWorkoutDetails.routeName,
                            arguments: pass);
                      },
                      child: Text(plan.listOfPlans[i][1].workoutName)),
                  InkWell(
                      onTap: () {
                        Map pass = Map();
                        pass['exercise_ids'] =
                            plan.listOfPlans[i][2].listOfExercisesId;
                        pass['workoutName'] =
                            plan.listOfPlans[i][2].workoutName;
                        Navigator.pushReplacementNamed(
                            context, WeeklyWorkoutDetails.routeName,
                            arguments: pass);
                      },
                      child: Text(plan.listOfPlans[i][2].workoutName)),
                  InkWell(
                      onTap: () {
                        Map pass = Map();
                        pass['exercise_ids'] =
                            plan.listOfPlans[i][3].listOfExercisesId;
                        pass['workoutName'] =
                            plan.listOfPlans[i][3].workoutName;
                        Navigator.pushReplacementNamed(
                            context, WeeklyWorkoutDetails.routeName,
                            arguments: pass);
                      },
                      child: Text(plan.listOfPlans[i][3].workoutName)),
                  InkWell(
                      onTap: () {
                        Map pass = Map();
                        pass['exercise_ids'] =
                            plan.listOfPlans[i][4].listOfExercisesId;
                        pass['workoutName'] =
                            plan.listOfPlans[i][4].workoutName;
                        Navigator.pushReplacementNamed(
                            context, WeeklyWorkoutDetails.routeName,
                            arguments: pass);
                      },
                      child: Text(plan.listOfPlans[i][4].workoutName)),
                  InkWell(
                      onTap: () {
                        Map pass = Map();
                        pass['exercise_ids'] =
                            plan.listOfPlans[i][5].listOfExercisesId;
                        pass['workoutName'] =
                            plan.listOfPlans[i][5].workoutName;
                        Navigator.pushReplacementNamed(
                            context, WeeklyWorkoutDetails.routeName,
                            arguments: pass);
                      },
                      child: Text(plan.listOfPlans[i][5].workoutName)),
                  InkWell(
                      onTap: () {
                        Map pass = Map();
                        pass['exercise_ids'] =
                            plan.listOfPlans[i][6].listOfExercisesId;
                        pass['workoutName'] =
                            plan.listOfPlans[i][6].workoutName;
                        Navigator.pushReplacementNamed(
                            context, WeeklyWorkoutDetails.routeName,
                            arguments: pass);
                      },
                      child: Text(plan.listOfPlans[i][6].workoutName)),
                ],
              ),
            ));
          }),
    );
  }
}
