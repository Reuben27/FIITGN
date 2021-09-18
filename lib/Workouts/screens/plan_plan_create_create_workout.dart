// This Screen will have the list of all exercises out of which
// /ill chosose exercises for his workout

// import 'package:fiitgn_workouts_1/models/Exercise_db_model.dart';
// import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
// import 'package:fiitgn_workouts_1/models/Workouts_providers.dart';

import 'package:fiitgn/Workouts/Widgets/create_passer.dart';
import 'package:fiitgn/Workouts/models/WorkoutModel.dart';

import '../models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Exercise_db_model.dart';
import 'package:random_string/random_string.dart';
////
import '../../Providers/DataProvider.dart';
import '../../Screens/HomeScreen.dart';

import '../models/Admin_db_model.dart';
import './create_plan.dart';

class Create_Workout_for_Plan extends StatefulWidget {
  static const routeName = '\CreateWorkoutForPlans';

  @override
  _Create_Workout_for_PlanState createState() =>
      _Create_Workout_for_PlanState();
}

class _Create_Workout_for_PlanState extends State<Create_Workout_for_Plan> {
  final List<ExerciseDbModel> exercisesSelectedForWorkout = [];
  final List<Color> colorList = [];
  final List<Color> chestColorList = [];
  final List<Color> coreColorList = [];
  final List<Color> backColorList = [];
  final List<Color> legsColorList = [];
  final List<Color> bicepsColorList = [];
  final List<Color> tricepsColorList = [];
  final List<Color> shouldersColorList = [];
  bool is_admin(List<String> adminEmailIds) {
    print("is_admin called");
    String user_email = Data_Provider().email;
    print("user EMAIL ID IS " + user_email);
    if (adminEmailIds.contains(user_email.trim())) {
      print("user is an admin");
      return true;
    }
    print("user is not an admin");
    return false;
  }

  save_workout_to_specific_plan(String access, List<String> exerciseIds,
      List<String> followerIds, List<String> ongoingId) async {
    print("workout created for plan");
    final CreateArguments routeArgs = ModalRoute.of(context).settings.arguments;
    // final Map<String, WorkoutModel> routeArgs =
    // ModalRoute.of(context).settings.arguments as Map;
    String name = Data_Provider().name;
    String creatroId = Data_Provider().uid;
    String workoutId = randomString(10);
    String dateTime = DateTime.now().toIso8601String();
    String workoutName = 'ForPlans';
    String description = 'None';
    WorkoutModel workout = WorkoutModel(
        creator_name: name,
        creatorId: creatroId,
        workoutId: workoutId,
        creationDate: dateTime,
        workoutName: workoutName,
        description: description,
        access: access,
        listOfExercisesId: exerciseIds,
        listOfFollowersId: followerIds,
        listOfOnGoingId: ongoingId);

    routeArgs.workoutsForDays[routeArgs.dayNum.toString()] = workout;
    // setting the workout model for that day in the map
    Navigator.pushReplacementNamed(
      context,
      CreatePlan.routeName,
      arguments: routeArgs,
    );
  }

  onTapSave() async {
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    List<String> listOfExercisesId = [];
    exercisesSelectedForWorkout.forEach((element) {
      listOfExercisesId.add(element.exerciseId);
    });
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    String creatorId = workoutDataProvider.userId;
    String creator_name = workoutDataProvider.user_name;
    List<String> listOfFollowersId = ['alpha'];
    List<String> listOfOngoingId = ['alpha'];
    String access = 'Private';
    save_workout_to_specific_plan(
        access, listOfExercisesId, listOfFollowersId, listOfOngoingId);
    // Map<String, dynamic> map = Map();
    // map['listOfExercisesId'] = listOfExercisesId;
    // map['listOfFollowersId'] = listOfFollowersId;
    print("calling the funcc");
    // Navigator.pushNamed(context, Create_Workout1.routeName, arguments: map);
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);
    final List<ExerciseDbModel> allExerciseList =
        exerciseDataProvider.listExercises;
    final List<ExerciseDbModel> chestExercises =
        exerciseDataProvider.chest_exercises;
    final List<ExerciseDbModel> coreExercises =
        exerciseDataProvider.core_exercises;
    final List<ExerciseDbModel> backExercises =
        exerciseDataProvider.back_exercises;
    final List<ExerciseDbModel> bicepsExercises =
        exerciseDataProvider.biceps_exercises;
    final List<ExerciseDbModel> tricepsExercises =
        exerciseDataProvider.tricep_exercises;
    final List<ExerciseDbModel> legsExercises =
        exerciseDataProvider.legs_exercises;
    final List<ExerciseDbModel> shoulderExercises =
        exerciseDataProvider.shoulder_exercises;

    allExerciseList.forEach(
      (element) {
        colorList.add(Colors.grey[350]);
      },
    );
    chestExercises.forEach(
      (element) {
        chestColorList.add(Colors.grey[350]);
      },
    );
    coreExercises.forEach(
      (element) {
        coreColorList.add(Colors.grey[350]);
      },
    );
    backExercises.forEach(
      (element) {
        backColorList.add(Colors.grey[350]);
      },
    );
    bicepsExercises.forEach(
      (element) {
        bicepsColorList.add(Colors.grey[350]);
      },
    );
    shoulderExercises.forEach(
      (element) {
        shouldersColorList.add(Colors.grey[350]);
      },
    );
    tricepsExercises.forEach(
      (element) {
        tricepsColorList.add(Colors.grey[350]);
      },
    );
    legsExercises.forEach(
      (element) {
        legsColorList.add(Colors.grey[350]);
      },
    );
    final MediaQueryData data = MediaQuery.of(context);
    // print(workoutName + " " + access);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: DefaultTabController(
        length: 7,
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red[400],
              child: Icon(Icons.save),
              onPressed: onTapSave,
            ),
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blueGrey[300],
              centerTitle: true,
              title: Text(
                'SELECT EXERCISES',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 0.04 * _screenHeight,
                    fontFamily: 'Gilroy'),
              ),
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      "Chest",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.025 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Core",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.025 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Shoulder",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.025 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Biceps",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.025 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Triceps",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.025 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Legs",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.025 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Back",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.025 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  )
                ],
              ),
              //  title: Text('Choose Exercises'),
              // actions: [
              //   InkWell(
              //     child: Icon(Icons.save),
              //     onTap: onTapSave,
              //   ),
              // ],
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          // separatorBuilder: (ctx, i) => Divider(),
                          itemCount: chestExercises.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 0.007 * _screenHeight,
                                bottom: 0.007 * _screenHeight,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print(allExerciseList[i].isWeighted);
                                  if (!exercisesSelectedForWorkout
                                      .contains(chestExercises[i])) {
                                    Color color = Colors.green;
                                    exercisesSelectedForWorkout
                                        .add(chestExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +
                                    // " added");
                                    setState(() {
                                      // print('colorChange!');
                                      chestColorList[i] = color;
                                      // print(colorList[i].toString());
                                    });
                                  } else {
                                    Color color = Colors.grey[350];
                                    exercisesSelectedForWorkout
                                        .remove(chestExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +

                                    // " removed");
                                    setState(() {
                                      chestColorList[i] = color;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                0.03 * _screenHeight),
                                            topRight: Radius.circular(
                                                0.03 * _screenHeight)),
                                        child: Image(
                                          image: NetworkImage(
                                              chestExercises[i].imageUrl),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      decoration: BoxDecoration(
                                          color: chestColorList[i],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  0.03 * _screenHeight),
                                              bottomLeft: Radius.circular(
                                                  0.03 * _screenHeight))),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 0.00625 * _screenHeight,
                                            bottom: 0.00625 * _screenHeight,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                chestExercises[i].exerciseName,
                                                style: TextStyle(
                                                    fontFamily: "Gilroy",
                                                    fontSize:
                                                        0.04 * _screenHeight,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 0.3 * _screenWidth,
                                                child: OutlinedButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "About",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy',
                                                            fontSize: 0.025 *
                                                                _screenHeight,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.info_outline,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    return showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          Container(
                                                        color: Colors.grey[350],
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0.03 *
                                                                _screenWidth,
                                                            right: 0.03 *
                                                                _screenWidth,
                                                            top: 0.03 *
                                                                _screenHeight,
                                                            bottom: 0.03 *
                                                                _screenHeight,
                                                          ),
                                                          child: Text(
                                                            chestExercises[i]
                                                                .category,
                                                            textScaleFactor:
                                                                0.8,
                                                            style: TextStyle(
                                                                fontSize: 0.025 *
                                                                    _screenHeight,
                                                                fontFamily:
                                                                    'Gilroy'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    // print("i= " + index.toString());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Text(
                                      //   chestExercises[i].description,
                                      //   style: TextStyle(
                                      //       fontFamily: "Gilroy", fontSize: 17),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          // separatorBuilder: (ctx, i) => Divider(),
                          itemCount: coreExercises.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 0.007 * _screenHeight,
                                bottom: 0.007 * _screenHeight,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print(allExerciseList[i].isWeighted);
                                  if (!exercisesSelectedForWorkout
                                      .contains(coreExercises[i])) {
                                    Color color = Colors.green;
                                    exercisesSelectedForWorkout
                                        .add(coreExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +
                                    // " added");
                                    setState(() {
                                      // print('colorChange!');
                                      coreColorList[i] = color;
                                      // print(colorList[i].toString());
                                    });
                                  } else {
                                    Color color = Colors.grey[350];
                                    exercisesSelectedForWorkout
                                        .remove(coreExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +

                                    // " removed");
                                    setState(() {
                                      coreColorList[i] = color;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                0.03 * _screenHeight),
                                            topRight: Radius.circular(
                                                0.03 * _screenHeight)),
                                        child: Image(
                                          image: NetworkImage(
                                              coreExercises[i].imageUrl),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      decoration: BoxDecoration(
                                          color: coreColorList[i],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  0.03 * _screenHeight),
                                              bottomLeft: Radius.circular(
                                                  0.03 * _screenHeight))),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 0.00625 * _screenHeight,
                                            bottom: 0.00625 * _screenHeight,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                coreExercises[i].exerciseName,
                                                style: TextStyle(
                                                    fontFamily: "Gilroy",
                                                    fontSize:
                                                        0.04 * _screenHeight,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 0.3 * _screenWidth,
                                                child: OutlinedButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "About",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy',
                                                            fontSize: 0.025 *
                                                                _screenHeight,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.info_outline,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    return showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          Container(
                                                        color: Colors.grey[350],
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0.03 *
                                                                _screenWidth,
                                                            right: 0.03 *
                                                                _screenWidth,
                                                            top: 0.03 *
                                                                _screenHeight,
                                                            bottom: 0.03 *
                                                                _screenHeight,
                                                          ),
                                                          child: Text(
                                                            coreExercises[i]
                                                                .category,
                                                            textScaleFactor:
                                                                0.8,
                                                            style: TextStyle(
                                                                fontSize: 0.025 *
                                                                    _screenHeight,
                                                                fontFamily:
                                                                    'Gilroy'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    // print("i= " + index.toString());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Text(
                                      //   chestExercises[i].description,
                                      //   style: TextStyle(
                                      //       fontFamily: "Gilroy", fontSize: 17),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          // separatorBuilder: (ctx, i) => Divider(),
                          itemCount: shoulderExercises.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 0.007 * _screenHeight,
                                bottom: 0.007 * _screenHeight,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print(allExerciseList[i].isWeighted);
                                  if (!exercisesSelectedForWorkout
                                      .contains(shoulderExercises[i])) {
                                    Color color = Colors.green;
                                    exercisesSelectedForWorkout
                                        .add(shoulderExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +
                                    // " added");
                                    setState(() {
                                      // print('colorChange!');
                                      shouldersColorList[i] = color;
                                      // print(colorList[i].toString());
                                    });
                                  } else {
                                    Color color = Colors.grey[350];
                                    exercisesSelectedForWorkout
                                        .remove(shoulderExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +

                                    // " removed");
                                    setState(() {
                                      shouldersColorList[i] = color;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                0.03 * _screenHeight),
                                            topRight: Radius.circular(
                                                0.03 * _screenHeight)),
                                        child: Image(
                                          image: NetworkImage(
                                              shoulderExercises[i].imageUrl),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      decoration: BoxDecoration(
                                          color: shouldersColorList[i],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  0.03 * _screenHeight),
                                              bottomLeft: Radius.circular(
                                                  0.03 * _screenHeight))),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 0.00625 * _screenHeight,
                                            bottom: 0.00625 * _screenHeight,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                shoulderExercises[i]
                                                    .exerciseName,
                                                style: TextStyle(
                                                    fontFamily: "Gilroy",
                                                    fontSize:
                                                        0.04 * _screenHeight,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 0.3 * _screenWidth,
                                                child: OutlinedButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "About",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy',
                                                            fontSize: 0.025 *
                                                                _screenHeight,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.info_outline,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    return showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          Container(
                                                        color: Colors.grey[350],
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0.03 *
                                                                _screenWidth,
                                                            right: 0.03 *
                                                                _screenWidth,
                                                            top: 0.03 *
                                                                _screenHeight,
                                                            bottom: 0.03 *
                                                                _screenHeight,
                                                          ),
                                                          child: Text(
                                                            shoulderExercises[i]
                                                                .category,
                                                            textScaleFactor:
                                                                0.8,
                                                            style: TextStyle(
                                                                fontSize: 0.025 *
                                                                    _screenHeight,
                                                                fontFamily:
                                                                    'Gilroy'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    // print("i= " + index.toString());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Text(
                                      //   chestExercises[i].description,
                                      //   style: TextStyle(
                                      //       fontFamily: "Gilroy", fontSize: 17),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          // separatorBuilder: (ctx, i) => Divider(),
                          itemCount: bicepsExercises.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 0.007 * _screenHeight,
                                bottom: 0.007 * _screenHeight,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print(allExerciseList[i].isWeighted);
                                  if (!exercisesSelectedForWorkout
                                      .contains(bicepsExercises[i])) {
                                    Color color = Colors.green;
                                    exercisesSelectedForWorkout
                                        .add(bicepsExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +
                                    // " added");
                                    setState(() {
                                      // print('colorChange!');
                                      bicepsColorList[i] = color;
                                      // print(colorList[i].toString());
                                    });
                                  } else {
                                    Color color = Colors.grey[350];
                                    exercisesSelectedForWorkout
                                        .remove(bicepsExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +

                                    // " removed");
                                    setState(() {
                                      bicepsColorList[i] = color;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                0.03 * _screenHeight),
                                            topRight: Radius.circular(
                                                0.03 * _screenHeight)),
                                        child: Image(
                                          image: NetworkImage(
                                              bicepsExercises[i].imageUrl),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      decoration: BoxDecoration(
                                          color: bicepsColorList[i],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  0.03 * _screenHeight),
                                              bottomLeft: Radius.circular(
                                                  0.03 * _screenHeight))),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 0.00625 * _screenHeight,
                                            bottom: 0.00625 * _screenHeight,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                bicepsExercises[i].exerciseName,
                                                style: TextStyle(
                                                    fontFamily: "Gilroy",
                                                    fontSize:
                                                        0.04 * _screenHeight,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 0.3 * _screenWidth,
                                                child: OutlinedButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "About",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy',
                                                            fontSize: 0.025 *
                                                                _screenHeight,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.info_outline,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    return showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          Container(
                                                        color: Colors.grey[350],
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0.03 *
                                                                _screenWidth,
                                                            right: 0.03 *
                                                                _screenWidth,
                                                            top: 0.03 *
                                                                _screenHeight,
                                                            bottom: 0.03 *
                                                                _screenHeight,
                                                          ),
                                                          child: Text(
                                                            bicepsExercises[i]
                                                                .category,
                                                            textScaleFactor:
                                                                0.8,
                                                            style: TextStyle(
                                                                fontSize: 0.025 *
                                                                    _screenHeight,
                                                                fontFamily:
                                                                    'Gilroy'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    // print("i= " + index.toString());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Text(
                                      //   chestExercises[i].description,
                                      //   style: TextStyle(
                                      //       fontFamily: "Gilroy", fontSize: 17),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          // separatorBuilder: (ctx, i) => Divider(),
                          itemCount: tricepsExercises.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 0.007 * _screenHeight,
                                bottom: 0.007 * _screenHeight,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print(allExerciseList[i].isWeighted);
                                  print("working with a tricep exercise");
                                  if (!exercisesSelectedForWorkout
                                      .contains(tricepsExercises[i])) {
                                    Color color = Colors.green;
                                    exercisesSelectedForWorkout
                                        .add(tricepsExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +
                                    // " added");
                                    setState(() {
                                      // print('colorChange!');
                                      tricepsColorList[i] = color;
                                      // print(colorList[i].toString());
                                    });
                                  } else {
                                    print("un selecting triceps");
                                    Color color = Colors.grey[350];
                                    exercisesSelectedForWorkout
                                        .remove(tricepsExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +

                                    // " removed");
                                    setState(() {
                                      tricepsColorList[i] = color;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                0.03 * _screenHeight),
                                            topRight: Radius.circular(
                                                0.03 * _screenHeight)),
                                        child: Image(
                                          image: NetworkImage(
                                              tricepsExercises[i].imageUrl),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      decoration: BoxDecoration(
                                          color: tricepsColorList[i],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  0.03 * _screenHeight),
                                              bottomLeft: Radius.circular(
                                                  0.03 * _screenHeight))),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 0.00625 * _screenHeight,
                                            bottom: 0.00625 * _screenHeight,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                tricepsExercises[i]
                                                    .exerciseName,
                                                style: TextStyle(
                                                    fontFamily: "Gilroy",
                                                    fontSize:
                                                        0.04 * _screenHeight,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 0.3 * _screenWidth,
                                                child: OutlinedButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "About",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy',
                                                            fontSize: 0.025 *
                                                                _screenHeight,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.info_outline,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    return showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          Container(
                                                        color: Colors.grey[350],
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0.03 *
                                                                _screenWidth,
                                                            right: 0.03 *
                                                                _screenWidth,
                                                            top: 0.03 *
                                                                _screenHeight,
                                                            bottom: 0.03 *
                                                                _screenHeight,
                                                          ),
                                                          child: Text(
                                                            tricepsExercises[i]
                                                                .category,
                                                            textScaleFactor:
                                                                0.8,
                                                            style: TextStyle(
                                                                fontSize: 0.025 *
                                                                    _screenHeight,
                                                                fontFamily:
                                                                    'Gilroy'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    // print("i= " + index.toString());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Text(
                                      //   chestExercises[i].description,
                                      //   style: TextStyle(
                                      //       fontFamily: "Gilroy", fontSize: 17),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          // separatorBuilder: (ctx, i) => Divider(),
                          itemCount: legsExercises.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 0.007 * _screenHeight,
                                bottom: 0.007 * _screenHeight,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print(allExerciseList[i].isWeighted);
                                  if (!exercisesSelectedForWorkout
                                      .contains(legsExercises[i])) {
                                    Color color = Colors.green;
                                    exercisesSelectedForWorkout
                                        .add(legsExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +
                                    // " added");
                                    setState(() {
                                      // print('colorChange!');
                                      legsColorList[i] = color;
                                      // print(colorList[i].toString());
                                    });
                                  } else {
                                    Color color = Colors.grey[350];
                                    exercisesSelectedForWorkout
                                        .remove(legsExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +

                                    // " removed");
                                    setState(() {
                                      legsColorList[i] = color;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                0.03 * _screenHeight),
                                            topRight: Radius.circular(
                                                0.03 * _screenHeight)),
                                        child: Image(
                                          image: NetworkImage(
                                              legsExercises[i].imageUrl),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      decoration: BoxDecoration(
                                          color: legsColorList[i],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  0.03 * _screenHeight),
                                              bottomLeft: Radius.circular(
                                                  0.03 * _screenHeight))),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 0.00625 * _screenHeight,
                                            bottom: 0.00625 * _screenHeight,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                legsExercises[i].exerciseName,
                                                style: TextStyle(
                                                    fontFamily: "Gilroy",
                                                    fontSize:
                                                        0.04 * _screenHeight,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 0.3 * _screenWidth,
                                                child: OutlinedButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "About",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy',
                                                            fontSize: 0.025 *
                                                                _screenHeight,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.info_outline,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    return showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          Container(
                                                        color: Colors.grey[350],
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0.03 *
                                                                _screenWidth,
                                                            right: 0.03 *
                                                                _screenWidth,
                                                            top: 0.03 *
                                                                _screenHeight,
                                                            bottom: 0.03 *
                                                                _screenHeight,
                                                          ),
                                                          child: Text(
                                                            legsExercises[i]
                                                                .category,
                                                            textScaleFactor:
                                                                0.8,
                                                            style: TextStyle(
                                                                fontSize: 0.025 *
                                                                    _screenHeight,
                                                                fontFamily:
                                                                    'Gilroy'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    // print("i= " + index.toString());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Text(
                                      //   chestExercises[i].description,
                                      //   style: TextStyle(
                                      //       fontFamily: "Gilroy", fontSize: 17),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          // separatorBuilder: (ctx, i) => Divider(),
                          itemCount: backExercises.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 0.007 * _screenHeight,
                                bottom: 0.007 * _screenHeight,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print(allExerciseList[i].isWeighted);
                                  if (!exercisesSelectedForWorkout
                                      .contains(backExercises[i])) {
                                    Color color = Colors.green;
                                    exercisesSelectedForWorkout
                                        .add(backExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +
                                    // " added");
                                    setState(() {
                                      // print('colorChange!');
                                      backColorList[i] = color;
                                      // print(colorList[i].toString());
                                    });
                                  } else {
                                    Color color = Colors.grey[350];
                                    exercisesSelectedForWorkout
                                        .remove(backExercises[i]);
                                    // print("exercise " +
                                    // allExerciseList[i].exerciseName +

                                    // " removed");
                                    setState(() {
                                      backColorList[i] = color;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                0.03 * _screenHeight),
                                            topRight: Radius.circular(
                                                0.03 * _screenHeight)),
                                        child: Image(
                                          image: NetworkImage(
                                              backExercises[i].imageUrl),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                        left: 0.03 * _screenWidth,
                                        right: 0.03 * _screenWidth,
                                      ),
                                      decoration: BoxDecoration(
                                          color: backColorList[i],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  0.03 * _screenHeight),
                                              bottomLeft: Radius.circular(
                                                  0.03 * _screenHeight))),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 0.00625 * _screenHeight,
                                            bottom: 0.00625 * _screenHeight,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                backExercises[i].exerciseName,
                                                style: TextStyle(
                                                    fontFamily: "Gilroy",
                                                    fontSize:
                                                        0.04 * _screenHeight,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: 0.3 * _screenWidth,
                                                child: OutlinedButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "About",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy',
                                                            fontSize: 0.025 *
                                                                _screenHeight,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.info_outline,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    return showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          Container(
                                                        color: Colors.grey[350],
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0.03 *
                                                                _screenWidth,
                                                            right: 0.03 *
                                                                _screenWidth,
                                                            top: 0.03 *
                                                                _screenHeight,
                                                            bottom: 0.03 *
                                                                _screenHeight,
                                                          ),
                                                          child: Text(
                                                            backExercises[i]
                                                                .category,
                                                            textScaleFactor:
                                                                0.8,
                                                            style: TextStyle(
                                                                fontSize: 0.025 *
                                                                    _screenHeight,
                                                                fontFamily:
                                                                    'Gilroy'),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    // print("i= " + index.toString());
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Text(
                                      //   chestExercises[i].description,
                                      //   style: TextStyle(
                                      //       fontFamily: "Gilroy", fontSize: 17),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
