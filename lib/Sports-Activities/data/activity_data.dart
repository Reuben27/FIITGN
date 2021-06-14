import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';

// int breakfastIndex = 0;
// int lunchIndex = 0;
// int snacksIndex = 0;
// int dinnerIndex = 0;

class ActivityData {
  String sr_no;
  String instructors;
  String time_of_class;
  String schedule;
  String activities;
  String online_offline;
  String link;
  String venue;

  ActivityData(
    this.sr_no,
    this.instructors,
    this.time_of_class,
    this.schedule,
    this.activities,
    this.online_offline,
    this.link,
    this.venue,
  );

  factory ActivityData.fromJson(dynamic json) {
    return ActivityData(
      json['sr_no'],
      json['instructors'],
      json['time_of_class'],
      json['schedule'],
      json['activities'],
      json['online_offline'],
      json['link'],
      json['venue)'],
    );
  }
}

// Method to make GET parameters.
// Map toJson() => {
//       'monday': monday,
//       'mondayCalories': mondayCalories,
//       'tuesday': tuesday,
//       'tuesdayCalories': tuesdayCalories,
//       'wednesday': wednesday,
//       'wednesdayCalories': wednesdayCalories,
//       'thursday': thursday,
//       'mthursdayCalories': thursdayCalories,
//       'friday': friday,
//       'fridayCalories': fridayCalories,
//       'saturday': saturday,
//       'saturdayCalories': saturdayCalories,
//       'sunday': sunday,
//       'sundayCalories': sundayCalories,
//     };

// Google App Script Web URL.
const String url =
    "https://script.google.com/macros/s/AKfycbzKum_haSZpgLLZH_mTBgK5A4Ksp-GJC54uUDmvpl6XkCye9rnzpy_kK9xjA5DriVZJ5A/exec";

// Success Status Message
const STATUS_SUCCESS = "SUCCESS";

Future<List<ActivityData>> getActivityData() async {
  return await http.get(Uri.parse(url)).then((response) {
    var jsonFeedback = convert.jsonDecode(response.body) as List;
    return jsonFeedback.map((json) => ActivityData.fromJson(json)).toList();
  });
}

// void getIndices(List<NutritionData> data) {
//   // print(data[0].monday);

//   for (int i = 0; i < data.length; i++) {
//     if (data[i].monday.trim() == "Breakfast") {
//       breakfastIndex = i;
//     }
//     if (data[i].monday.trim() == "Lunch") {
//       lunchIndex = i;
//     }
//     if (data[i].monday.trim() == "Snacks") {
//       snacksIndex = i;
//     }
//     if (data[i].monday.trim() == "Dinner") {
//       dinnerIndex = i;
//     }
//   }
//   // print(data.length);
//   // print(breakfastIndex);
//   // print(lunchIndex);
//   // print(snacksIndex);
//   // print(dinnerIndex);
// }
