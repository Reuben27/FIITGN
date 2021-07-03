import 'dart:ui';

import 'package:flutter/material.dart';

import './WorkoutModel.dart';
import 'package:flutter/foundation.dart';

class Item_Model {
  bool expanded;
  Color color_item;
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
  //   this.imageUrl

  Item_Model({
    this.expanded: false,
    this.color_item,
    @required this.workoutId,
    @required this.workoutName,
    @required this.access,
    @required this.creationDate,
    @required this.creator_name,
    @required this.description,
    @required this.imageUrl,
    @required this.listOfExercisesId,
    @required this.listOfFollowersId,
    @required this.listOfOnGoingId,
  });

  static create_item_model_from_workout_model(WorkoutModel workout) {
    return Item_Model(
      expanded: false,
      color_item: Colors.green,
      access: workout.access,
      creationDate: workout.creationDate,
      creator_name: workout.creator_name,
      description: workout.description,
      imageUrl: workout.imageUrl,
      listOfExercisesId: workout.listOfExercisesId,
      listOfFollowersId: workout.listOfFollowersId,
      listOfOnGoingId: workout.listOfOnGoingId,
      workoutId: workout.workoutId,
      workoutName: workout.workoutName,
    );
  }

  static get_list_item_model(List<WorkoutModel> workouts) {
    List<Item_Model> items = [];
    workouts.forEach(
      (element) {
        items.add(create_item_model_from_workout_model(element));
      },
    );
    return items;
  }
}
