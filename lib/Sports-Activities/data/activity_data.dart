import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ActivityData {
  static List<ActivityData> activites_static = [];
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
      json['venue'],
    );
  }
}

// Google App Script Web URL.
const String url =
    "https://script.google.com/macros/s/AKfycbw9gGfkya4rZ9HNcsHeQXP1sR-pQFIBDiQV9bSCIeFg9c412_jpiwE7DR42_qIvAxUH5w/exec";

// Success Status Message
const STATUS_SUCCESS = "SUCCESS";

List<ActivityData> _activity_data = [];

Future<List<ActivityData>> getActivityData() async {
  return await http.get(Uri.parse(url)).then((response) {
    var jsonFeedback = convert.jsonDecode(response.body) as List;
    _activity_data =
        jsonFeedback.map((json) => ActivityData.fromJson(json)).toList();
    ActivityData.activites_static = _activity_data;
    return _activity_data;
  });
}

List<ActivityData> get activities_data {
  return _activity_data;
}
