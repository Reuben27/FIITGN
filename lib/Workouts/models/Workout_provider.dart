import 'package:fiitgn/Notifications/utils/removeNotification.dart';
import 'package:fiitgn/Workouts/models/Workout_Data_Log_Model.dart';

import '../../Providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/WorkoutModel.dart';
import '../models/Exercise_db_model.dart';

import '../../Notifications/utils/addNotification.dart';

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
  // List<WorkoutModel> get created_by_user {
  //   return _createdByUser;
  // }

  List<WorkoutModel> get workoutList {
    return [..._workoutsList];
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

  savestuffFromCW1() {}

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
      final List<WorkoutModel> loadedList = [];

      extractedData.forEach(
        (statId, statValue) {
          final List<String> tempListExerciseId = [];
          final List<String> tempListFollowersId = [];
          final List<String> tempListOngoingId = [];
          List x = statValue['listOfExercisesId'];
          x.forEach((element) {
            tempListExerciseId.add(element.toString());
          });
          List y = statValue['listOfFollowersId'];
          y.forEach((element) {
            tempListFollowersId.add(element.toString());
          });
          List z = statValue['listOfOngoingId'];
          z.forEach((element) {
            tempListOngoingId.add(element.toString());
          });
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
        },
      );
      List<WorkoutModel> filteredList = [];
      loadedList.forEach(
        (element) {
          if (element.access == 'Public' ||
              (element.access == 'Private' &&
                  element.listOfFollowersId.contains(user_uid))) {
            filteredList.add(element);
            if (element.creatorId == userId) {
              _createdByUser.add(element);
            }
          }
        },
      );
      _workoutsList = filteredList;
      notifyListeners();
      print("loaded list is ready");
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
    _loggedWorkouts.add(newLog);
    print("Saved a log workout successfully");
    notifyListeners();
  }

//// functions for getting workouts that user has set reminder for
  ///
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
      // print("add workout to ongoing called");

      WorkoutModel workout,
      String workoutId,
      int hour,
      int min) async {
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
        print("notification successfully added ");
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
}