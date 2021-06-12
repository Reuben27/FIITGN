import 'package:flutter/material.dart';
import '../data/nutrition.dart';

class NutritionScreen extends StatefulWidget {
  static const  routeName = '\Nutrition_Screen';
  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State {
  List<NutritionData> items = List<NutritionData>.empty();

  @override
  void initState() {
    super.initState();
    getData();
    print(items);
  }

  void getData() async {
    items = await getNutritionData();
    getIndices(items);
    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nutrition Data"),
      ),
      body: getTextWidgets(items),
    );
  }
}

Widget getTextWidgets(List<NutritionData> data) {
  DateTime date = DateTime.now();
  int day = date.weekday;
  //int day = 2;
  int hour = date.hour;
  //int hour = 10;
  List<Widget> list = [];

  if (day == 1) {
    if (hour >= 0 && hour < 11) {
      for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
        list.add(new Text("${data[i].monday} ${data[i].mondayCalories}"));
      }
    } else if (hour >= 11 && hour < 15) {
      for (var i = lunchIndex + 2; i < snacksIndex; i++) {
        list.add(new Text("${data[i].monday} ${data[i].mondayCalories}"));
      }
    } else if (hour >= 15 && hour < 18) {
      for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
        list.add(new Text("${data[i].monday} ${data[i].mondayCalories}"));
      }
    } else {
      for (var i = dinnerIndex + 2; i < data.length; i++) {
        list.add(new Text("${data[i].monday} ${data[i].mondayCalories}"));
      }
    }
  }

  if (day == 2) {
    if (hour >= 0 && hour < 11) {
      for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
        list.add(new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"));
      }
    } else if (hour >= 11 && hour < 15) {
      for (var i = lunchIndex + 2; i < snacksIndex; i++) {
        list.add(new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"));
      }
    } else if (hour >= 15 && hour < 18) {
      for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
        list.add(new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"));
      }
    } else {
      for (var i = dinnerIndex + 2; i < data.length; i++) {
        list.add(new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"));
      }
    }
  }

  if (day == 3) {
    if (hour >= 0 && hour < 11) {
      for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
        list.add(new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"));
      }
    } else if (hour >= 11 && hour < 15) {
      for (var i = lunchIndex + 2; i < snacksIndex; i++) {
        list.add(new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"));
      }
    } else if (hour >= 15 && hour < 18) {
      for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
        list.add(new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"));
      }
    } else {
      for (var i = dinnerIndex + 2; i < data.length; i++) {
        list.add(new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"));
      }
    }
  }

  if (day == 4) {
    if (hour >= 0 && hour < 11) {
      for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
        list.add(new Text("${data[i].thursday} ${data[i].thursdayCalories}"));
      }
    } else if (hour >= 11 && hour < 15) {
      for (var i = lunchIndex + 2; i < snacksIndex; i++) {
        list.add(new Text("${data[i].thursday} ${data[i].thursdayCalories}"));
      }
    } else if (hour >= 15 && hour < 18) {
      for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
        list.add(new Text("${data[i].thursday} ${data[i].thursdayCalories}"));
      }
    } else {
      for (var i = dinnerIndex + 2; i < data.length; i++) {
        list.add(new Text("${data[i].thursday} ${data[i].thursdayCalories}"));
      }
    }
  }

  if (day == 5) {
    if (hour >= 0 && hour < 11) {
      for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
        list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
      }
    } else if (hour >= 11 && hour < 15) {
      for (var i = lunchIndex + 2; i < snacksIndex; i++) {
        list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
      }
    } else if (hour >= 15 && hour < 18) {
      for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
        list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
      }
    } else {
      for (var i = dinnerIndex + 2; i < data.length; i++) {
        list.add(new Text("${data[i].friday} ${data[i].fridayCalories}"));
      }
    }
  }

  if (day == 6) {
    if (hour >= 0 && hour < 11) {
      for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
        list.add(new Text("${data[i].saturday} ${data[i].saturdayCalories}"));
      }
    } else if (hour >= 11 && hour < 15) {
      for (var i = lunchIndex + 2; i < snacksIndex; i++) {
        list.add(new Text("${data[i].saturday} ${data[i].saturdayCalories}"));
      }
    } else if (hour >= 15 && hour < 18) {
      for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
        list.add(new Text("${data[i].saturday} ${data[i].saturdayCalories}"));
      }
    } else {
      for (var i = dinnerIndex + 2; i < data.length; i++) {
        list.add(new Text("${data[i].saturday} ${data[i].saturdayCalories}"));
      }
    }
  }

  if (day == 7) {
    if (hour >= 0 && hour < 11) {
      for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
        list.add(new Text("${data[i].sunday} ${data[i].sundayCalories}"));
      }
    } else if (hour >= 11 && hour < 15) {
      for (var i = lunchIndex + 2; i < snacksIndex; i++) {
        list.add(new Text("${data[i].sunday} ${data[i].sundayCalories}"));
      }
    } else if (hour >= 15 && hour < 18) {
      for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
        list.add(new Text("${data[i].sunday} ${data[i].sundayCalories}"));
      }
    } else {
      for (var i = dinnerIndex + 2; i < data.length; i++) {
        list.add(new Text("${data[i].sunday} ${data[i].sundayCalories}"));
      }
    }
  }

  return new Column(children: list);
}