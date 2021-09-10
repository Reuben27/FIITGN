import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WorkoutModel {
  final String creatorId;
  final String creator_name;
  final String workoutId;
  final String workoutName;
  final String access;
  final String creationDate;
  final List<String> listOfFollowersId;
  final List<String>
      listOfOnGoingId; // stores which users are currently doing this workout
  final List<String> listOfExercisesId;
  final String description;
  final String imageUrl;

  WorkoutModel({
    @required this.creator_name,
    @required this.creatorId,
    @required this.workoutId,
    @required this.listOfOnGoingId,
    @required this.workoutName,
    @required this.access,
    @required this.creationDate,
    @required this.listOfExercisesId,
    @required this.listOfFollowersId,
    @required this.description,
    this.imageUrl,
  });

  Map toJson() => {
        'creatorId': this.creatorId,
        'creator_name': this.creator_name,
        'workoutId': this.workoutId,
        'listOfOnGoingId': this.listOfOnGoingId,
        'workoutName': this.workoutName,
        'access': this.access,
        'creationDate': this.creationDate,
        'listOfExercisesId': this.listOfExercisesId,
        'listOfFollowersId': this.listOfFollowersId,
        'description': this.description,
        'imageUrl': this.imageUrl
      };

  factory WorkoutModel.fromJson(dynamic json) {
    return WorkoutModel(
        access: "${json['access']}",
        creationDate: "${json['creationDate']}",
        creatorId: "${json['creatorId']}",
        creator_name: "${json['creator_name']}",
        description: "${json['description']}",
        listOfExercisesId: _converToList_String(json['listOfExercisesId']),
        listOfFollowersId: _converToList_String(json['listOfFollowersId']),
        listOfOnGoingId: _converToList_String(json['listOfOnGoingId']),
        workoutId: "${json['workoutId']}",
        workoutName: "${json['workoutName']}",
        imageUrl: "${json['imageUrl']}");
  }
}

List<String> _converToList_String(List<dynamic> list) {
  List<String> x = [];
  list.forEach((element) {
    if (element.runtimeType == String) {
      x.add(element);
      print("element added to x");
    }
  });
  return x;
}
