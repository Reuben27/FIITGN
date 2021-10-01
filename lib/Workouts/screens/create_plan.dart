import 'package:fiitgn/Providers/DataProvider.dart';
import 'package:fiitgn/Screens/HomeScreen.dart';
import 'package:fiitgn/Workouts/Widgets/create_passer.dart';
import 'package:fiitgn/Workouts/models/WorkoutModel.dart';
import 'package:fiitgn/Workouts/models/Workout_provider.dart';
import 'package:fiitgn/Workouts/screens/explore_workouts_plan_plan.dart';
import 'package:fiitgn/Workouts/screens/plan_plan_create_create_workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePlan extends StatefulWidget {
  static const routeName = 'createPlan';
  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  undoFunc(int dayNum, CreateArguments routeArgs) {
    String day = dayNum.toString();
    routeArgs.workoutsForDays.remove(day);
    setState(() {});
  }
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
      var _screenHeight,
      var _screenWidth,
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
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        print("show dialog initialized");
        return Container(
          color: Colors.blueGrey[200],
          child: Container(
            margin: EdgeInsets.only(
              top: 0.03 * _screenHeight,
              left: 0.03 * _screenWidth,
              right: 0.03 * _screenWidth,
            ),
            child: Column(
              // title: Text('Workout Description'),
              children: [
                Text(
                  'Workout Details',
                  textScaleFactor: 0.8,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 0.04 * _screenHeight,
                      fontFamily: 'Gilroy'),
                ),

                //// TAKING WORKOUT NAME
                Center(
                  child: TextField(
                    style: TextStyle(fontFamily: 'Gilroy'),
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  heightFactor: 1,
                ),
                // take_workout_name(nameController),
                //// TAKING WORKOUT DESCRIPTION
                Center(
                  child: TextField(
                    style: TextStyle(fontFamily: 'Gilroy'),
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                  heightFactor: 1,
                ),
                ///// ##if is admin,
                is_admin(adminEmailIds)

                    /// ##Asking if workout should be public or private and saving it
                    ? Column(
                        children: [
                          Container(
                            width: 0.3 * _screenWidth,
                            child: OutlinedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Public",
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 0.025 * _screenHeight,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
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
                                // print("i= " + index.toString());
                              },
                            ),
                          ),
                          Container(
                            width: 0.3 * _screenWidth,
                            child: OutlinedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Private",
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 0.025 * _screenHeight,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              onPressed: () {
                                access = 'Private';
                                save_workout(
                                    nameController.text.trim(),
                                    descriptionController.text.trim(),
                                    access,
                                    listOfExercisesId,
                                    listOfFollowersId,
                                    listOfOngoingId);
                                // print("i= " + index.toString());
                              },
                            ),
                          ),
                        ],
                      )
                    :
                    /////## Save workout as private as non admin
                    Container(
                        width: 0.3 * _screenWidth,
                        child: OutlinedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Save",
                                textScaleFactor: 0.8,
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 0.025 * _screenHeight,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.save_outlined,
                                color: Colors.black,
                              )
                            ],
                          ),
                          onPressed: () {
                            access = 'Private';
                            save_workout(
                                nameController.text.trim(),
                                descriptionController.text.trim(),
                                access,
                                listOfExercisesId,
                                listOfFollowersId,
                                listOfOngoingId);
                            // print("i= " + index.toString());
                          },
                        ),
                      ),
              ],
            ),
          ),
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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    String creatorId = workoutDataProvider.userId;
    String creator_name = workoutDataProvider.user_name;
    List<String> listOfFollowersId = ['alpha'];
    List<String> listOfOngoingId = ['alpha'];
    // Map<String, dynamic> map = Map();
    // map['listOfExercisesId'] = listOfExercisesId;
    // map['listOfFollowersId'] = listOfFollowersId;
    print("calling the funcc");
    workoutName_Description_Access(_screenHeight, _screenWidth, context,
        listOfExercisesId, listOfFollowersId, listOfOngoingId);
    // Navigator.pushNamed(context, Create_Workout1.routeName, arguments: map);
  }

  @override
  Widget build(BuildContext context) {
    final CreateArguments routeArgs =
        ModalRoute.of(context).settings.arguments as CreateArguments;

    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    print(routeArgs);
    print("routeArgs.dayNumber is ");
    print(routeArgs.getDayNum());
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
          final nameController = TextEditingController();
    final descriptionController = TextEditingController();
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
  
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF93B5C6),
          child: Icon(Icons.save),
           onPressed: 
    



          () async {
            List<List<WorkoutModel>> listOfPlans =
                CreateArguments.returnListWorkouts(routeArgs);
            List<String> listOfFollowersId = ['alpha'];
            List<String> listOfOngoingId = ['alpha'];
            String creatorId = Data_Provider().uid;
            String creatorName = Data_Provider().name;
            
            String access = 'Private';
             showModalBottomSheet(
      context: context,
      builder: (ctx) {
        print("show dialog initialized");
        return Container(
          color: Colors.blueGrey[200],
          child: Container(
            margin: EdgeInsets.only(
              top: 0.03 * _screenHeight,
              left: 0.03 * _screenWidth,
              right: 0.03 * _screenWidth,
            ),
            child: Column(
              // title: Text('Workout Description'),
              children: [
                Text(
                  'Workout Details',
                  textScaleFactor: 0.8,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 0.04 * _screenHeight,
                      fontFamily: 'Gilroy'),
                ),

                //// TAKING WORKOUT NAME
                Center(
                  child: TextField(
                    style: TextStyle(fontFamily: 'Gilroy'),
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  heightFactor: 1,
                ),
                // take_workout_name(nameController),
                //// TAKING WORKOUT DESCRIPTION
                Center(
                  child: TextField(
                    style: TextStyle(fontFamily: 'Gilroy'),
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                  heightFactor: 1,
                ),
                 
                ///// ##if is admin,
                is_admin(adminEmailIds)

                    /// ##Asking if workout should be public or private and saving it
                    ? Column(
                        children: [
                          Container(
                            width: 0.3 * _screenWidth,
                            child: OutlinedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Public",
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 0.025 * _screenHeight,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.people_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              onPressed: () {
                                String planName =nameController.text.trim();
            String description = descriptionController.text.trim();
                                print("alpha alpha alpha");
                                access = 'Public';
                               workoutDataProvider.createPlanAndAddToDB(
                creatorId,
                creatorName,
                planName,
                1,
                description,
                access,
                listOfPlans,
                listOfFollowersId,
                listOfOngoingId);
                                // print("i= " + index.toString());
                              },
                            ),
                          ),
                          Container(
                            width: 0.3 * _screenWidth,
                            child: OutlinedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Private",
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 0.025 * _screenHeight,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              onPressed: () {
                                String planName =nameController.text.trim();
            String description = descriptionController.text.trim();
                                access = 'Private';
                                workoutDataProvider.createPlanAndAddToDB(
                creatorId,
                creatorName,
                planName,
                1,
                description,
                access,
                listOfPlans,
                listOfFollowersId,
                listOfOngoingId);
                                // print("i= " + index.toString());
                              },
                            ),
                          ),
                        ],
                      )
                    :
                    /////## Save workout as private as non admin
                    Container(
                        width: 0.3 * _screenWidth,
                        child: OutlinedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Save",
                                textScaleFactor: 0.8,
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 0.025 * _screenHeight,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.save_outlined,
                                color: Colors.black,
                              )
                            ],
                          ),
                          onPressed: () {
                            String planName =nameController.text.trim();
            String description = descriptionController.text.trim();
                            access = 'Private';
                            workoutDataProvider.createPlanAndAddToDB(
                creatorId,
                creatorName,
                planName,
                1,
                description,
                access,
                listOfPlans,
                listOfFollowersId,
                listOfOngoingId);
                            // print("i= " + index.toString());
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
   
            await workoutDataProvider.createPlanAndAddToDB(
                creatorId,
                creatorName,
                planName,
                1,
                description,
                access,
                listOfPlans,
                listOfFollowersId,
                listOfOngoingId);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },


          // DO NOT DELETE THIS IS PREV CODE




        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF93B5C6),
          title: Text(
            'CREATE PLAN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: Container(
          height: _screenHeight,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (ctx, j) => Container(
                      margin: EdgeInsets.only(
                        top: 0.00625 * _screenHeight,
                        bottom: 0.00625 * _screenHeight,
                        left: 0.03 * _screenWidth,
                        right: 0.03 * _screenWidth,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(0.02 * _screenHeight),
                        color: Color(0xFFC9CCD5),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 0.0125 * _screenHeight,
                          bottom: 0.0125 * _screenHeight,
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Day " + (j + 1).toString(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.03 * _screenHeight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: routeArgs.workoutsForDays
                                          .containsKey((j + 1).toString()) ==
                                      false // doesnt contain that data
                                  ? [
                                      OutlinedButton(
                                        onPressed: () {
                                          routeArgs.dayNum = j + 1;
                                          Navigator.pushReplacementNamed(
                                              context,
                                              Create_Workout_for_Plan.routeName,
                                              arguments: routeArgs);
                                        },
                                        child: Text(
                                          "CREATE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Colors.black),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          routeArgs.dayNum = j + 1;
                                          Navigator.pushReplacementNamed(
                                              context,
                                              Explore_Workouts_For_Plan
                                                  .routeName,
                                              arguments: routeArgs);
                                        },
                                        child: Text(
                                          "EXPLORE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Colors.black),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          routeArgs.dayNum = j + 1;
                                          routeArgs.workoutsForDays[
                                                  routeArgs.dayNum.toString()] =
                                              CreateArguments.rest_model;
                                          setState(() {});
                                        },
                                        child: Text(
                                          "REST DAY",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Colors.black),
                                        ),
                                      ),
                                    ]
                                  : [
                                      Text(
                                        'Selected',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gilroy',
                                            color: Colors.black),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          undoFunc(j + 1, routeArgs);
                                        },
                                        child: Text(
                                          "UNDO",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
