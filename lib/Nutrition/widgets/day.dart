import 'package:flutter/material.dart';
import '../data/nutrition.dart';

Widget getDay(List<NutritionData> data, int day) {
  List<Widget> breakfast = [];
  List<Widget> lunch = [];
  List<Widget> snacks = [];
  List<Widget> dinner = [];

  //For sunday and monday
  if(day == 8){
    day = 1;
  }

  //Monday
  if (day == 1) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(ListTile(
        title: new Text("${data[i].monday} ${data[i].mondayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(ListTile(
        title: new Text("${data[i].monday} ${data[i].mondayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(ListTile(
        title: new Text("${data[i].monday} ${data[i].mondayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(ListTile(
        title: new Text("${data[i].monday} ${data[i].mondayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }
  }

  //Tuesday
  if (day == 2) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(ListTile(
        title: new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(ListTile(
        title: new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(ListTile(
        title: new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(ListTile(
        title: new Text("${data[i].tuesday} ${data[i].tuesdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }
  }

  if (day == 3) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(ListTile(
        title: new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(ListTile(
        title: new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(ListTile(
        title: new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(ListTile(
        title: new Text("${data[i].wednesday} ${data[i].wednesdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }
  }

  if (day == 4) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(ListTile(
        title: new Text("${data[i].thursday} ${data[i].thursdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(ListTile(
        title: new Text("${data[i].thursday} ${data[i].thursdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(ListTile(
        title: new Text("${data[i].thursday} ${data[i].thursdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(ListTile(
        title: new Text("${data[i].thursday} ${data[i].thursdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }
  }

  if (day == 5) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(ListTile(
        title: new Text("${data[i].friday} ${data[i].fridayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(ListTile(
        title: new Text("${data[i].friday} ${data[i].fridayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(ListTile(
        title: new Text("${data[i].friday} ${data[i].fridayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(ListTile(
        title: new Text("${data[i].friday} ${data[i].fridayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }
  }

  if (day == 6) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(ListTile(
        title: new Text("${data[i].saturday} ${data[i].saturdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(ListTile(
        title: new Text("${data[i].saturday} ${data[i].saturdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(ListTile(
        title: new Text("${data[i].saturday} ${data[i].saturdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(ListTile(
        title: new Text("${data[i].saturday} ${data[i].saturdayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }
  }

  if (day == 7) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(ListTile(
        title: new Text("${data[i].sunday} ${data[i].sundayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(ListTile(
        title: new Text("${data[i].sunday} ${data[i].sundayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(ListTile(
        title: new Text("${data[i].sunday} ${data[i].sundayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(ListTile(
        title: new Text("${data[i].sunday} ${data[i].sundayCalories}"),
        trailing: Icon(Icons.arrow_drop_down),
        )
      );
    }
  }

  return new Column(
    children: [
      Text(
        "Breakfast:",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Gro",
        )
      ),
      Column(
        children: breakfast,
      ),
      Text(
        "Lunch:",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Gro",
        )
      ),
      Column(
        children: lunch,
      ),
      Text(
        "Snacks:",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Gro",
        )
      ),
      Column(
        children: snacks,
      ),
      Text(
        "Dinner:",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Gro",
        )
      ),
      Column(
        children: dinner,
      ),
    ]);
}