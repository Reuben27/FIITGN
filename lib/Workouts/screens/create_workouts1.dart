// This Screen will have the list of all exercises out of which
// the user will chosose exercises for his workout

// import 'package:fiitgn_workouts_1/models/Exercise_db_model.dart';
// import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
// import 'package:fiitgn_workouts_1/models/Workouts_providers.dart';
import './create_workouts2.dart';

import '../models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Exercise_db_model.dart';

class Create_Workout2 extends StatefulWidget {
  static const routeName = '\CreateWorkout1';

  @override
  _Create_Workout2State createState() => _Create_Workout2State();
}

class _Create_Workout2State extends State<Create_Workout2> {
  final List<ExerciseDbModel> exercisesSelectedForWorkout = [];
  final List<Color> colorList = [];
  @override
  Widget build(BuildContext context) {
    final workoutDataProvider = Provider.of<Workouts_Provider>(context);
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context);
    final List<ExerciseDbModel> allExerciseList =
        exerciseDataProvider.listExercises;
    // final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    // final String workoutName = routeArgs['workoutName'];
    // final String access = routeArgs['access'];
    // final String description = routeArgs['desription'];
    allExerciseList.forEach(
      (element) {
        colorList.add(Colors.grey[200]);
      },
    );
    // print(workoutName + " " + access);
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Exercises'),
        actions: [
          InkWell(
            child: Icon(Icons.save),
            onTap: () {
              List<String> listOfExercisesId = [];
              exercisesSelectedForWorkout.forEach((element) {
                listOfExercisesId.add(element.exerciseId);
              });

              String creatorId = workoutDataProvider.userId;
              String creator_name = workoutDataProvider.user_name;
              List<String> listOfFollowersId = [creatorId];
              Map<String, dynamic> map = Map();
              map['listOfExercisesId'] = listOfExercisesId;
              map['listOfFollowersId'] = listOfFollowersId;

              // workoutDataProvider.createWorkoutAndAddToDB(
              //   creatorId,
              //   creator_name,
              //   workoutName,
              //   description,
              //   access,
              //   listOfExercisesId,
              //   listOfFollowersId,
              // );
              Navigator.pushNamed(context, Create_Workout1.routeName,
                  arguments: map);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 30),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Text(
                      'Create Workout',
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: "Gilroy",
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/23.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allExerciseList.length,
              itemBuilder: (ctx, i) {
                return InkWell(
                  onTap: () {
                    if (!exercisesSelectedForWorkout
                        .contains(allExerciseList[i])) {
                      Color color = Colors.green;
                      exercisesSelectedForWorkout.add(allExerciseList[i]);
                      print("exercise " +
                          allExerciseList[i].exerciseName +
                          " added");
                      setState(() {
                        print('colorChange!');
                        colorList[i] = color;
                        print(colorList[i].toString());
                      });
                    } else {
                      Color color = Colors.grey[200];
                      exercisesSelectedForWorkout.remove(allExerciseList[i]);
                      print("exercise " +
                          allExerciseList[i].exerciseName +
                          " removed");
                      setState(() {
                        colorList[i] = color;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorList[i],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 100,
                          ),
                          Text(
                            allExerciseList[i].exerciseName,
                            style:
                                TextStyle(fontFamily: "Gilroy", fontSize: 23),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 80,
                          ),
                          Text(
                            allExerciseList[i].description,
                            style:
                                TextStyle(fontFamily: "Gilroy", fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//  color: colorList[i], allExerciseList[i].exerciseName, allExerciseList[i].description,
