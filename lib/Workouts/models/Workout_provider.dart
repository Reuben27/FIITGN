import 'package:fiitgn/Notifications/utils/removeNotification.dart';
import 'package:fiitgn/Workouts/models/Workout_Data_Log_Model.dart';
import 'package:fiitgn/Workouts/models/Workouts_Log_Model.dart';

import '../../Providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/WorkoutModel.dart';
import '../models/Exercise_db_model.dart';

import '../../Notifications/utils/addNotification.dart';
import '../models/Plan_Model.dart';

class Workouts_Provider with ChangeNotifier {
  // String _userEmailId;
  String _usersCurrentWorkout;

  // final databaseReference = Firestore.instance;

  // TO DO
  // get the lists of workouts for users
  //
  // let user create a workout
  //
  // show the followers for the workouts
  //
  // let user follow a workout
  //
  // let users use specific workouts
  //
  // let workout creators invite people for workout
  //

  List<WorkoutModel> _workoutsList = [];
  List<WorkoutModel> _createdByUser = [];
  List<Workout_Data_Model> _loggedWorkouts = [];

  // set user email id;
  //
  // setUserEmailId(String emailId) {
  //   _userEmailId = emailId;
  //   print("user email id set");
  // }

  List<WorkoutModel> created_by_user() {
    print("created_by_user function has been called");
    List<WorkoutModel> created = [];
    _workoutsList.forEach((element) {
      if (element.creatorId == Data_Provider().uid) {
        print("element match");
        created.add(element);
      } else {
        print("element creator id --> " + element.creatorId);
        print("uid --> " + Data_Provider().uid);
      }
    });
    return created;
  }

  List<WorkoutModel> get workoutList {
    return [..._workoutsList];
  }

  List<Workout_Data_Model> get loggedWorkouts {
    return [..._loggedWorkouts];
  }

  String get userId {
    String uid = Data_Provider().uid;
    return uid;
  }

  String get user_emailId {
    String email = Data_Provider().email;
    return email;
  }

  String get user_name {
    String name = Data_Provider().name;
    return name;
  }

  showAllExercises() {
    final exerciseDataProvider = GetExerciseDataFromGoogleSheetProvider();
    List exercises = exerciseDataProvider.listExercises;
  }

  createWorkoutAndAddToDB(
      String creatorId,
      String creator_name,
      String workoutName,
      String description,
      String access,
      List<String> listOfExercisesId,
      List<String> listOfFollowersId,
      List<String> listOfOngoingId) async {
    // finding the time of creation
    final time = DateTime.now();
    final String dateOfCreationOfWorkout = time.toIso8601String();
    const url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com//Workouts.json";
    var response;
    try {
      response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'creatorId': creatorId,
            'creator_name': creator_name,
            'creationDate': dateOfCreationOfWorkout,
            'workoutName': workoutName,
            'workoutDescription': description,
            'access': access,
            'listOfExercisesId': listOfExercisesId,
            'listOfFollowersId': listOfFollowersId,
            'listOfOngoingId': listOfOngoingId,
          },
        ),
      );
    } catch (e) {
      print("ERROR IN SAVING CREATED WORKOUT TO DB");
      print(e);
    }

    print("%%%%%%%%%%%%%%%%%%%%%");
    print("workout has been added to the Database");
    print("%%%%%%%%%%%%%%%%%%%%%%");
    var workoutId = json.decode(response.body)['name'];
    print(workoutId);
    WorkoutModel newWorkout = WorkoutModel(
        creator_name: creator_name,
        creatorId: creatorId,
        workoutId: workoutId,
        creationDate: dateOfCreationOfWorkout,
        workoutName: workoutName,
        description: description,
        access: access,
        listOfExercisesId: listOfExercisesId,
        listOfFollowersId: listOfFollowersId,
        listOfOnGoingId: listOfOngoingId);
    _workoutsList.add(newWorkout);
    print("%%%%%%%%%%%%%%%%%%%%%");
    print("workouts list has been updated");
    print("%%%%%%%%%%%%%%%%%%%%%");
    notifyListeners();
    // print(newWorkout.listOfExercisesId);

    //  get the list of all exercises
  }

  Future<void> showAllWorkouts() async {
    print("SHOW ALL WORKOUTS CALLED");
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    const url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Workouts.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map;
      print("extracted data");
      print(extractedData);
      final List<WorkoutModel> loadedList = [];
      // print("####");
      // print(extractedData);
      // print("####");
      extractedData.forEach(
        (statId, statValue) {
          // print("1");
          final List<String> tempListExerciseId = [];
          final List<String> tempListFollowersId = [];
          final List<String> tempListOngoingId = [];
          List x = statValue['listOfExercisesId'];
          if (x != null) {
            x.forEach((element) {
              tempListExerciseId.add(element.toString());
            });
            print("templistExerciseId");
            print(tempListExerciseId);
          } else {
            print("x was null");
          }
          // print("2");

          // print("3");
          List y = [];
          y = statValue['listOfFollowersId'];
          if (y != null) {
            y.forEach((element) {
              tempListFollowersId.add(element.toString());
            });
            print("tempListFollowersId");
            print(tempListFollowersId);
          } else {
            print("y was null");
          }
          // print("4");
          List z = statValue['listOfOngoingId'];
          if (z != null) {
            z.forEach((element) {
              tempListOngoingId.add(element.toString());
            });
          } else {
            print("z was null");
          }
          print("tempListOngoingId");
          print(tempListOngoingId);
          print("gammmmma");
          loadedList.add(
            WorkoutModel(
              creator_name: statValue['creator_name'],
              creatorId: statValue['creatorId'],
              workoutId: statId,
              workoutName: statValue['workoutName'],
              description: statValue['workoutDescription'],
              access: statValue['access'],
              creationDate: statValue['creationDate'],
              listOfExercisesId: tempListExerciseId,
              listOfFollowersId: tempListFollowersId,
              listOfOnGoingId: tempListOngoingId,
            ),
          );
          print("deltyaaaaa");
        },
      );
      List<WorkoutModel> filteredList = [];
      List<WorkoutModel> created_by_user = [];
      print("print1");
      print("print1");
      print("print1");
      print("print1");

      loadedList.forEach(
        (element) {
          if (element.access == 'Public' ||
              (element.access == 'Private' &&
                  element.creatorId == Data_Provider().uid.trim())) {
            print("element " +
                element.workoutName +
                " access is " +
                element.access);
            filteredList.add(element);
            if (element.creatorId == userId) {
              created_by_user.add(element);
            }
          }
        },
      );
      print("print2");
      _createdByUser = created_by_user;
      _workoutsList = filteredList;
      notifyListeners();
      print("loaded workout  list is ready");
      // return _workoutsList;
    } catch (e) {
      print("ERROR IN LOADING ALL WORKOUTS");
      print(e);
    }
  }

  Future<void> followWorkout(WorkoutModel workout, String workoutId) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    final url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Workouts/$workoutId.json";
    print(url);
    List followers = workout.listOfFollowersId;
    followers.add(user_uid);
    print(followers);
    // workout.listOfFollowersId.add(user_uid);
    try {
      var x = await http.patch(Uri.parse(url),
          body: json.encode({
            'access': workout.access,
            'creationDate': workout.creationDate,
            'creatorId': workout.creatorId,
            'workoutName': workout.workoutName,
            'listOfExercisesId': workout.listOfExercisesId,
            'listOfFollowersId': followers,
            'listOfOngoingId': workout.listOfOnGoingId,
          }));
      print(x.body);
      print("follower list has been updated");
      WorkoutModel updatedWorkout = WorkoutModel(
        creator_name: workout.creator_name,
        creatorId: workout.creatorId,
        listOfOnGoingId: workout.listOfOnGoingId,
        workoutId: workout.workoutId,
        workoutName: workout.workoutName,
        description: workout.description,
        access: workout.access,
        creationDate: workout.creationDate,
        listOfExercisesId: workout.listOfExercisesId,
        listOfFollowersId: followers,
      );
      int index =
          _workoutsList.indexWhere((element) => element.workoutId == workoutId);
      _workoutsList[index] = updatedWorkout;
      print(_workoutsList[index].listOfFollowersId);
      print("workout saved locally");
      notifyListeners();
    } catch (e) {
      print("ERROR OCCURED");
      print(e);
    }
  }

  Future<void> unFollowWorkout(WorkoutModel workout, String workoutId) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;

    final url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Workouts/$workoutId.json";
    List followers = workout.listOfFollowersId;
    followers.remove(user_uid);
    try {
      var x = await http.patch(Uri.parse(url),
          body: json.encode({
            'access': workout.access,
            'creationDate': workout.creationDate,
            'creatorId': workout.creatorId,
            'workoutName': workout.workoutName,
            'listOfExercisesId': workout.listOfExercisesId,
            'listOfFollowersId': followers,
            'listOfOngoingId': workout.listOfOnGoingId,
          }));

      print(x.body);
      print("user has been unfollowed");
      WorkoutModel updatedWorkout = WorkoutModel(
        creator_name: workout.creator_name,
        creatorId: workout.creatorId,
        workoutId: workout.workoutId,
        workoutName: workout.workoutName,
        listOfOnGoingId: workout.listOfOnGoingId,
        description: workout.description,
        access: workout.access,
        creationDate: workout.creationDate,
        listOfExercisesId: workout.listOfExercisesId,
        listOfFollowersId: followers,
      );
      int index =
          _workoutsList.indexWhere((element) => element.workoutId == workoutId);
      _workoutsList[index] = updatedWorkout;
      print(_workoutsList[index].listOfFollowersId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<WorkoutModel> followedWorkouts() {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    List<WorkoutModel> followedWorkoutsList = [];
    _workoutsList.forEach((element) {
      if (element.listOfFollowersId.contains(user_uid)) {
        followedWorkoutsList.add(element);
      }
    });
    return followedWorkoutsList;
  }

  /// Method to save logged workouts
  saveWorkoutToDb(Workout_Data_Model data) async {
    const url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Logged_Workouts.json";
    var response;
    try {
      final List listOfSetsRepsWeights = [];
      data.listOfSetsRepsWeights.forEach((element) {
        listOfSetsRepsWeights.add({
          'exerciseId': element.exerciseId,
          'exerciseName': element.exerciseName,
          'numOfReps': element.numOfReps,
          'setNumber': element.setNumber,
          'weight': element.weight,
        });
      });
      response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'date': data.date,
          'uid': data.uid,
          'user_name': data.user_name,
          'workoutName': data.workoutName,
          'listOfSetsRepsWeights': listOfSetsRepsWeights,
          'duration_hours': data.duration_hours,
          'duration_minutes': data.duration_minutes,
          'duration_seconds': data.duration_seconds,
        }),
      );
    } catch (e) {
      print("ERROR IN SAVING LOGGED WORKOUT TO DB");
      print(e);
    }
    var databaseId = json.decode(response.body)['name'];
    Workout_Data_Model newLog = Workout_Data_Model(
      duration_seconds: data.duration_seconds,
      duration_hours: data.duration_hours,
      duration_minutes: data.duration_minutes,
      databaseId: databaseId,
      date: data.date,
      listOfSetsRepsWeights: data.listOfSetsRepsWeights,
      uid: data.uid,
      user_name: data.user_name,
      workoutName: data.workoutName,
    );
    _loggedWorkouts.insert(0, newLog);
    print(_loggedWorkouts[0].workoutName);
    print("Saved a log workout successfully");
    notifyListeners();
  }

  getWorkoutLogFromDB() async {
    String uid = Data_Provider().uid;

    final url =
        'https://fiitgn-6aee7-default-rtdb.firebaseio.com/Logged_Workouts.json?orderBy="uid"&equalTo="$uid"';
    try {
      final response = await http.get(Uri.parse(url));
      // print(response);
      final extractedData = json.decode(response.body);
      // print(extractedData);
      // print("@@@@@@");
      List<Workout_Data_Model> fetched_logs = [];
      extractedData.forEach((key, value) {
        String user_uid = value['uid'];
        // print("uid is --> " + user_uid.toString());
        String duration_seconds = value['duration_seconds'];
        String duration_hours = value['duration_hours'];
        String duration_minutes = value['duration_minutes'];
        String databaseId = key;
        String workoutName = value['workoutName'];
        String date = value['date'];
        List setsRepsWeights = value['listOfSetsRepsWeights'];
        List<Workout_Log_Model> listOfSetsRepsWeights = [];
        setsRepsWeights.forEach((element) {
          Workout_Log_Model log = Workout_Log_Model(
            exerciseId: element['exerciseId'],
            exerciseName: element['exerciseName'],
            numOfReps: element['numOfReps'],
            setNumber: element['setNumber'],
            weight: element['weight'],
          );
          listOfSetsRepsWeights.add(log);
        });
        // print("log created");
        Workout_Data_Model logs = Workout_Data_Model(
            duration_seconds: duration_seconds,
            duration_hours: duration_hours,
            duration_minutes: duration_minutes,
            databaseId: databaseId,
            uid: user_uid,
            user_name: user_name,
            workoutName: workoutName,
            date: date,
            listOfSetsRepsWeights: listOfSetsRepsWeights);
        // print("logs created");
        fetched_logs.add(logs);
      });
      _loggedWorkouts = fetched_logs;
      _loggedWorkouts.sort((a, b) {
        return b.date.compareTo(a.date);
      });
      notifyListeners();
      print("recieved workout logs");
    } catch (e) {
      print("error in fetching workouts history data");
      print(e);
    }
  }

//// functions for getting workouts that user has set reminder for
  List<WorkoutModel> ongoingWorkouts() {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    List<WorkoutModel> ongoingWorkoutsList = [];
    _workoutsList.forEach((element) {
      if (element.listOfOnGoingId.contains(user_uid)) {
        ongoingWorkoutsList.add(element);
      }
    });
    return ongoingWorkoutsList;
  }

  Future<void> addWorkoutToOngoingDB(
      WorkoutModel workout, String workoutId, int hour, int min) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    final url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Workouts/$workoutId.json";
    print("add workout to ongoing called");
    print(url);

    List ongoing = workout.listOfOnGoingId;
    ongoing.add(user_uid);
    print(ongoing);
    // workout.listOfFollowersId.add(user_uid);
    try {
      var x = await http.patch(Uri.parse(url),
          body: json.encode({
            'access': workout.access,
            'creationDate': workout.creationDate,
            'creatorId': workout.creatorId,
            'workoutName': workout.workoutName,
            'listOfExercisesId': workout.listOfExercisesId,
            'listOfFollowersId': workout.listOfFollowersId,
            'listOfOngoingId': ongoing,
          }));
      print(x.body);
      print("ongoing list has been updated");
      WorkoutModel updatedWorkout = WorkoutModel(
        creator_name: workout.creator_name,
        creatorId: workout.creatorId,
        workoutId: workout.workoutId,
        workoutName: workout.workoutName,
        description: workout.description,
        access: workout.access,
        creationDate: workout.creationDate,
        listOfExercisesId: workout.listOfExercisesId,
        listOfFollowersId: workout.listOfFollowersId,
        listOfOnGoingId: ongoing,
      );
      int index =
          _workoutsList.indexWhere((element) => element.workoutId == workoutId);
      _workoutsList[index] = updatedWorkout;
      print(_workoutsList[index].listOfOnGoingId);
      print("added workout to Ongoing");
      /////// SETTING NOTIFICATION FOR WORKOUT
      String token = Data_Provider().notif_token;
      try {
        await notiAdd(token, hour, min, workout.workoutName);
      } catch (e) {
        print("error in setting notifs");
        print(e);
      }

      notifyListeners();
    } catch (e) {
      print("ERROR OCCURED");
      print(e);
    }
  }

  Future<void> removeWorkoutFromOngoingDB(
      WorkoutModel workout, String workoutId) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;

    final url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Workouts/$workoutId.json";
    List ongoing = workout.listOfOnGoingId;
    ongoing.remove(user_uid);
    try {
      var x = await http.patch(Uri.parse(url),
          body: json.encode({
            'access': workout.access,
            'creationDate': workout.creationDate,
            'creatorId': workout.creatorId,
            'workoutName': workout.workoutName,
            'listOfExercisesId': workout.listOfExercisesId,
            'listOfFollowersId': workout.listOfFollowersId,
            'listOfOngoingId': ongoing,
          }));

      print(x.body);
      print("user has been unfollowed");
      WorkoutModel updatedWorkout = WorkoutModel(
        creator_name: workout.creator_name,
        creatorId: workout.creatorId,
        workoutId: workout.workoutId,
        workoutName: workout.workoutName,
        description: workout.description,
        access: workout.access,
        creationDate: workout.creationDate,
        listOfExercisesId: workout.listOfExercisesId,
        listOfFollowersId: workout.listOfFollowersId,
        listOfOnGoingId: ongoing,
      );
      int index =
          _workoutsList.indexWhere((element) => element.workoutId == workoutId);
      _workoutsList[index] = updatedWorkout;
      print(_workoutsList[index].listOfOnGoingId);
      try {
        String token = Data_Provider().notif_token;
        await notiRemove(token, workout.workoutName);
        print("notification successfully removed ");
      } catch (e) {
        print("error in removing notifs");
        print(e);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

/////////////////////////////////////////////////////
  ///PLAN SECTION
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
  ///PLAN SECTION
//////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///PLAN SECTION
//////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///PLAN SECTION
//////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///PLAN SECTION
//////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///PLAN SECTION
/////////////////////////////////////////////////////
  ///
  String _currentPlan;
  List<PlanModel> _plansList = [];
  List<PlanModel> _plansCreatedByUser = [];

  List<PlanModel> plans_created_by_user() {
    print(" plan created_by_user function has been called");
    List<PlanModel> created = [];
    _plansList.forEach((element) {
      if (element.creatorId == Data_Provider().uid) {
        print("element match");
        created.add(element);
      } else {
        print("element creator id --> " + element.creatorId);
        print("uid --> " + Data_Provider().uid);
      }
    });
    return created;
  }

  List<PlanModel> get plansList {
    return [..._plansList];
  }

  createPlanAndAddToDB(
      String creatorId,
      String creator_name,
      String planName,
      int numberOfWeeks,
      String description,
      String access,
      List<List<WorkoutModel>> listOfPlans,
      List<String> listOfFollowersId,
      List<String> listOfOngoingId) async {
    // finding the time of creation
    final time = DateTime.now();
    final String dateOfCreationOfWorkout = time.toIso8601String();
    const url = "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Plans.json";
    var response;
    // creating corresponding json for listOfPlans
    List<List<dynamic>> converted_listOfPlans = [];
    for (int i = 0; i < listOfPlans.length; i++) {
      converted_listOfPlans.add([]);
      for (int j = 0; j < listOfPlans[0].length; j++) {
        WorkoutModel currentWorkout = listOfPlans[i][j];
        Map convertedWorkout = currentWorkout.toJson();
        converted_listOfPlans[i].add(jsonEncode(convertedWorkout));
      }
    }
    try {
      response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'numberOfWeeks': numberOfWeeks,
            'creatorId': creatorId,
            'creator_name': creator_name,
            'creationDate': dateOfCreationOfWorkout,
            'planName': planName,
            'description': description,
            'access': access,
            'listOfPlans':
                converted_listOfPlans, // by itself has custom objects which have to be flattened
            'listOfFollowersId': listOfFollowersId,
            'listOfOngoingId': listOfOngoingId,
          },
        ),
      );
    } catch (e) {
      print("ERROR IN SAVING CREATED WORKOUT TO DB");
      print(e);
    }
    print("%%%%%%%%%%%%%%%%%%%%%");
    print("plan has been added to the Database");
    print("%%%%%%%%%%%%%%%%%%%%%%");
    var planId = json.decode(response.body)['name'];
    print(planId);
    PlanModel newPlan = PlanModel(
        numberOfWeeks: numberOfWeeks,
        access: access,
        creationDate: dateOfCreationOfWorkout,
        creatorId: creatorId,
        creator_name: creator_name,
        description: description,
        listOfFollowersId: listOfFollowersId,
        listOfOnGoingId: listOfOngoingId,
        planId: planId,
        planName: planName,
        imageUrl: url,
        listOfPlans: listOfPlans);
    _plansList.add(newPlan);
    print("%%%%%%%%%%%%%%%%%%%%%");
    print("plans list has been updated");
    print("%%%%%%%%%%%%%%%%%%%%%");
    // notifyListeners();
    // print(newWorkout.listOfExercisesId);

    //  get the list of all exercises
  }

  Future<void> showAllPlans() async {
    print("SHOW ALL plans CALLED");
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    const url = "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Plans.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map;
      print("extracted data");
      print(extractedData);
      final List<PlanModel> loadedPlans = [];
      final List<WorkoutModel> loadedList = [];
      // print("####");
      // print(extractedData);
      // print("####");
      extractedData.forEach(
        (statId, statValue) {
          final List<String> tempListFollowersId = [];
          final List<String> tempListOngoingId = [];
          List y = [];
          y = statValue['listOfFollowersId'];
          if (y != null) {
            y.forEach((element) {
              tempListFollowersId.add(element.toString());
            });
          } else {
            print("y was null");
          }
          List z = statValue['listOfOngoingId'];
          if (z != null) {
            z.forEach((element) {
              tempListOngoingId.add(element.toString());
            });
          } else {
            print("z was null");
          }
          print("gammmmma");
          List<List<WorkoutModel>> listOfPlans = [];
          print("gammmmma2");
          extractedData.forEach((statId, statValue) {
            print("gamma3");
            print(statValue['listOfPlans'].runtimeType);
            print(statValue['listOfPlans']);
            List<dynamic> temp = statValue['listOfPlans'];
            print(temp);
            print("gamma4");
            if (temp != null) {
              print("gamma5");
              for (int i = 0; i < temp.length; i++) {
                listOfPlans.add([]);
                print("gamma6");
                for (int j = 0; j < temp[0].length; j++) {
                  print(temp[i][j]);
                  print("gamma7");
                  listOfPlans[i]
                      .add(WorkoutModel.fromJson(json.decode(temp[i][j])));
                  print("gamma8");
                }
              }
            } else {
              print("temp was null");
            }
          });
          loadedPlans.add(
            PlanModel(
              numberOfWeeks: statValue['numberOfWeeks'],
              listOfPlans: listOfPlans,
              creator_name: statValue['creator_name'],
              creatorId: statValue['creatorId'],
              planId: statId,
              planName: statValue['planName'],
              description: statValue['description'],
              access: statValue['access'],
              creationDate: statValue['creationDate'],
              listOfFollowersId: tempListFollowersId,
              listOfOnGoingId: tempListOngoingId,
            ),
          );
          print("deltaaaaa");
        },
      );
      List<PlanModel> filteredPlansList = [];
      List<PlanModel> plans_created_by_user = [];
      print("print1");
      print("print1");
      print("print1");
      print("print1");
      print(loadedPlans);
      loadedPlans.forEach(
        (element) {
          if (element.access == 'Public' ||
              (element.access == 'Private' &&
                  element.creatorId == Data_Provider().uid.trim())) {
            print(
                "element " + element.planName + " access is " + element.access);
            filteredPlansList.add(element);
            if (element.creatorId == userId) {
              plans_created_by_user.add(element);
            }
          }
        },
      );
      print("print2");
      _plansCreatedByUser = plans_created_by_user;
      _plansList = filteredPlansList;
      notifyListeners();
      print("loaded plans list is ready");
      print(_plansCreatedByUser);
      // return _workoutsList;
    } catch (e) {
      print("ERROR IN LOADING ALL WORKOUTS FOR PLANS");
      print(e);
    }
  }

  Future<void> followPlan(PlanModel plan, String planId) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    final url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Plans/$planId.json";
    print(url);
    List followers = plan.listOfFollowersId;
    followers.add(user_uid);
    print(followers);
    // workout.listOfFollowersId.add(user_uid);
    try {
      var x = await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'numberOfWeeks': plan.numberOfWeeks,
            'creatorId': plan.creatorId,
            'creator_name': plan.creator_name,
            'creationDate': plan.creationDate,
            'planName': plan.planName,
            'workoutDescription': plan.description,
            'access': plan.access,
            'listOfPlans': plan
                .listOfPlans, // by itself has custom objects which have to be flattened
            'listOfFollowersId': followers,
            'listOfOngoingId': plan.listOfOnGoingId,
          },
        ),
      );
      print(x.body);
      print("follower list has been updated");
      PlanModel updatedPlan = PlanModel(
        numberOfWeeks: plan.numberOfWeeks,
        creator_name: plan.creator_name,
        creatorId: plan.creatorId,
        listOfOnGoingId: plan.listOfOnGoingId,
        planId: plan.planId,
        planName: plan.planName,
        description: plan.description,
        access: plan.access,
        creationDate: plan.creationDate,
        listOfPlans: plan.listOfPlans,
        listOfFollowersId: followers,
      );
      int index = _plansList.indexWhere((element) => element.planId == planId);
      _plansList[index] = updatedPlan;
      print(_plansList[index].listOfFollowersId);
      print("plan saved locally");
      notifyListeners();
    } catch (e) {
      print("ERROR OCCURED");
      print(e);
    }
  }

  Future<void> unFollowPlan(PlanModel plan, String planId) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;

    final url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Plans/$planId.json";
    List followers = plan.listOfFollowersId;
    followers.remove(user_uid);
    try {
      var x = await http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'numberOfWeeks': plan.numberOfWeeks,
            'creatorId': plan.creatorId,
            'creator_name': plan.creator_name,
            'creationDate': plan.creationDate,
            'planName': plan.planName,
            'workoutDescription': plan.description,
            'access': plan.access,
            'listOfPlans': plan
                .listOfPlans, // by itself has custom objects which have to be flattened
            'listOfFollowersId': followers,
            'listOfOngoingId': plan.listOfOnGoingId,
          },
        ),
      );

      print(x.body);
      print("user has been unfollowed");
      PlanModel updatedPlan = PlanModel(
        numberOfWeeks: plan.numberOfWeeks,
        creator_name: plan.creator_name,
        creatorId: plan.creatorId,
        listOfOnGoingId: plan.listOfOnGoingId,
        planId: plan.planId,
        planName: plan.planName,
        description: plan.description,
        access: plan.access,
        creationDate: plan.creationDate,
        listOfPlans: plan.listOfPlans,
        listOfFollowersId: followers,
      );
      int index = _plansList.indexWhere((element) => element.planId == planId);
      _plansList[index] = updatedPlan;
      print(_plansList[index].listOfFollowersId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<PlanModel> followedPlans() {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    List<PlanModel> followedPlansList = [];
    _plansList.forEach((element) {
      if (element.listOfFollowersId.contains(user_uid)) {
        followedPlansList.add(element);
      }
    });
    return followedPlansList;
  }

  //// functions for getting plans that user has set reminder for
  List<PlanModel> ongoingPlans() {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    List<PlanModel> ongoingPlansList = [];
    _plansList.forEach((element) {
      if (element.listOfOnGoingId.contains(user_uid)) {
        ongoingPlansList.add(element);
      }
    });
    return ongoingPlansList;
  }

  Future<void> addPlanToOngoingDB(
      PlanModel plan, String planId, int hour, int min) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    final url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Plans/$planId.json";
    print("add plan to ongoing called");
    print(url);

    List ongoing = plan.listOfOnGoingId;
    ongoing.add(user_uid);
    print(ongoing);
    // workout.listOfFollowersId.add(user_uid);
    try {
      var x = await http.patch(Uri.parse(url),
          body: json.encode(
            {
              'numberOfWeeks': plan.numberOfWeeks,
              'creatorId': plan.creatorId,
              'creator_name': plan.creator_name,
              'creationDate': plan.creationDate,
              'planName': plan.planName,
              'workoutDescription': plan.description,
              'access': plan.access,
              'listOfPlans': plan
                  .listOfPlans, // by itself has custom objects which have to be flattened
              'listOfFollowersId': plan.listOfFollowersId,
              'listOfOngoingId': ongoing,
            },
          ));
      print(x.body);
      print("ongoing list has been updated");
      PlanModel updatedPlan = PlanModel(
        numberOfWeeks: plan.numberOfWeeks,
        creator_name: plan.creator_name,
        creatorId: plan.creatorId,
        listOfOnGoingId: ongoing,
        planId: plan.planId,
        planName: plan.planName,
        description: plan.description,
        access: plan.access,
        creationDate: plan.creationDate,
        listOfPlans: plan.listOfPlans,
        listOfFollowersId: plan.listOfFollowersId,
      );
      int index = _plansList.indexWhere((element) => element.planId == planId);
      _plansList[index] = updatedPlan;
      print(_plansList[index].listOfOnGoingId);
      print("added plan to Ongoing");
      /////// SETTING NOTIFICATION FOR PLAN
      String token = Data_Provider().notif_token;
      try {
        await notiAdd(token, hour, min, plan.planName);
      } catch (e) {
        print("error in setting notifs");
        print(e);
      }
      notifyListeners();
    } catch (e) {
      print("ERROR OCCURED");
      print(e);
    }
  }

  Future<void> removePlanFromOngoingDB(PlanModel plan, String planId) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;

    final url =
        "https://fiitgn-6aee7-default-rtdb.firebaseio.com/Plans/$planId.json";
    List ongoing = plan.listOfFollowersId;
    ongoing.remove(user_uid);
    try {
      var x = await http.patch(Uri.parse(url),
          body: json.encode(
            {
              'numberOfWeeks': plan.numberOfWeeks,
              'creatorId': plan.creatorId,
              'creator_name': plan.creator_name,
              'creationDate': plan.creationDate,
              'planName': plan.planName,
              'workoutDescription': plan.description,
              'access': plan.access,
              'listOfPlans': plan
                  .listOfPlans, // by itself has custom objects which have to be flattened
              'listOfFollowersId': plan.listOfFollowersId,
              'listOfOngoingId': ongoing,
            },
          ));

      print(x.body);
      print("user has been unfollowed");
      PlanModel updatedPlan = PlanModel(
        numberOfWeeks: plan.numberOfWeeks,
        creator_name: plan.creator_name,
        creatorId: plan.creatorId,
        listOfOnGoingId: ongoing,
        planId: plan.planId,
        planName: plan.planName,
        description: plan.description,
        access: plan.access,
        creationDate: plan.creationDate,
        listOfPlans: plan.listOfPlans,
        listOfFollowersId: plan.listOfFollowersId,
      );
      int index = _plansList.indexWhere((element) => element.planId == planId);
      _plansList[index] = updatedPlan;
      print(_plansList[index].listOfOnGoingId);
      print("added plan to Ongoing");
      try {
        String token = Data_Provider().notif_token;
        await notiRemove(token, plan.planName);
        print("notification successfully removed for plan " + plan.planName);
      } catch (e) {
        print("error in removing notifs");
        print(e);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
