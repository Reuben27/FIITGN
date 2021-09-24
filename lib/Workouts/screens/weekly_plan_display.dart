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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF93B5C6),
          title: Text(
            'WORKOUTS IN PLAN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),

        //this page is good structure wise, just add a function to begin logging on each outlines button

        body: ListView.builder(
            itemCount: plan.listOfPlans.length,
            itemBuilder: (_, i) {
              // i is 1
              // plan.listOfPlans[i][6].
              return Padding(
                padding: EdgeInsets.only(
                  top: 0.00625 * _screenHeight,
                  bottom: 0.00625 * _screenHeight,
                  left: 0.03 * _screenWidth,
                  right: 0.03 * _screenWidth,
                ),
                child: Container(
                  width: _screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[200],
                    borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 0.00625 * _screenHeight,
                      bottom: 0.00625 * _screenHeight,
                      left: 0.03 * _screenWidth,
                      right: 0.03 * _screenWidth,
                    ),
                    child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Map pass = Map();
                                        pass['exercise_ids'] = plan
                                            .listOfPlans[i][0].listOfExercisesId;
                                        pass['workoutName'] =
                                            plan.listOfPlans[i][0].workoutName;
                                        Navigator.pushReplacementNamed(
                                            context, WeeklyWorkoutDetails.routeName,
                                            arguments: pass);
                                      },
                                      child: Text(
                                        plan.listOfPlans[i][0].workoutName,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.04 * _screenHeight,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Day " + (i + 1).toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    width: 0.3 * _screenWidth,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // start logging from here please
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Begin",
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 0.025 * _screenHeight,
                                                color: Colors.black),
                                          ),
                                          Icon(
                                            Icons.fitness_center,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Day " + (i + 1).toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.03 * _screenHeight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Map pass = Map();
                                      pass['exercise_ids'] = plan
                                          .listOfPlans[i][1].listOfExercisesId;
                                      pass['workoutName'] =
                                          plan.listOfPlans[i][1].workoutName;
                                      Navigator.pushReplacementNamed(context,
                                          WeeklyWorkoutDetails.routeName,
                                          arguments: pass);
                                    },
                                    child: Text(
                                        plan.listOfPlans[i][1].workoutName)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Day " + (i + 1).toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.03 * _screenHeight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Map pass = Map();
                                      pass['exercise_ids'] = plan
                                          .listOfPlans[i][2].listOfExercisesId;
                                      pass['workoutName'] =
                                          plan.listOfPlans[i][2].workoutName;
                                      Navigator.pushReplacementNamed(context,
                                          WeeklyWorkoutDetails.routeName,
                                          arguments: pass);
                                    },
                                    child: Text(
                                        plan.listOfPlans[i][2].workoutName)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Day " + (i + 1).toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.03 * _screenHeight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Map pass = Map();
                                      pass['exercise_ids'] = plan
                                          .listOfPlans[i][3].listOfExercisesId;
                                      pass['workoutName'] =
                                          plan.listOfPlans[i][3].workoutName;
                                      Navigator.pushReplacementNamed(context,
                                          WeeklyWorkoutDetails.routeName,
                                          arguments: pass);
                                    },
                                    child: Text(
                                        plan.listOfPlans[i][3].workoutName)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Day " + (i + 1).toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.03 * _screenHeight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Map pass = Map();
                                      pass['exercise_ids'] = plan
                                          .listOfPlans[i][4].listOfExercisesId;
                                      pass['workoutName'] =
                                          plan.listOfPlans[i][4].workoutName;
                                      Navigator.pushReplacementNamed(context,
                                          WeeklyWorkoutDetails.routeName,
                                          arguments: pass);
                                    },
                                    child: Text(
                                        plan.listOfPlans[i][4].workoutName)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Day " + (i + 1).toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.03 * _screenHeight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Map pass = Map();
                                      pass['exercise_ids'] = plan
                                          .listOfPlans[i][5].listOfExercisesId;
                                      pass['workoutName'] =
                                          plan.listOfPlans[i][5].workoutName;
                                      Navigator.pushReplacementNamed(context,
                                          WeeklyWorkoutDetails.routeName,
                                          arguments: pass);
                                    },
                                    child: Text(
                                        plan.listOfPlans[i][5].workoutName)),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Day " + (i + 1).toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.03 * _screenHeight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Map pass = Map();
                                      pass['exercise_ids'] = plan
                                          .listOfPlans[i][6].listOfExercisesId;
                                      pass['workoutName'] =
                                          plan.listOfPlans[i][6].workoutName;
                                      Navigator.pushReplacementNamed(context,
                                          WeeklyWorkoutDetails.routeName,
                                          arguments: pass);
                                    },
                                    child: Text(
                                        plan.listOfPlans[i][6].workoutName)),
                              ],
                            ),
                          ],
                        ),
                      
                    
                  ),
                ),
              );
            }),
      ),
    );
  }
}
