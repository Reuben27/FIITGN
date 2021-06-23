// This Screen has code to take input for the name of the Workout
// Will later also ask for description and image and stuff

import '../../Providers/DataProvider.dart';
import '../../Screens/HomeScreen.dart';

import '../models/Admin_db_model.dart';
import '../models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_workouts1.dart';

class Create_Workout1 extends StatefulWidget {
  static const routeName = '\Create_Workout2';
  @override
  _Create_Workout1State createState() => _Create_Workout1State();
}

class _Create_Workout1State extends State<Create_Workout1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // TO DO
//   Dispose the text Controllers

  final textController = TextEditingController();
  final descriptionController = TextEditingController();
  String access = 'Private';
  String workoutName = 'Null';
  @override
  Widget build(BuildContext context) {
    // print("t1");
    final adminDataProvider =
        Provider.of<GetAdminDataFromGoogleSheetProvider>(context);
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    // print("t2");
    List adminEmailIds = adminDataProvider.getAdminEmailIds();
    // print("t3");
    // print(adminEmailIds);
    if (adminEmailIds.contains(workoutDataProvider.user_emailId.trim())) {
      print("user is admin");
    } else {
      // print(adminEmailIds[1]);
      print("user is not admin");
    }

    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    List<String> listOfExercisesId = routeArgs['listOfExercisesId'] as List;
    List<String> listOfFollowersId = routeArgs['listOfFollowersId'] as List;
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter the name of Workout',
              ),
            ),
            heightFactor: 1,
          ),
          Center(
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter Description',
              ),
            ),
            heightFactor: 1,
          ),

          adminEmailIds.contains(workoutDataProvider.user_emailId.trim())
              ? Column(
                  children: [
                    Text(
                      'Who can view the workout?',
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: () {
                             workoutName = textController.text;
                              print(workoutName);
                            access = 'Public';
                            String description = descriptionController.text;
                            String creatorId = Data_Provider().uid;
                            String creator_name = Data_Provider().name;
                            workoutDataProvider.createWorkoutAndAddToDB(
                              creatorId,
                              creator_name,
                              workoutName,
                              description,
                              access,
                              listOfExercisesId,
                              listOfFollowersId,
                            );
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
          
                          },
                          child: Text('Everyone'),
                        ),
                        RaisedButton(
                            onPressed: () {
                    workoutName = textController.text;
                    print(workoutName);
                    access = 'Private';
                    String description = descriptionController.text;
                    String creatorId = Data_Provider().uid;
                    String creator_name = Data_Provider().name;
                    workoutDataProvider.createWorkoutAndAddToDB(
                      creatorId,
                      creator_name,
                      workoutName,
                      description,
                      access,
                      listOfExercisesId,
                      listOfFollowersId,
                    );
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
                  },
                     
                          child: Text('Only me'),
                        ),
                      ],
                    )
                  ],
                )
              : RaisedButton(
                  onPressed: () {
                    workoutName = textController.text;
                    access = 'Private';
                    String description = descriptionController.text;
                    String creatorId = Data_Provider().uid;
                    String creator_name = Data_Provider().name;
                    workoutDataProvider.createWorkoutAndAddToDB(
                      creatorId,
                      creator_name,
                      workoutName,
                      description,
                      access,
                      listOfExercisesId,
                      listOfFollowersId,
                    );
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
                  },
                  child: Text('Save'),
                ),
          // RaisedButton(
          //   onPressed: () {
          //     userEmailId = textController.text;
          //     workoutDataProvider.setUserEmailId(userEmailId);
          //     print(userEmailId);
          //     Navigator.pushReplacementNamed(context, MainScreen.routeName);
          //   },
          //   child: Text('Done'),
          // ),
        ],
      ),
    );
  }
}
