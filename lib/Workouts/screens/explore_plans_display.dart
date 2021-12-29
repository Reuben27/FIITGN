import 'package:fiitgn/Workouts/models/Exercise_db_model.dart';
import 'package:fiitgn/Workouts/models/Plan_Model.dart';
import 'package:fiitgn/Workouts/models/Workout_provider.dart';
import 'package:fiitgn/Workouts/screens/workout_logging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './weekly_workout_details.dart';

class ExplorePlanDisplay extends StatelessWidget {
  List<String> getDays(int dayNum) {
    List<String> days = [];
    List<String> image = [];
    if (dayNum == 0) {
      days.add('Monday');
      image.add('assets/monday.png');
    } else if (dayNum == 1) {
      days.add('Tuesday');
      image.add('assets/tuesday.png');
    } else if (dayNum == 2) {
      days.add('Wednesday');
      image.add('assets/wednesday.png');
    } else if (dayNum == 3) {
      days.add('Thursday');
      image.add('assets/thursday.png');
    } else if (dayNum == 4) {
      days.add('Friday');
      image.add('assets/friday.png');
    } else if (dayNum == 5) {
      days.add('Saturday');
      image.add('assets/saturday.png');
    } else if (dayNum == 6) {
      days.add('Sunday');
      image.add('assets/sunday.png');
    }

    return days;
  }

  List<String> getImage(int dayNum) {
    List<String> days = [];
    List<String> image = [];
    if (dayNum == 0) {
      days.add('Monday');
      image.add('assets/monday.png');
    } else if (dayNum == 1) {
      days.add('Tuesday');
      image.add('assets/tuesday.png');
    } else if (dayNum == 2) {
      days.add('Wednesday');
      image.add('assets/wednesday.png');
    } else if (dayNum == 3) {
      days.add('Thursday');
      image.add('assets/thursday.png');
    } else if (dayNum == 4) {
      days.add('Friday');
      image.add('assets/friday.png');
    } else if (dayNum == 5) {
      days.add('Saturday');
      image.add('assets/saturday.png');
    } else if (dayNum == 6) {
      days.add('Sunday');
      image.add('assets/sunday.png');
    }

    return image;
  }

  static const routeName = 'explorePlanDisplay';
  @override
  Widget build(BuildContext context) {
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);
    final PlanModel plan =
        ModalRoute.of(context).settings.arguments as PlanModel;
    print("got the plan model");
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
            // centerTitle: true,
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
          body: ListView.builder(
            itemCount: 7,
            itemBuilder: (_, i) {
              return Container(
                width: _screenWidth,
                height: _screenHeight / 7,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 0.00625 * _screenHeight,
                    bottom: 0.00625 * _screenHeight,
                    left: 0.03 * _screenWidth,
                    right: 0.03 * _screenWidth,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFC9CCD5),
                      borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0.025 * _screenHeight,
                        bottom: 0.025 * _screenHeight,
                        left: 0.03 * _screenWidth,
                        right: 0.08 * _screenWidth,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Text(
                                  plan.listOfPlans[0][i].workoutName,
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 0.04 * _screenHeight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  //  THIS WILL GO TO THE PAGE WHERE DETAILS OF THE WORKOUT ARE SHOWN
                                  // ADD CHECK THAT REST DAYS ARENT PRESSABLE
                                  Map pass = Map();
                                  pass['exercise_ids'] =
                                      plan.listOfPlans[0][i].listOfExercisesId;
                                  pass['workoutName'] =
                                      plan.listOfPlans[0][i].workoutName;
                                  Navigator.pushNamed(
                                      context, WeeklyWorkoutDetails.routeName,
                                      arguments: pass);
                                },
                              ),
                              Container(
                                child: Text(
                                  getDays(i)[0].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 0.025 * _screenHeight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   width: 0.3 * _screenWidth,
                          //   child: OutlinedButton(
                          //     onPressed: () {
                          //       Map<String, dynamic> sendToWorkoutLogging = Map();
                          //       List<String> exercise_ids =
                          //           plan.listOfPlans[0][i].listOfExercisesId;
                          //       List<ExerciseDbModel> exercises =
                          //           exerciseDataProvider
                          //               .exercisesBasesOnId(exercise_ids);
                          //       sendToWorkoutLogging['exercises'] = exercises;
                          //       sendToWorkoutLogging['planName'] = plan.planName;
                          //       sendToWorkoutLogging['planDay'] = i;
                          //       sendToWorkoutLogging['planId'] = plan.planId;
                          //       Navigator.pushNamed(
                          //           context, Workout_Logging.routeName,
                          //           arguments: sendToWorkoutLogging);
                          //       // final Map<String, dynamic> routeArgs =
                          //       //     ModalRoute.of(context).settings.arguments
                          //       //         as Map;
                          //       // List<ExerciseDbModel> exercises =
                          //       // routeArgs['exercises'];
                          //       // String workoutName = routeArgs['workoutName'];

                          //       // Navigator.pushReplacementNamed(
                          //       //     context, WeeklyWorkoutDetails.routeName,
                          //       //     arguments: pass);
                          //       // start logging from here please
                          //     },
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text(
                          //           "Begin",
                          //           style: TextStyle(
                          //               fontFamily: 'Gilroy',
                          //               fontSize: 0.025 * _screenHeight,
                          //               color: Colors.black),
                          //         ),
                          //         Icon(
                          //           Icons.fitness_center,
                          //           color: Colors.black,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Container(
                              height: _screenHeight / 8,
                              child: Image.asset(
                                getImage(i)[0],
                                fit: BoxFit.contain,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )

          //this page is good structure wise, just add a function to begin logging on each outlines button

          // body : ListView.builder(itemBuilder: (){},itemCount: ,)
          // body: ListView.builder(
          //     itemCount: plan.listOfPlans.length,
          //     itemBuilder: (_, i) {
          //       // i is 1
          //       // plan.listOfPlans[i][6].
          //       return Padding(
          //         padding: EdgeInsets.only(
          //           top: 0.00625 * _screenHeight,
          //           bottom: 0.00625 * _screenHeight,
          //           left: 0.03 * _screenWidth,
          //           right: 0.03 * _screenWidth,
          //         ),
          //         child: Container(
          //           width: _screenWidth,
          //           decoration: BoxDecoration(
          //             color: Colors.blueGrey[200],
          //             borderRadius: BorderRadius.circular(0.02 * _screenHeight),
          //           ),
          //           child: Padding(
          //             padding: EdgeInsets.only(
          //               top: 0.00625 * _screenHeight,
          //               bottom: 0.00625 * _screenHeight,
          //               left: 0.03 * _screenWidth,
          //               right: 0.03 * _screenWidth,
          //             ),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         InkWell(
          //                           onTap: () {
          //                             Map pass = Map();
          //                             pass['exercise_ids'] = plan
          //                                 .listOfPlans[0][i].listOfExercisesId;
          //                             pass['workoutName'] =
          //                                 plan.listOfPlans[0][i].workoutName;
          //                             Navigator.pushReplacementNamed(
          //                                 context, WeeklyWorkoutDetails.routeName,
          //                                 arguments: pass);
          //                           },
          //                           child: Text(
          //                             plan.listOfPlans[0][i].workoutName,
          //                             style: TextStyle(
          //                               fontFamily: 'Gilroy',
          //                               fontSize: 0.04 * _screenHeight,
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                         ),
          //                         Container(
          //                           child: Text(
          //                             "Day " + (i + 1).toString(),
          //                             style: TextStyle(
          //                               fontFamily: 'Gilroy',
          //                               fontSize: 0.025 * _screenHeight,
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     Container(
          //                       width: 0.3 * _screenWidth,
          //                       child: OutlinedButton(
          //                         onPressed: () {
          //                           // start logging from here please
          //                         },
          //                         child: Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             Text(
          //                               "Begin",
          //                               style: TextStyle(
          //                                   fontFamily: 'Gilroy',
          //                                   fontSize: 0.025 * _screenHeight,
          //                                   color: Colors.black),
          //                             ),
          //                             Icon(
          //                               Icons.fitness_center,
          //                               color: Colors.black,
          //                             )
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 Row(
          //                   children: [
          //                     Container(
          //                       child: Text(
          //                         "Day " + (i + 1).toString(),
          //                         style: TextStyle(
          //                           fontFamily: 'Gilroy',
          //                           fontSize: 0.03 * _screenHeight,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                     InkWell(
          //                         onTap: () {
          //                           Map pass = Map();
          //                           pass['exercise_ids'] =
          //                               plan.listOfPlans[i][1].listOfExercisesId;
          //                           pass['workoutName'] =
          //                               plan.listOfPlans[i][1].workoutName;
          //                           Navigator.pushReplacementNamed(
          //                               context, WeeklyWorkoutDetails.routeName,
          //                               arguments: pass);
          //                         },
          //                         child:
          //                             Text(plan.listOfPlans[i][1].workoutName)),
          //                   ],
          //                 ),

          //                 // Row(
          //                 //   children: [
          //                 //     Container(
          //                 //       child: Text(
          //                 //         "Day " + (i + 1).toString(),
          //                 //         style: TextStyle(
          //                 //           fontFamily: 'Gilroy',
          //                 //           fontSize: 0.03 * _screenHeight,
          //                 //           fontWeight: FontWeight.bold,
          //                 //         ),
          //                 //       ),
          //                 //     ),
          //                 //     InkWell(
          //                 //         onTap: () {
          //                 //           Map pass = Map();
          //                 //           pass['exercise_ids'] = plan
          //                 //               .listOfPlans[i][2].listOfExercisesId;
          //                 //           pass['workoutName'] =
          //                 //               plan.listOfPlans[i][2].workoutName;
          //                 //           Navigator.pushReplacementNamed(context,
          //                 //               WeeklyWorkoutDetails.routeName,
          //                 //               arguments: pass);
          //                 //         },
          //                 //         child: Text(
          //                 //             plan.listOfPlans[i][2].workoutName)),
          //                 //   ],
          //                 // ),
          //                 // Row(
          //                 //   children: [
          //                 //     Container(
          //                 //       child: Text(
          //                 //         "Day " + (i + 1).toString(),
          //                 //         style: TextStyle(
          //                 //           fontFamily: 'Gilroy',
          //                 //           fontSize: 0.03 * _screenHeight,
          //                 //           fontWeight: FontWeight.bold,
          //                 //         ),
          //                 //       ),
          //                 //     ),
          //                 //     InkWell(
          //                 //         onTap: () {
          //                 //           Map pass = Map();
          //                 //           pass['exercise_ids'] = plan
          //                 //               .listOfPlans[i][3].listOfExercisesId;
          //                 //           pass['workoutName'] =
          //                 //               plan.listOfPlans[i][3].workoutName;
          //                 //           Navigator.pushReplacementNamed(context,
          //                 //               WeeklyWorkoutDetails.routeName,
          //                 //               arguments: pass);
          //                 //         },
          //                 //         child: Text(
          //                 //             plan.listOfPlans[i][3].workoutName)),
          //                 //   ],
          //                 // ),
          //                 // Row(
          //                 //   children: [
          //                 //     Container(
          //                 //       child: Text(
          //                 //         "Day " + (i + 1).toString(),
          //                 //         style: TextStyle(
          //                 //           fontFamily: 'Gilroy',
          //                 //           fontSize: 0.03 * _screenHeight,
          //                 //           fontWeight: FontWeight.bold,
          //                 //         ),
          //                 //       ),
          //                 //     ),
          //                 //     InkWell(
          //                 //         onTap: () {
          //                 //           Map pass = Map();
          //                 //           pass['exercise_ids'] = plan
          //                 //               .listOfPlans[i][4].listOfExercisesId;
          //                 //           pass['workoutName'] =
          //                 //               plan.listOfPlans[i][4].workoutName;
          //                 //           Navigator.pushReplacementNamed(context,
          //                 //               WeeklyWorkoutDetails.routeName,
          //                 //               arguments: pass);
          //                 //         },
          //                 //         child: Text(
          //                 //             plan.listOfPlans[i][4].workoutName)),
          //                 //   ],
          //                 // ),
          //                 // Row(
          //                 //   children: [
          //                 //     Container(
          //                 //       child: Text(
          //                 //         "Day " + (i + 1).toString(),
          //                 //         style: TextStyle(
          //                 //           fontFamily: 'Gilroy',
          //                 //           fontSize: 0.03 * _screenHeight,
          //                 //           fontWeight: FontWeight.bold,
          //                 //         ),
          //                 //       ),
          //                 //     ),
          //                 //     InkWell(
          //                 //         onTap: () {
          //                 //           Map pass = Map();
          //                 //           pass['exercise_ids'] = plan
          //                 //               .listOfPlans[i][5].listOfExercisesId;
          //                 //           pass['workoutName'] =
          //                 //               plan.listOfPlans[i][5].workoutName;
          //                 //           Navigator.pushReplacementNamed(context,
          //                 //               WeeklyWorkoutDetails.routeName,
          //                 //               arguments: pass);
          //                 //         },
          //                 //         child: Text(
          //                 //             plan.listOfPlans[i][5].workoutName)),
          //                 //   ],
          //                 // ),
          //                 // Row(
          //                 //   children: [
          //                 //     Container(
          //                 //       child: Text(
          //                 //         "Day " + (i + 1).toString(),
          //                 //         style: TextStyle(
          //                 //           fontFamily: 'Gilroy',
          //                 //           fontSize: 0.03 * _screenHeight,
          //                 //           fontWeight: FontWeight.bold,
          //                 //         ),
          //                 //       ),
          //                 //     ),
          //                 //     InkWell(
          //                 //         onTap: () {
          //                 //           Map pass = Map();
          //                 //           pass['exercise_ids'] = plan
          //                 //               .listOfPlans[i][6].listOfExercisesId;
          //                 //           pass['workoutName'] =
          //                 //               plan.listOfPlans[i][6].workoutName;
          //                 //           Navigator.pushReplacementNamed(context,
          //                 //               WeeklyWorkoutDetails.routeName,
          //                 //               arguments: pass);
          //                 //         },
          //                 //         child: Text(
          //                 //             plan.listOfPlans[i][6].workoutName)),
          //                 //   ],
          //                 // ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     }),
          ),
    );
  }
}
