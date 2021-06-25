import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ExerciseDbModel {
  final String exerciseId;
  final String exerciseName;
  final String imageUrl;
  final String description;
  final String category; //TO DO Make an Enum of category types
  final String isWeighted;

  ExerciseDbModel({
    @required this.exerciseId,
    @required this.exerciseName,
    @required this.imageUrl,
    @required this.description,
    @required this.category,
    @required this.isWeighted,
  });


  factory ExerciseDbModel.fromJson(dynamic json) {
    return ExerciseDbModel(
        exerciseId: "${json['id']}",
        exerciseName: "${json['name']}",
        imageUrl: "${json['url']}",
        description: "${json['description']}",
        category: "${json['category']}",
        isWeighted: "${json['isWeighted']}");
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
      "https://script.google.com/macros/s/AKfycbw0vjoXH7xFpVEeREztGhaeKZ1tWhaNcoGGiE4mt3g2HipqxD_0u4OnOotqk3vjGAog/exec";
  Future<void> getListOfExercises() async {
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

  List<ExerciseDbModel> chest_exercises(){
    List<ExerciseDbModel> chest_exercises = [];
    _listExercises.forEach((element) {
      if(element.description == 'Chest'){
        chest_exercises.add(element);
      }
    });
    return chest_exercises;
}

  List<ExerciseDbModel> core_exercises(){
    List<ExerciseDbModel> core_exercises = [];
    _listExercises.forEach((element) {
      if(element.description == 'Core'){
        core_exercises.add(element);
      }
    });
    return core_exercises;
}


  List<ExerciseDbModel> tricep_exercises(){
    List<ExerciseDbModel> tricep_exercises = [];
    _listExercises.forEach((element) {
      if(element.description == 'Triceps'){
        tricep_exercises.add(element);
      }
    });
    return tricep_exercises;
}

  List<ExerciseDbModel> back_exercises(){
    List<ExerciseDbModel> back_exercises = [];
    _listExercises.forEach((element) {
      if(element.description == 'Back'){
        back_exercises.add(element);
      }
    });
    return back_exercises;
}

  List<ExerciseDbModel> legs_exercises(){
    List<ExerciseDbModel> legs_exercises = [];
    _listExercises.forEach((element) {
      if(element.description == 'Legs'){
        legs_exercises.add(element);
      }
    });
    return legs_exercises;
}

  List<ExerciseDbModel> biceps_exercises(){
    List<ExerciseDbModel> biceps_exercises = [];
    _listExercises.forEach((element) {
      if(element.description == 'Biceps'){
        biceps_exercises.add(element);
      }
    });
    return biceps_exercises;
}

  List<ExerciseDbModel> shoulder_exercises(){
    List<ExerciseDbModel> shoulder_exercises = [];
    _listExercises.forEach((element) {
      if(element.description == 'Shoulder'){
        shoulder_exercises.add(element);
      }
    });
    return shoulder_exercises;
}




}
