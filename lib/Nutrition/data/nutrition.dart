import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

int breakfastIndex = 0;
int lunchIndex = 0;
int snacksIndex = 0;
int dinnerIndex = 0;

class NutritionData {
  String monday;
  String mondayCalories;
  String tuesday;
  String tuesdayCalories;
  String wednesday;
  String wednesdayCalories;
  String thursday;
  String thursdayCalories;
  String friday;
  String fridayCalories;
  String saturday;
  String saturdayCalories;
  String sunday;
  String sundayCalories;

  NutritionData(
      this.monday,
      this.mondayCalories,
      this.tuesday,
      this.tuesdayCalories,
      this.wednesday,
      this.wednesdayCalories,
      this.thursday,
      this.thursdayCalories,
      this.friday,
      this.fridayCalories,
      this.saturday,
      this.saturdayCalories,
      this.sunday,
      this.sundayCalories);

  factory NutritionData.fromJson(dynamic json) {
    return NutritionData(
        "${json['monday']}",
        "${json['mondayCalories']}",
        "${json['tuesday']}",
        "${json['tuesdayCalories']}",
        "${json['wednesday']}",
        "${json['wednesdayCalories']}",
        "${json['thurday']}",
        "${json['thursdayCalories']}",
        "${json['friday']}",
        "${json['fridayCalories']}",
        "${json['saturday']}",
        "${json['saturdayCalories']}",
        "${json['sunday']}",
        "${json['sundayCalories']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'monday': monday,
        'mondayCalories': mondayCalories,
        'tuesday': tuesday,
        'tuesdayCalories': tuesdayCalories,
        'wednesday': wednesday,
        'wednesdayCalories': wednesdayCalories,
        'thursday': thursday,
        'mthursdayCalories': thursdayCalories,
        'friday': friday,
        'fridayCalories': fridayCalories,
        'saturday': saturday,
        'saturdayCalories': saturdayCalories,
        'sunday': sunday,
        'sundayCalories': sundayCalories,
      };
}

// Google App Script Web URL.
const String url =
    "https://script.google.com/macros/s/AKfycbyidXTReL2uu1tVke2FcLCOr5fJ9kDNBzgMqG-JuJ0hdR735-rbdcVNxiagmp5t3uRBDA/exec";

// Success Status Message
const STATUS_SUCCESS = "SUCCESS";

List<NutritionData> _nutri_data_List = [];

Future<List<NutritionData>> getNutritionData() async {
  return await http.get(Uri.parse(url)).then((response) {
    var jsonFeedback = convert.jsonDecode(response.body) as List;

    _nutri_data_List =
        jsonFeedback.map((json) => NutritionData.fromJson(json)).toList();
    return _nutri_data_List;
  });
}

List<NutritionData> get nutri_data {
  return _nutri_data_List;
}

void getIndices(List<NutritionData> data) {
  // print(data[0].monday);

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
