// This Screen will have the list of all exercises out of which
// the user will chosose exercises for his workout

// import 'package:fiitgn_workouts_1/models/Exercise_db_model.dart';
// import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
// import 'package:fiitgn_workouts_1/models/Workouts_providers.dart';

import '../models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Exercise_db_model.dart';

//////
import '../../Providers/DataProvider.dart';
import '../../Screens/HomeScreen.dart';

import '../models/Admin_db_model.dart';

class Create_Workout2 extends StatefulWidget {
  static const routeName = '\CreateWorkout1';

  @override
  _Create_Workout2State createState() => _Create_Workout2State();
}

class _Create_Workout2State extends State<Create_Workout2> {
  final List<ExerciseDbModel> exercisesSelectedForWorkout = [];
  final List<Color> colorList = [];
  final List<Color> chestColorList = [];
  final List<Color> coreColorList = [];
  final List<Color> backColorList = [];
  final List<Color> legsColorList = [];
  final List<Color> bicepsColorList = [];
  final List<Color> tricepsColorList = [];
  final List<Color> shouldersColorList = [];

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
    String user_email = Data_Provider().email;
    print("user EMAIL ID IS " + user_email);
    if (adminEmailIds.contains(user_email.trim())) {
      print("user is an admin");
      return true;
    }
    print("user is a bitch");
    return false;
  }

  save_workout(
      String workoutName,
      String description,
      String access,
      List<String> exerciseIds,
      List<String> followerIds,
      List<String> ongoingId) async {
    print("save workouts called");
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    String creator_id = Data_Provider().uid;
    String creator_name = Data_Provider().name;
    await workoutDataProvider.createWorkoutAndAddToDB(creator_id, creator_name,
        workoutName, description, access, exerciseIds, followerIds, ongoingId);
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

  void workoutName_Description_Access(
      BuildContext context,
      List<String> listOfExercisesId,
      List<String> listOfFollowersId,
      List<String> listOfOngoingId) {
    print("workoutName_Description_Access called");
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    String access = 'Private';

    final adminDataProvider = Provider.of<GetAdminDataFromGoogleSheetProvider>(
        context,
        listen: false);
    List<String> adminEmailIds = adminDataProvider.getAdminEmailIds();
    print(" got all the details");
    // if (adminEmailIds.contains(workoutDataProvider.user_emailId.trim())) {
    //   print("user is admin");
    // } else {
    //   // print(adminEmailIds[1]);
    //   print("user is not admin");
    // }
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
                                    listOfFollowersId,
                                    listOfOngoingId);
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
                                    listOfFollowersId,
                                    listOfOngoingId);
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
                                listOfFollowersId,
                                listOfOngoingId);
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
    List<String> listOfFollowersId = [];
    List<String> listOfOngoingId = ['alpha'];
    // Map<String, dynamic> map = Map();
    // map['listOfExercisesId'] = listOfExercisesId;
    // map['listOfFollowersId'] = listOfFollowersId;
    print("calling the funcc");
    workoutName_Description_Access(
        context, listOfExercisesId, listOfFollowersId, listOfOngoingId);
    // Navigator.pushNamed(context, Create_Workout1.routeName, arguments: map);
  }

  @override
  Widget build(BuildContext context) {
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

    // print(workoutName + " " + access);
    return DefaultTabController(
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
                  fontSize: 30,
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
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Core",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Shoulder",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Biceps",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Triceps",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Legs",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Back",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => Divider(),
                        itemCount: chestExercises.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
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
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image(
                                      image: NetworkImage(
                                          chestExercises[i].imageUrl),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: chestColorList[i],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Text(
                                        chestExercises[i].exerciseName,
                                        style: TextStyle(
                                            fontFamily: "Gilroy",
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => Divider(),
                        itemCount: coreExercises.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
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
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image(
                                      image: NetworkImage(
                                          coreExercises[i].imageUrl),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: coreColorList[i],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Text(
                                        coreExercises[i].exerciseName,
                                        style: TextStyle(
                                            fontFamily: "Gilroy",
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => Divider(),
                        itemCount: shoulderExercises.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
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
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image(
                                      image: NetworkImage(
                                          shoulderExercises[i].imageUrl),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: shouldersColorList[i],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Text(
                                        shoulderExercises[i].exerciseName,
                                        style: TextStyle(
                                            fontFamily: "Gilroy",
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => Divider(),
                        itemCount: bicepsExercises.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
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
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image(
                                      image: NetworkImage(
                                          bicepsExercises[i].imageUrl),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: bicepsColorList[i],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Text(
                                        bicepsExercises[i].exerciseName,
                                        style: TextStyle(
                                            fontFamily: "Gilroy",
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => Divider(),
                        itemCount: tricepsExercises.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              // print(allExerciseList[i].isWeighted);
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
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image(
                                      image: NetworkImage(
                                          tricepsExercises[i].imageUrl),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: tricepsColorList[i],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Text(
                                        tricepsExercises[i].exerciseName,
                                        style: TextStyle(
                                            fontFamily: "Gilroy",
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => Divider(),
                        itemCount: legsExercises.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
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
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image(
                                      image: NetworkImage(
                                          legsExercises[i].imageUrl),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: legsColorList[i],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Text(
                                        legsExercises[i].exerciseName,
                                        style: TextStyle(
                                            fontFamily: "Gilroy",
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => Divider(),
                        itemCount: backExercises.length,
                        itemBuilder: (ctx, i) {
                          return InkWell(
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
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image(
                                      image: NetworkImage(
                                          backExercises[i].imageUrl),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: backColorList[i],
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Text(
                                        backExercises[i].exerciseName,
                                        style: TextStyle(
                                            fontFamily: "Gilroy",
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
    );
  }
}
