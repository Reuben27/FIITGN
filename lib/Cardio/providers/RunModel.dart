import 'package:flutter/foundation.dart';

class RunModel {
  final String user_name;
  final String activity_name;
  final String is_private;
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
  final List<double> altitude_list;
  final List<double> pace_list;
  // final List<String> speed_per_km;
  // final List<String> time_per_km;

  RunModel({
    @required this.user_name,
    @required this.activity_name,
    @required this.is_private,
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
    @required this.altitude_list,
    @required this.pace_list,
    this.caloriesBurned = 'Upcoming Feature',
    // @required this.speed_per_km,
    // @required this.time_per_km,
  });
}
