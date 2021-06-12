import '../../Providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/WorkoutModel.dart';
import '../models/Exercise_db_model.dart';

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

  createWorkoutAndAddToDB(
      String creatorId,
      String creator_name,
      String workoutName,
      String description,
      String access,
      List<String> listOfExercisesId,
      List<String> listOfFollowersId) async {
    // finding the time of creation
    final time = DateTime.now();
    final String dateOfCreationOfWorkout = time.toIso8601String();
    const url = "https://authentications-c0299.firebaseio.com/Workouts.json";
    return http
        .post(
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
        },
      ),
    )
        .then(
      (response) {
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
            listOfFollowersId: listOfFollowersId);
        _workoutsList.add(newWorkout);
        notifyListeners();
        // print(newWorkout.listOfExercisesId);
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
    //  get the list of all exercises
  }

  Future<void> showAllWorkouts() async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    const url = "https://authentications-c0299.firebaseio.com/Workouts.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map;
      final List<WorkoutModel> loadedList = [];

      extractedData.forEach(
        (statId, statValue) {
          final List<String> tempListExerciseId = [];
          final List<String> tempListFollowersId = [];
          List x = statValue['listOfExercisesId'];
          x.forEach((element) {
            tempListExerciseId.add(element.toString());
          });
          List y = statValue['listOfFollowersId'];
          y.forEach((element) {
            tempListFollowersId.add(element.toString());
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
      // return _workoutsList;
    } catch (e) {
      print(e);
    }
  }

  Future<void> followWorkout(WorkoutModel workout, String workoutId) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;
    final url =
        "https://authentications-c0299.firebaseio.com/Workouts.json/$workoutId.json";
    List followers = workout.listOfFollowersId;
    followers.add(user_uid);
    try {
      await http.patch(Uri.parse(url),
          body: json.encode({
            'access': workout.access,
            'creationDate': workout.creationDate,
            'creatorId': workout.creatorId,
            'workoutName': workout.workoutName,
            'listOfExercisesId': workout.listOfExercisesId,
            'listOfFollowersId': followers,
          }));
      print("follower list has been updated");
      WorkoutModel updatedWorkout = WorkoutModel(
        creator_name: workout.creator_name,
        creatorId: workout.creatorId,
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
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> unFollowWorkout(WorkoutModel workout, String workoutId) async {
    String user_uid = Data_Provider().uid;
    String user_email = Data_Provider().email;

    final url =
        "https://authentications-c0299.firebaseio.com/Workouts.json/$workoutId.json";
    List followers = workout.listOfFollowersId;
    followers.remove(user_uid);
    try {
      await http.patch(Uri.parse(url),
          body: json.encode({
            'access': workout.access,
            'creationDate': workout.creationDate,
            'creatorId': workout.creatorId,
            'workoutName': workout.workoutName,
            'listOfExercisesId': workout.listOfExercisesId,
            'listOfFollowersId': followers,
          }));
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
}
