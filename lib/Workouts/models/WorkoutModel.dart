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
  final List<String> listOfExercisesId;
  final String description;
  final String imageUrl;

  WorkoutModel({
    @required this.creator_name,
    @required this.creatorId,
    @required this.workoutId,
    @required this.workoutName,
    @required this.access,
    @required this.creationDate,
    @required this.listOfExercisesId,
    @required this.listOfFollowersId,
    @required this.description,
    this.imageUrl,
  });
}
