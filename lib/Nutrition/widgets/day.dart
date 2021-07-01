import 'package:flutter/material.dart';
import '../data/nutrition.dart';

class Meal {
  String dishName;
  String calories;
  String fat;
  String cholesterol;
  String sodium;
  String carbs;
  String protein;

  Meal(
      {this.dishName,
      this.calories,
      this.fat,
      this.cholesterol,
      this.sodium,
      this.carbs,
      this.protein});
}

Widget getDay(BuildContext context, List<NutritionData> data, int day) {
  List<Widget> breakfast = [];
  List<Widget> lunch = [];
  List<Widget> snacks = [];
  List<Widget> dinner = [];
  List<Meal> brakefast = [];
  List<Meal> lonch = [];
  List<Meal> snek = [];
  List<Meal> supper = [];
  //For sunday and monday
  if (day == 8) {
    day = 1;
  }

  //Monday
  if (day == 1) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].monday} ${data[i].mondayCalories}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].monday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].monday} ${data[i].mondayCalories}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].monday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].monday} ${data[i].mondayCalories}"),
      );
      snek.add(
        Meal(
          dishName: data[i].monday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].monday} ${data[i].mondayCalories}"),
      );
      supper.add(
        Meal(
          dishName: data[i].monday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }
  }

  //Tuesday
  if (day == 2) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].tuesday} ${data[i].tuesdayCalories}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].tuesday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].tuesday} ${data[i].tuesdayCalories}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].tuesday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].tuesday} ${data[i].tuesdayCalories}"),
      );
      snek.add(
        Meal(
          dishName: data[i].tuesday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].tuesday} ${data[i].tuesdayCalories}"),
      );
      supper.add(
        Meal(
          dishName: data[i].tuesday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }
  }

  if (day == 3) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].wednesday} ${data[i].wednesdayCalories}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].wednesday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].wednesday} ${data[i].wednesdayCalories}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].wednesday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].wednesday} ${data[i].wednesdayCalories}"),
      );
      snek.add(
        Meal(
          dishName: data[i].wednesday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].wednesday} ${data[i].wednesdayCalories}"),
      );
      supper.add(
        Meal(
          dishName: data[i].wednesday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }
  }

  if (day == 4) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].thursday} ${data[i].thursdayCalories}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].thursday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].thursday} ${data[i].thursdayCalories}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].thursday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].thursday} ${data[i].thursdayCalories}"),
      );
      snek.add(
        Meal(
          dishName: data[i].thursday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].thursday} ${data[i].thursdayCalories}"),
      );
      supper.add(
        Meal(
          dishName: data[i].thursday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }
  }

  if (day == 5) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].friday} ${data[i].fridayCalories}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].friday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].friday} ${data[i].fridayCalories}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].friday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].friday} ${data[i].fridayCalories}"),
      );
      snek.add(
        Meal(
          dishName: data[i].friday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].friday} ${data[i].fridayCalories}"),
      );
      supper.add(
        Meal(
          dishName: data[i].friday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }
  }

  if (day == 6) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].saturday} ${data[i].saturdayCalories}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].saturday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].saturday} ${data[i].saturdayCalories}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].saturday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].saturday} ${data[i].saturdayCalories}"),
      );
      snek.add(
        Meal(
          dishName: data[i].saturday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].saturday} ${data[i].saturdayCalories}"),
      );
      supper.add(
        Meal(
          dishName: data[i].saturday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }
  }

  if (day == 7) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].sunday} ${data[i].sundayCalories}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].sunday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].sunday} ${data[i].sundayCalories}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].sunday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].sunday} ${data[i].sundayCalories}"),
      );
      snek.add(
        Meal(
          dishName: data[i].sunday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].sunday} ${data[i].sundayCalories}"),
      );
      supper.add(
        Meal(
          dishName: data[i].sunday,
          calories: 100.toString(),
          protein: 100.toString(),
          carbs: 100.toString(),
          fat: 100.toString(),
          cholesterol: 100.toString(),
          sodium: 100.toString(),
        ),
      );
    }
  }

  return PageView(
    children: [
      new Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top) /
              42.25,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 20.57,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 8,
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage("assets/toaster.png"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 20.57,
            ),
            Text(
              "BREAKFAST",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width / 10,
                fontFamily: "Gilroy",
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy',
                fontSize: MediaQuery.of(context).size.width / 25,
                fontWeight: FontWeight.bold),
            dataRowHeight: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top) /
                16.9,
            columns: [
              DataColumn(label: Text("Meal Name")),
              DataColumn(label: Text("Calories")),
              DataColumn(label: Text("Fat")),
              DataColumn(label: Text("Carbohydrates")),
              DataColumn(label: Text("Protein")),
              DataColumn(label: Text("Sodium")),
              DataColumn(label: Text("Cholesterol")),
            ],
            rows: brakefast
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(
                        Text(
                          e.dishName,
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: MediaQuery.of(context).size.width / 20),
                        ),
                      ),
                      DataCell(
                        Text(e.calories,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize:
                                    MediaQuery.of(context).size.width / 20)),
                      ),
                      DataCell(
                        Text(e.fat,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize:
                                    MediaQuery.of(context).size.width / 20)),
                      ),
                      DataCell(
                        Text(e.carbs,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize:
                                    MediaQuery.of(context).size.width / 20)),
                      ),
                      DataCell(Text(e.protein,
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize:
                                  MediaQuery.of(context).size.width / 20))),
                      DataCell(
                        Text(e.sodium,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize:
                                    MediaQuery.of(context).size.width / 20)),
                      ),
                      DataCell(
                        Text(e.cholesterol,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize:
                                    MediaQuery.of(context).size.width / 20)),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top) /
              42.25,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 20.57,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 8,
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage("assets/sandwich.png"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 20.57,
            ),
            Text("LUNCH",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 10,
                  fontFamily: "Gilroy",
                )),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy',
                fontSize: MediaQuery.of(context).size.width / 25,
                fontWeight: FontWeight.bold),
            dataRowHeight: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top) /
                16.9,
            dataTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy',
                fontSize: MediaQuery.of(context).size.width / 20),
            columns: [
              DataColumn(label: Text("Meal Name")),
              DataColumn(label: Text("Calories")),
              DataColumn(label: Text("Fat")),
              DataColumn(label: Text("Carbohydrates")),
              DataColumn(label: Text("Protein")),
              DataColumn(label: Text("Sodium")),
              DataColumn(label: Text("Cholesterol")),
            ],
            rows: lonch
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(
                        Text(e.dishName),
                      ),
                      DataCell(
                        Text(e.calories),
                      ),
                      DataCell(
                        Text(e.fat),
                      ),
                      DataCell(
                        Text(e.carbs),
                      ),
                      DataCell(Text(e.protein)),
                      DataCell(
                        Text(e.sodium),
                      ),
                      DataCell(
                        Text(e.cholesterol),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top) /
              42.25,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 20.57,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 8,
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage("assets/coffee-bean.png"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 20.57,
            ),
            Text("SNACKS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 10,
                  fontFamily: "Gilroy",
                )),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy',
                fontSize: MediaQuery.of(context).size.width / 25,
                fontWeight: FontWeight.bold),
            dataRowHeight: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top) /
                16.9,
            dataTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy',
                fontSize: MediaQuery.of(context).size.width / 20),
            columns: [
              DataColumn(label: Text("Meal Name")),
              DataColumn(label: Text("Calories")),
              DataColumn(label: Text("Fat")),
              DataColumn(label: Text("Carbohydrates")),
              DataColumn(label: Text("Protein")),
              DataColumn(label: Text("Sodium")),
              DataColumn(label: Text("Cholesterol")),
            ],
            rows: snek
                .map(
                  (e) => DataRow(
                    cells: [
                      DataCell(
                        Text(e.dishName),
                      ),
                      DataCell(
                        Text(e.calories),
                      ),
                      DataCell(
                        Text(e.fat),
                      ),
                      DataCell(
                        Text(e.carbs),
                      ),
                      DataCell(Text(e.protein)),
                      DataCell(
                        Text(e.sodium),
                      ),
                      DataCell(
                        Text(e.cholesterol),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ]),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top) /
                42.25,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20.57,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 8,
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/cutlery.png"),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20.57,
              ),
              Text("DINNER",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 10,
                    fontFamily: "Gilroy",
                  )),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gilroy',
                  fontSize: MediaQuery.of(context).size.width / 25,
                  fontWeight: FontWeight.bold),
              dataRowHeight: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewPadding.top) /
                  16.9,
              dataTextStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gilroy',
                  fontSize: MediaQuery.of(context).size.width / 20),
              columns: [
                DataColumn(label: Text("Meal Name")),
                DataColumn(label: Text("Calories")),
                DataColumn(label: Text("Fat")),
                DataColumn(label: Text("Carbohydrates")),
                DataColumn(label: Text("Protein")),
                DataColumn(label: Text("Sodium")),
                DataColumn(label: Text("Cholesterol")),
              ],
              rows: supper
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          Text(e.dishName),
                        ),
                        DataCell(
                          Text(e.calories),
                        ),
                        DataCell(
                          Text(e.fat),
                        ),
                        DataCell(
                          Text(e.carbs),
                        ),
                        DataCell(Text(e.protein)),
                        DataCell(
                          Text(e.sodium),
                        ),
                        DataCell(
                          Text(e.cholesterol),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    ],
    scrollDirection: Axis.vertical,
  );
}
