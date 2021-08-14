import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

int breakfastIndex = 0;
int lunchIndex = 0;
int snacksIndex = 0;
int dinnerIndex = 0;

class NutritionData {
  String monday;
  String mondayServing;
  String mondayCal;
  String mondayProtein;
  String mondayFats;
  String mondayFiber;
  String mondayCarbs;
  String tuesday;
  String tuesdayServing;
  String tuesdayCal;
  String tuesdayProtein;
  String tuesdayFats;
  String tuesdayFiber;
  String tuesdayCarbs;
  String wednesday;
  String wednesdayServing;
  String wednesdayCal;
  String wednesdayProtein;
  String wednesdayFats;
  String wednesdayFiber;
  String wednesdayCarbs;
  String thursday;
  String thursdayServing;
  String thursdayCal;
  String thursdayProtein;
  String thursdayFats;
  String thursdayFiber;
  String thursdayCarbs;
  String friday;
  String fridayServing;
  String fridayCal;
  String fridayProtein;
  String fridayFats;
  String fridayFiber;
  String fridayCarbs;
  String saturday;
  String saturdayServing;
  String saturdayCal;
  String saturdayProtein;
  String saturdayFats;
  String saturdayFiber;
  String saturdayCarbs;
  String sunday;
  String sundayServing;
  String sundayCal;
  String sundayProtein;
  String sundayFats;
  String sundayFiber;
  String sundayCarbs;

  NutritionData(
    this.monday,
    this.mondayServing,
    this.mondayCal,
    this.mondayProtein,
    this.mondayFats,
    this.mondayFiber,
    this.mondayCarbs,
    this.tuesday,
    this.tuesdayServing,
    this.tuesdayCal,
    this.tuesdayProtein,
    this.tuesdayFats,
    this.tuesdayFiber,
    this.tuesdayCarbs,
    this.wednesday,
    this.wednesdayServing,
    this.wednesdayCal,
    this.wednesdayProtein,
    this.wednesdayFats,
    this.wednesdayFiber,
    this.wednesdayCarbs,
    this.thursday,
    this.thursdayServing,
    this.thursdayCal,
    this.thursdayProtein,
    this.thursdayFats,
    this.thursdayFiber,
    this.thursdayCarbs,
    this.friday,
    this.fridayServing,
    this.fridayCal,
    this.fridayProtein,
    this.fridayFats,
    this.fridayFiber,
    this.fridayCarbs,
    this.saturday,
    this.saturdayServing,
    this.saturdayCal,
    this.saturdayProtein,
    this.saturdayFats,
    this.saturdayFiber,
    this.saturdayCarbs,
    this.sunday,
    this.sundayServing,
    this.sundayCal,
    this.sundayProtein,
    this.sundayFats,
    this.sundayFiber,
    this.sundayCarbs,
  );

  factory NutritionData.fromJson(dynamic json) {
    return NutritionData(
      "${json['monday']}",
      "${json['mondayServing']}",
      "${json['mondayCal']}",
      "${json['mondayProtein']}",
      "${json['mondayFats']}",
      "${json['mondayFiber']}",
      "${json['mondayCarbs']}",
      "${json['tuesday']}",
      "${json['tuesdayServing']}",
      "${json['tuesdayCal']}",
      "${json['tuesdayProtein']}",
      "${json['tuesdayFats']}",
      "${json['tuesdayFiber']}",
      "${json['tuesdayCarbs']}",
      "${json['wednesday']}",
      "${json['wednesdayServing']}",
      "${json['wednesdayCal']}",
      "${json['wednesdayProtein']}",
      "${json['wednesdayFats']}",
      "${json['wednesdayFiber']}",
      "${json['wednesdayCarbs']}",
      "${json['thursday']}",
      "${json['thursdayServing']}",
      "${json['thursdayCal']}",
      "${json['thursdayProtein']}",
      "${json['thursdayFats']}",
      "${json['thursdayFiber']}",
      "${json['thursdayCarbs']}",
      "${json['friday']}",
      "${json['fridayServing']}",
      "${json['fridayCal']}",
      "${json['fridayProtein']}",
      "${json['fridayFats']}",
      "${json['fridayFiber']}",
      "${json['fridayCarbs']}",
      "${json['saturday']}",
      "${json['saturdayServing']}",
      "${json['saturdayCal']}",
      "${json['saturdayProtein']}",
      "${json['saturdayFats']}",
      "${json['saturdayFiber']}",
      "${json['saturdayCarbs']}",
      "${json['sunday']}",
      "${json['sundayServing']}",
      "${json['sundayCal']}",
      "${json['sundayProtein']}",
      "${json['sundayFats']}",
      "${json['sundayFiber']}",
      "${json['sundayCarbs']}",
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'monday': monday,
        'mondayServing' : mondayServing,
        'mondayCal': mondayCal,
        'mondayProtein': mondayProtein,
        'mondayFats': mondayFats,
        'mondayFiber': mondayFiber,
        'mondayCarbs': mondayCarbs,
        'tuesday': tuesday,
        'tuesdayServing' : tuesdayServing,
        'tuesdayCal': tuesdayCal,
        'tuesdayProtein': tuesdayProtein,
        'tuesdayFats': tuesdayFats,
        'tuesdayFiber': tuesdayFiber,
        'tuesdayCarbs': tuesdayCarbs,
        'wednesday': wednesday,
        'wednesdayServing' : wednesdayServing,
        'wednesdayCal': wednesdayCal,
        'wednesdayProtein': wednesdayProtein,
        'wednesdayFats': wednesdayFats,
        'wednesdayFiber': wednesdayFiber,
        'wednesdayCarbs': wednesdayCarbs,
        'thursday': thursday,
        'thursdayServing' : thursdayServing,
        'thursdayCal': thursdayCal,
        'thursdayProtein': thursdayProtein,
        'thursdayFats': thursdayFats,
        'thursdayFiber': thursdayFiber,
        'thursdayCarbs': thursdayCarbs,
        'friday': friday,
        'fridayServing' : fridayServing,
        'fridayCal': fridayCal,
        'fridayProtein': fridayProtein,
        'fridayFats': fridayFats,
        'fridayFiber': fridayFiber,
        'fridayCarbs': fridayCarbs,
        'saturday': saturday,
        'saturdayServing' : saturdayServing,
        'saturdayCal': saturdayCal,
        'saturdayProtein': saturdayProtein,
        'saturdayFats': saturdayFats,
        'saturdayFiber': saturdayFiber,
        'saturdayCarbs': saturdayCarbs,
        'sunday': sunday,
        'sundayServing' : sundayServing,
        'sundayCal': sundayCal,
        'sundayProtein': sundayProtein,
        'sundayFats': sundayFats,
        'sundayFiber': sundayFiber,
        'sundayCarbs': sundayCarbs,
      };
}

// Google App Script Web URL.
const String url = "https://script.google.com/macros/s/AKfycbzj0WkiYiIB3b3cEBrdU6y-8Q-xdCug7uzDWQ_SNpX-JDxM060bCSL8kEPNpzawPvrhiw/exec";

// Success Status Message
const STATUS_SUCCESS = "SUCCESS";

List<NutritionData> _nutri_data_List = [];

Future<List<NutritionData>> getNutritionData() async {
  return await http.get(Uri.parse(url)).then((response) {
    var jsonFeedback = convert.jsonDecode(response.body) as List;

    _nutri_data_List = jsonFeedback.map((json) => NutritionData.fromJson(json)).toList();
    return _nutri_data_List;
  });
}

List<NutritionData> get nutri_data {
  return _nutri_data_List;
}

void getIndices(List<NutritionData> data) {
  for (int i = 0; i < data.length; i++) {
    if (data[i].monday.trim() == "Breakfast") {
      breakfastIndex = i;
    }
    if (data[i].monday.trim() == "Lunch") {
      lunchIndex = i;
    }
    if (data[i].monday.trim() == "Snacks") {
      snacksIndex = i;
    }
    if (data[i].monday.trim() == "Dinner") {
      dinnerIndex = i;
    }
  }
  // print(data.length);
  // print(breakfastIndex);
  // print(lunchIndex);
  // print(snacksIndex);
  // print(dinnerIndex);
}
