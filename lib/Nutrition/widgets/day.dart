import 'package:flutter/material.dart';
import '../data/nutrition.dart';

Widget getDay(List<NutritionData> data, int day) {
  List<Widget> list = [];
  if(day == 8){
    day = 1;
  }

  if (day == 1) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      list.add(new Text("${data[i].monday} ${data[i].mondayCalories}"));
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      list.add(new Text("${data[i].monday} ${data[i].mondayCalories}"));
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      list.add(new Text("${data[i].monday} ${data[i].mondayCalories}"));
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      list.add(new Text("${data[i].monday} ${data[i].mondayCalories}"));
    }
  }

  if (day == 2) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      list.add(new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"));
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      list.add(new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"));
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      list.add(new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"));
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      list.add(new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"));
    }
  }

  if (day == 3) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      list.add(new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"));
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      list.add(new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"));
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      list.add(new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"));
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      list.add(new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"));
    }
  }

  if (day == 4) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      list.add(new Text("${data[i].thursday} ${data[i].thursdayCalories}"));
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      list.add(new Text("${data[i].thursday} ${data[i].thursdayCalories}"));
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      list.add(new Text("${data[i].thursday} ${data[i].thursdayCalories}"));
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      list.add(new Text("${data[i].thursday} ${data[i].thursdayCalories}"));
    }
  }

  if (day == 5) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
    }
  }

  if (day == 6) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
    }
  }

  if (day == 7) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      list.add(new Text("${data[i].saturday} ${data[i].saturdayCalories}"));
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      list.add(new Text("${data[i].saturday} ${data[i].saturdayCalories}"));
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      list.add(new Text("${data[i].saturday} ${data[i].saturdayCalories}"));
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      list.add(new Text("${data[i].saturday} ${data[i].saturdayCalories}"));
    }
  }
  return new Column(children: list);
}