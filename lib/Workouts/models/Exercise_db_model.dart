import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ExerciseDbModel {
  final String exerciseId;
  final String exerciseName;
  final String imageUrl;
  final String description;
  final String category; //TO DO Make an Enum of category types

  ExerciseDbModel({
    @required this.exerciseId,
    @required this.exerciseName,
    this.imageUrl,
    @required this.description,
    @required this.category,
  });

  factory ExerciseDbModel.fromJson(dynamic json) {
    return ExerciseDbModel(
        exerciseId: "${json['id']}",
        exerciseName: "${json['name']}",
        imageUrl: "${json['url']}",
        description: "${json['description']}",
        category: "${json['category']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'id': exerciseId,
        'name': exerciseName,
        'url': imageUrl,
        'description': description,
        'category': category,
      };
}

class GetExerciseDataFromGoogleSheetProvider with ChangeNotifier {
  // ignore: deprecated_member_use
  List<ExerciseDbModel> _listExercises = List<ExerciseDbModel>();
  static const url =
      "https://script.google.com/macros/s/AKfycbx2H4v8xaSWlnTq3WKaVHw-Z_2eBh6M0yFufxGwm-diDYcKfJPzHZjI9zi23Z1G0YSF/exec";
  Future<List<ExerciseDbModel>> getListOfExercises() async {
    await http.get(Uri.parse(url)).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      _listExercises =
          jsonFeedback.map((json) => ExerciseDbModel.fromJson(json)).toList();
      notifyListeners();
    });
  }

  List<ExerciseDbModel> get listExercises {
    return [..._listExercises];
  }

  List<ExerciseDbModel> exercisesBasesOnId(List<String> listOfExercisesId) {
    List<ExerciseDbModel> exercises = [];
    listOfExercisesId.forEach((exer_id) {
      int i =
          _listExercises.indexWhere((element) => element.exerciseId == exer_id);
      exercises.add(_listExercises[i]);
    });

    return exercises;
  }
}
