import 'package:flutter/foundation.dart';

class CycleModel {
  final String databaseID;
  final String uid;
  final String dateOfRun;
  final String startTime;
  final String distanceCovered;
  final String avgSpeed;
  final String timeOfRunSec;
  final String timeOfRunMin;
  final String timeOfRunHrs;
  final String caloriesBurned;
  final List<dynamic> listOfLatLng;
  final double initialLatitude;
  final double initialLongitude;

  CycleModel({
    @required this.databaseID,
    @required this.uid,
    @required this.dateOfRun,
    @required this.avgSpeed,
    @required this.distanceCovered,
    @required this.startTime,
    @required this.timeOfRunSec,
    @required this.timeOfRunMin,
    @required this.timeOfRunHrs,
    @required this.listOfLatLng,
    @required this.initialLongitude,
    @required this.initialLatitude,
    this.caloriesBurned = 'Upcoming Feature',
  });
}
