import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GuidedSessions {
  @required String theme;
  @required String exercises;
  @required String benefits;
  String imageurl = "";
  @required String startdate;
  @required String enddate;
  @required String timings;

  GuidedSessions(this.theme, this.exercises, this.benefits, this.imageurl, this.startdate, this.enddate, this.timings);

  factory GuidedSessions.fromJson(dynamic json) {
    return GuidedSessions("${json['theme']}", "${json['exercises']}" , "${json['benefits']}", "${json['imageurl']}", "${json['startdate']}", "${json['enddate']}", "${json['timings']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'theme': theme,
    'exercises': exercises,
    'benefits': benefits,
    'imageurl': imageurl,
    'startdate': startdate,
    'enddate': enddate,
    'timings': timings,
  };
}

// Google App Script Web URL.
const String url =
    "https://script.google.com/macros/s/AKfycbwfUKDHtfvLSrzXcqWRVcGeo5I95uEJ76lh-nMwfxzWcyj8uoL9JoFcoMDT4HjEYZty/exec";

// Success Status Message
const STATUS_SUCCESS = "SUCCESS";

Future<List<GuidedSessions>> getGuidedSessions() async {
  return await http.get(Uri.parse(url)).then((response) {
    var jsonFeedback = convert.jsonDecode(response.body) as List;
    return jsonFeedback.map((json) => GuidedSessions.fromJson(json)).toList();
  });
}

List<GuidedSessions> upcomingSessions(List<GuidedSessions> data){
  DateTime now = DateTime.now();
  List<GuidedSessions> list = [];
  for(int i = 0; i < data.length; i++){
    String startDate = data[i].startdate.trim();
    DateTime sD = DateTime.parse(startDate);
    print(sD);
    if(sD.isAfter(now)){
      list.add(data[i]);
    } 
  }

  print(list);
  return list;
}

List<GuidedSessions> completedSessions(List<GuidedSessions> data){
  DateTime now = DateTime.now();
  List<GuidedSessions> list = [];
  for(int i = 0; i < data.length; i++){
    String endDate = data[i].enddate.trim();
    DateTime eD = DateTime.parse(endDate);
    print(eD);
    if(eD.isBefore(now)){
      list.add(data[i]);
    } 
  }

  print(list);
  return list;
}

List<GuidedSessions> ongoingSessions(List<GuidedSessions> data){
  DateTime now = DateTime.now();
  List<GuidedSessions> list = [];
  for(int i = 0; i < data.length; i++){
    String startDate = data[i].startdate.trim();
    DateTime sD = DateTime.parse(startDate);
    print(sD);
    String endDate = data[i].enddate.trim();
    DateTime eD = DateTime.parse(endDate);
    print(eD);
    if(eD.isAfter(now) && sD.isBefore(now)){
      list.add(data[i]);
    } 
  }

  print(list);
  return list;
}