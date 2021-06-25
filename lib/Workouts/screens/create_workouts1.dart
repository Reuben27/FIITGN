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

//////
import '../../Providers/DataProvider.dart';
import '../../Screens/HomeScreen.dart';

import '../models/Admin_db_model.dart';
import '../models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_workouts1.dart';

class Create_Workout2 extends StatefulWidget {
  static const routeName = '\CreateWorkout1';

  @override
  _Create_Workout2State createState() => _Create_Workout2State();
}

class _Create_Workout2State extends State<Create_Workout2> {
  final List<ExerciseDbModel> exercisesSelectedForWorkout = [];
  final List<Color> colorList = [];

  // Widget take_workout_name(TextEditingController nameController) {
  //   return Center(
  //     child: TextField(
  //       controller: nameController,
  //       decoration: InputDecoration(
  //         hintText: 'Enter the name of Workout',
  //       ),
  //     ),
  //     heightFactor: 1,
  //   );
  // }

  // Widget take_workout_description(TextEditingController desc_controller) {
  //   return Center(
  //     child: TextField(
  //       controller: desc_controller,
  //       decoration: InputDecoration(
  //         hintText: 'Enter Description',
  //       ),
  //     ),
  //     heightFactor: 1,
  //   );
  // }

  bool is_admin(List<String> adminEmailIds) {
    print("is_admin called");
    String user_id = Data_Provider().uid;
    if (adminEmailIds.contains(user_id.trim())) {
      print("user is an admin");
      return true;
    }
    print("user is a bitch");
    return false;
  }

  save_workout(String workoutName, String description, String access,
      List<String> exerciseIds, List<String> followerIds) async {
    print("save workouts called");
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    String creator_id = Data_Provider().uid;
    String creator_name = Data_Provider().name;
    await workoutDataProvider.createWorkoutAndAddToDB(
      creator_id,
      creator_name,
      workoutName,
      description,
      access,
      exerciseIds,
      followerIds,
    );
    print("workout saved");
    Navigator.pop(context, true);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  // applicable only to Admins
  // Widget who_can_see(String workoutName, String description, String access,
  //     List<String> exerciseIds, List<String> followerIds) {
  //   // print("who can see called");
  //   return Row(
  //     children: [
  //       RaisedButton(
  //           child: Text('Everyone'),
  //           onPressed: () {
  //             access = 'Public';
  //             save_workout(
  //                 workoutName, description, access, exerciseIds, followerIds);
  //           }),
  //       RaisedButton(
  //         child: Text('Only me'),
  //         onPressed: () {
  //           access = 'Private';
  //         },
  //       )
  //     ],
  //   );
  // }

  void workoutName_Description_Access(BuildContext context,
      List<String> listOfExercisesId, List<String> listOfFollowersId) {
    print("workoutName_Description_Access called");
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    String access = 'Private';

    final adminDataProvider = Provider.of<GetAdminDataFromGoogleSheetProvider>(
        context,
        listen: false);
    List<String> adminEmailIds = adminDataProvider.getAdminEmailIds();
    print(" got all the details");
    showDialog(
      context: context,
      builder: (ctx) {
        print("show dialog initialized");
        return AlertDialog(
          title: Text('Workout Description'),
          actions: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //// TAKING WORKOUT NAME
                  Center(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter the name of Workout',
                      ),
                    ),
                    heightFactor: 1,
                  ),
                  // take_workout_name(nameController),
                  //// TAKING WORKOUT DESCRIPTION
                  Center(
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter Description',
                      ),
                    ),
                    heightFactor: 1,
                  ),
                  ///// ##if is admin,
                  is_admin(adminEmailIds)

                      /// ##Asking if workout should be public or private and saving it
                      ? Row(
                          children: [
                            RaisedButton(
                              child: Text('Everyone'),
                              onPressed: () {
                                print("alpha alpha alpha");
                                access = 'Public';
                                save_workout(
                                    nameController.text.trim(),
                                    descriptionController.text.trim(),
                                    access,
                                    listOfExercisesId,
                                    listOfFollowersId);
                              },
                            ),
                            RaisedButton(
                              child: Text('Only me'),
                              onPressed: () {
                                access = 'Private';
                                save_workout(
                                    nameController.text.trim(),
                                    descriptionController.text.trim(),
                                    access,
                                    listOfExercisesId,
                                    listOfFollowersId);
                                // Navigator.of(context).pop(true);
                                // Navigator.of(context).pop(true);
                              },
                            )
                          ],
                        )
                      :
                      /////## Save workout as private as non admin
                      RaisedButton(
                          child: Text('Save workout'),
                          onPressed: () {
                            access = 'Private';
                            save_workout(
                                nameController.text.trim(),
                                descriptionController.text.trim(),
                                access,
                                listOfExercisesId,
                                listOfFollowersId);
                          },
                        ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  onTapSave() async {
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    List<String> listOfExercisesId = [];
    exercisesSelectedForWorkout.forEach((element) {
      listOfExercisesId.add(element.exerciseId);
    });

    String creatorId = workoutDataProvider.userId;
    String creator_name = workoutDataProvider.user_name;
    List<String> listOfFollowersId = [creatorId];
    // Map<String, dynamic> map = Map();
    // map['listOfExercisesId'] = listOfExercisesId;
    // map['listOfFollowersId'] = listOfFollowersId;
    print("calling the funcc");
    await workoutName_Description_Access(
        context, listOfExercisesId, listOfFollowersId);
    // Navigator.pushNamed(context, Create_Workout1.routeName, arguments: map);
  }

  @override
  Widget build(BuildContext context) {
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);
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
            onTap: onTapSave,
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
                    // print(allExerciseList[i].isWeighted);
                    if (!exercisesSelectedForWorkout
                        .contains(allExerciseList[i])) {
                      Color color = Colors.green;
                      exercisesSelectedForWorkout.add(allExerciseList[i]);
                      // print("exercise " +
                      // allExerciseList[i].exerciseName +
                      // " added");
                      setState(() {
                        // print('colorChange!');
                        colorList[i] = color;
                        // print(colorList[i].toString());
                      });
                    } else {
                      Color color = Colors.grey[200];
                      exercisesSelectedForWorkout.remove(allExerciseList[i]);
                      // print("exercise " +
                      // allExerciseList[i].exerciseName +

                      // " removed");
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