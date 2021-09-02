import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import './WorkoutModel.dart';

class PlanModel {
  final String creatorId;
  final String creator_name;
  final String planId;
  final int numberOfWeeks;
  final String planName;
  final String access;
  final String creationDate;
  final List<String> listOfFollowersId;
  final List<String>
      listOfOnGoingId; // stores which users are currently doing this workout
  final List<List<WorkoutModel>>
      listOfPlans; // [[mon,tue,wed,...],[mon,tue,wed,..],[mon,tue,wed..]]
  // assuming the plan can be more than a week
  final String description;
  String imageUrl;

  PlanModel({
    @required this.creator_name,
    @required this.numberOfWeeks,
    @required this.creatorId,
    @required this.planId,
    @required this.listOfOnGoingId,
    @required this.planName,
    @required this.access,
    @required this.creationDate,
    @required this.listOfPlans,
    @required this.listOfFollowersId,
    @required this.description,
    this.imageUrl,
  });
}
