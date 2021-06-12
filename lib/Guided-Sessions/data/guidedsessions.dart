import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GuidedSessions {
  @required String theme;
  @required String exercises;
  @required String benefits;
  String imageurl = "";

  GuidedSessions(this.theme, this.exercises, this.benefits, this.imageurl);

  factory GuidedSessions.fromJson(dynamic json) {
    return GuidedSessions("${json['theme']}", "${json['exercises']}" , "${json['benefits']}", "${json['imageurl']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'theme': theme,
    'exercises': exercises,
    'benefits': benefits,
    'imageurl': imageurl,
  };
}

// Google App Script Web URL.
const String url =
    "https://script.google.com/macros/s/AKfycbx_V7YmjScoAGZiUK5qHJHA8ZW0cApzll_XxJ7xa4WjVHdAClrtmzdtCe-nIxS4jO5z/exec";

// Success Status Message
const STATUS_SUCCESS = "SUCCESS";

Future<List<GuidedSessions>> getGuidedSessions() async {
  return await http.get(Uri.parse(url)).then((response) {
    var jsonFeedback = convert.jsonDecode(response.body) as List;
    return jsonFeedback.map((json) => GuidedSessions.fromJson(json)).toList();
  });
}