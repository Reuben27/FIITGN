import 'package:flutter/material.dart';
import '../data/nutrition.dart';

class Meal {
  String dishName;
  String serving;
  String calories;
  String protein;
  String fats;
  String fiber;
  String carbs;

  Meal({
    this.dishName,
    this.serving,
    this.calories,
    this.protein,
    this.fats,
    this.fiber,
    this.carbs,
  });
}

Widget getDay(BuildContext context, List<NutritionData> data, int day) {
  var _screenHeight = MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
  var _screenWidth = MediaQuery.of(context).size.width;
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
        Text("${data[i].monday} ${data[i].mondayCal}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].monday,
          serving: data[i].mondayServing,
          carbs: data[i].mondayCarbs,
          fiber: data[i].mondayFiber,
          calories: data[i].mondayCal,
          protein: data[i].mondayProtein,
          fats: data[i].mondayFats,
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].monday} ${data[i].mondayCal}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].monday,
          serving: data[i].mondayServing,
          carbs: data[i].mondayCarbs,
          fiber: data[i].mondayFiber,
          calories: data[i].mondayCal,
          protein: data[i].mondayProtein,
          fats: data[i].mondayFats,
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].monday} ${data[i].mondayCal}"),
      );
      snek.add(
        Meal(
          dishName: data[i].monday,
          serving: data[i].mondayServing,
          carbs: data[i].mondayCarbs,
          fiber: data[i].mondayFiber,
          calories: data[i].mondayCal,
          protein: data[i].mondayProtein,
          fats: data[i].mondayFats,
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].monday} ${data[i].mondayCal}"),
      );
      supper.add(
        Meal(
          dishName: data[i].monday,
          serving: data[i].mondayServing,
          carbs: data[i].mondayCarbs,
          fiber: data[i].mondayFiber,
          calories: data[i].mondayCal,
          protein: data[i].mondayProtein,
          fats: data[i].mondayFats,
        ),
      );
    }
  }

  //Tuesday
  if (day == 2) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].tuesday} ${data[i].tuesdayCal}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].tuesday,
          serving: data[i].tuesdayServing,
          carbs: data[i].tuesdayCarbs,
          fiber: data[i].tuesdayFiber,
          calories: data[i].tuesdayCal,
          protein: data[i].tuesdayProtein,
          fats: data[i].tuesdayFats,
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].tuesday} ${data[i].tuesdayCal}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].tuesday,
          serving: data[i].tuesdayServing,
          carbs: data[i].tuesdayCarbs,
          fiber: data[i].tuesdayFiber,
          calories: data[i].tuesdayCal,
          protein: data[i].tuesdayProtein,
          fats: data[i].tuesdayFats,
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].tuesday} ${data[i].tuesdayCal}"),
      );
      snek.add(
        Meal(
          dishName: data[i].tuesday,
          serving: data[i].tuesdayServing,
          carbs: data[i].tuesdayCarbs,
          fiber: data[i].tuesdayFiber,
          calories: data[i].tuesdayCal,
          protein: data[i].tuesdayProtein,
          fats: data[i].tuesdayFats,
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].tuesday} ${data[i].tuesdayCal}"),
      );
      supper.add(
        Meal(
          dishName: data[i].tuesday,
          serving: data[i].tuesdayServing,
          carbs: data[i].tuesdayCarbs,
          fiber: data[i].tuesdayFiber,
          calories: data[i].tuesdayCal,
          protein: data[i].tuesdayProtein,
          fats: data[i].tuesdayFats,
        ),
      );
    }
  }

  if (day == 3) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].wednesday} ${data[i].wednesdayCal}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].wednesday,
          serving: data[i].wednesdayServing,
          carbs: data[i].wednesdayCarbs,
          fiber: data[i].wednesdayFiber,
          calories: data[i].wednesdayCal,
          protein: data[i].wednesdayProtein,
          fats: data[i].wednesdayFats,
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].wednesday} ${data[i].wednesdayCal}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].wednesday,
          serving: data[i].wednesdayServing,
          carbs: data[i].wednesdayCarbs,
          fiber: data[i].wednesdayFiber,
          calories: data[i].wednesdayCal,
          protein: data[i].wednesdayProtein,
          fats: data[i].wednesdayFats,
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].wednesday} ${data[i].wednesdayCal}"),
      );
      snek.add(
        Meal(
          dishName: data[i].wednesday,
          serving: data[i].wednesdayServing,
          carbs: data[i].wednesdayCarbs,
          fiber: data[i].wednesdayFiber,
          calories: data[i].wednesdayCal,
          protein: data[i].wednesdayProtein,
          fats: data[i].wednesdayFats,
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].wednesday} ${data[i].wednesdayCal}"),
      );
      supper.add(
        Meal(
          dishName: data[i].wednesday,
          serving: data[i].wednesdayServing,
          carbs: data[i].wednesdayCarbs,
          fiber: data[i].wednesdayFiber,
          calories: data[i].wednesdayCal,
          protein: data[i].wednesdayProtein,
          fats: data[i].wednesdayFats,
        ),
      );
    }
  }

  if (day == 4) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].thursday} ${data[i].thursdayCal}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].thursday,
          serving: data[i].thursdayServing,
          carbs: data[i].thursdayCarbs,
          fiber: data[i].thursdayFiber,
          calories: data[i].thursdayCal,
          protein: data[i].thursdayProtein,
          fats: data[i].thursdayFats,
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].thursday} ${data[i].thursdayCal}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].thursday,
          serving: data[i].thursdayServing,
          carbs: data[i].thursdayCarbs,
          fiber: data[i].thursdayFiber,
          calories: data[i].thursdayCal,
          protein: data[i].thursdayProtein,
          fats: data[i].thursdayFats,
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].thursday} ${data[i].thursdayCal}"),
      );
      snek.add(
        Meal(
          dishName: data[i].thursday,
          serving: data[i].thursdayServing,
          carbs: data[i].thursdayCarbs,
          fiber: data[i].thursdayFiber,
          calories: data[i].thursdayCal,
          protein: data[i].thursdayProtein,
          fats: data[i].thursdayFats,
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].thursday} ${data[i].thursdayCal}"),
      );
      supper.add(
        Meal(
          dishName: data[i].thursday,
          serving: data[i].thursdayServing,
          carbs: data[i].thursdayCarbs,
          fiber: data[i].thursdayFiber,
          calories: data[i].thursdayCal,
          protein: data[i].thursdayProtein,
          fats: data[i].thursdayFats,
        ),
      );
    }
  }

  if (day == 5) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].friday} ${data[i].fridayCal}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].friday,
          serving: data[i].fridayServing,
          carbs: data[i].fridayCarbs,
          fiber: data[i].fridayFiber,
          calories: data[i].fridayCal,
          protein: data[i].fridayProtein,
          fats: data[i].fridayFats,
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].friday} ${data[i].fridayCal}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].friday,
          serving: data[i].fridayServing,
          carbs: data[i].fridayCarbs,
          fiber: data[i].fridayFiber,
          calories: data[i].fridayCal,
          protein: data[i].fridayProtein,
          fats: data[i].fridayFats,
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].friday} ${data[i].fridayCal}"),
      );
      snek.add(
        Meal(
          dishName: data[i].friday,
          serving: data[i].fridayServing,
          carbs: data[i].fridayCarbs,
          fiber: data[i].fridayFiber,
          calories: data[i].fridayCal,
          protein: data[i].fridayProtein,
          fats: data[i].fridayFats,
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].friday} ${data[i].fridayCal}"),
      );
      supper.add(
        Meal(
          dishName: data[i].friday,
          serving: data[i].fridayServing,
          carbs: data[i].fridayCarbs,
          fiber: data[i].fridayFiber,
          calories: data[i].fridayCal,
          protein: data[i].fridayProtein,
          fats: data[i].fridayFats,
        ),
      );
    }
  }

  if (day == 6) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].saturday} ${data[i].saturdayCal}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].saturday,
          serving: data[i].saturdayServing,
          carbs: data[i].saturdayCarbs,
          fiber: data[i].saturdayFiber,
          calories: data[i].saturdayCal,
          protein: data[i].saturdayProtein,
          fats: data[i].saturdayFats,
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].saturday} ${data[i].saturdayCal}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].saturday,
          serving: data[i].saturdayServing,
          carbs: data[i].saturdayCarbs,
          fiber: data[i].saturdayFiber,
          calories: data[i].saturdayCal,
          protein: data[i].saturdayProtein,
          fats: data[i].saturdayFats,
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].saturday} ${data[i].saturdayCal}"),
      );
      snek.add(
        Meal(
          dishName: data[i].saturday,
          serving: data[i].saturdayServing,
          carbs: data[i].saturdayCarbs,
          fiber: data[i].saturdayFiber,
          calories: data[i].saturdayCal,
          protein: data[i].saturdayProtein,
          fats: data[i].saturdayFats,
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].saturday} ${data[i].saturdayCal}"),
      );
      supper.add(
        Meal(
          dishName: data[i].saturday,
          serving: data[i].saturdayServing,
          carbs: data[i].saturdayCarbs,
          fiber: data[i].saturdayFiber,
          calories: data[i].saturdayCal,
          protein: data[i].saturdayProtein,
          fats: data[i].saturdayFats,
        ),
      );
    }
  }

  if (day == 7) {
    for (var i = breakfastIndex + 2; i < lunchIndex; i++) {
      breakfast.add(
        Text("${data[i].sunday} ${data[i].sundayCal}"),
      );
      brakefast.add(
        Meal(
          dishName: data[i].sunday,
          serving: data[i].sundayServing,
          carbs: data[i].sundayCarbs,
          fiber: data[i].sundayFiber,
          calories: data[i].sundayCal,
          protein: data[i].sundayProtein,
          fats: data[i].sundayFats,
        ),
      );
    }

    for (var i = lunchIndex + 2; i < snacksIndex; i++) {
      lunch.add(
        Text("${data[i].sunday} ${data[i].sundayCal}"),
      );
      lonch.add(
        Meal(
          dishName: data[i].sunday,
          serving: data[i].sundayServing,
          carbs: data[i].sundayCarbs,
          fiber: data[i].sundayFiber,
          calories: data[i].sundayCal,
          protein: data[i].sundayProtein,
          fats: data[i].sundayFats,
        ),
      );
    }

    for (var i = snacksIndex + 2; i < dinnerIndex; i++) {
      snacks.add(
        Text("${data[i].sunday} ${data[i].sundayCal}"),
      );
      snek.add(
        Meal(
          dishName: data[i].sunday,
          serving: data[i].sundayServing,
          carbs: data[i].sundayCarbs,
          fiber: data[i].sundayFiber,
          calories: data[i].sundayCal,
          protein: data[i].sundayProtein,
          fats: data[i].sundayFats,
        ),
      );
    }

    for (var i = dinnerIndex + 2; i < data.length; i++) {
      dinner.add(
        Text("${data[i].sunday} ${data[i].sundayCal}"),
      );
      supper.add(
        Meal(
          dishName: data[i].sunday,
          serving: data[i].sundayServing,
          carbs: data[i].sundayCarbs,
          fiber: data[i].sundayFiber,
          calories: data[i].sundayCal,
          protein: data[i].sundayProtein,
          fats: data[i].sundayFats,
        ),
      );
    }
  }

  return MediaQuery(
    data: MediaQuery.of(context).copyWith(
      textScaleFactor: 0.8,
    ),
    child: PageView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.0125 * _screenHeight,
            ),
            Row(
              children: [
                SizedBox(
                  width: 0.05 * _screenWidth,
                ),
                Container(
                  height: 0.125 * _screenHeight,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/toaster.png"),
                  ),
                ),
                SizedBox(
                  width: 0.05 * _screenWidth,
                ),
                Text(
                  "BREAKFAST",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 0.06 * _screenHeight,
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
                    fontSize: 0.028 * _screenHeight,
                    fontWeight: FontWeight.bold),
                dataRowHeight: 0.068 * _screenHeight,
                columns: [
                  DataColumn(label: Text("Meal Name")),
                  DataColumn(label: Text("Serving")),
                  DataColumn(label: Text("Calories")),
                  DataColumn(label: Text("Fiber")),
                  DataColumn(label: Text("Carbohydrates")),
                  DataColumn(label: Text("Fats")),
                  DataColumn(label: Text("Protein")),
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
                                  fontSize: 0.028 * _screenHeight),
                            ),
                          ),
                          DataCell(
                            Text(
                              e.serving,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.028 * _screenHeight),
                            ),
                          ),
                          DataCell(
                            Text(
                              e.calories,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.028 * _screenHeight),
                            ),
                          ),
                          DataCell(
                            Text(
                              e.fiber,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.028 * _screenHeight),
                            ),
                          ),
                          DataCell(Text(
                            e.carbs,
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.028 * _screenHeight),
                          )),
                          DataCell(
                            Text(
                              e.fats,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.028 * _screenHeight),
                            ),
                          ),
                          DataCell(
                            Text(
                              e.protein,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.028 * _screenHeight),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: _screenWidth * 0.025),
              child: Container(
                width: 0.3 * _screenWidth,
                decoration: BoxDecoration(
                  color: Color(0xFFC9CCD5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.05 * _screenHeight),
                    topRight: Radius.circular(0.05 * _screenHeight),
                    bottomLeft: Radius.circular(0.05 * _screenHeight),
                    bottomRight: Radius.circular(0.05 * _screenHeight),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "swipe",
                      style: TextStyle(
                          fontFamily: 'Gilroy', fontSize: 0.02 * _screenHeight),
                    ),
                    Icon(
                      Icons.arrow_forward,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 0.0125 * _screenHeight,
          ),
          Row(
            children: [
              SizedBox(
                width: 0.05 * _screenWidth,
              ),
              Container(
                height: 0.125 * _screenHeight,
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/sandwich.png"),
                ),
              ),
              SizedBox(
                width: 0.05 * _screenWidth,
              ),
              Text("LUNCH",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 0.06 * _screenHeight,
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
                  fontSize: 0.028 * _screenHeight,
                  fontWeight: FontWeight.bold),
              dataRowHeight: 0.068 * _screenHeight,
              dataTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy',
                fontSize: 0.028 * _screenHeight,
              ),
              columns: [
                DataColumn(label: Text("Meal Name")),
                DataColumn(label: Text("Serving")),
                DataColumn(label: Text("Calories")),
                DataColumn(label: Text("Fiber")),
                DataColumn(label: Text("Carbohydrates")),
                DataColumn(label: Text("Fats")),
                DataColumn(label: Text("Protein")),
              ],
              rows: lonch
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          Text(e.dishName),
                        ),
                        DataCell(
                          Text(e.serving),
                        ),
                        DataCell(
                          Text(e.calories),
                        ),
                        DataCell(
                          Text(e.fiber),
                        ),
                        DataCell(Text(e.carbs)),
                        DataCell(
                          Text(e.fats),
                        ),
                        DataCell(
                          Text(e.protein),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: _screenWidth * 0.025),
            child: Container(
              width: 0.3 * _screenWidth,
              decoration: BoxDecoration(
                color: Color(0xFFC9CCD5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.05 * _screenHeight),
                  topRight: Radius.circular(0.05 * _screenHeight),
                  bottomLeft: Radius.circular(0.05 * _screenHeight),
                  bottomRight: Radius.circular(0.05 * _screenHeight),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "swipe",
                    style: TextStyle(
                        fontFamily: 'Gilroy', fontSize: 0.02 * _screenHeight),
                  ),
                  Icon(
                    Icons.arrow_forward,
                  )
                ],
              ),
            ),
          ),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 0.0125 * _screenHeight,
          ),
          Row(
            children: [
              SizedBox(
                width: 0.05 * _screenWidth,
              ),
              Container(
                height: 0.125 * _screenHeight,
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/coffee-bean.png"),
                ),
              ),
              SizedBox(
                width: 0.05 * _screenWidth,
              ),
              Text("SNACKS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 0.06 * _screenHeight,
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
                  fontSize: 0.028 * _screenHeight,
                  fontWeight: FontWeight.bold),
              dataRowHeight: 0.068 * _screenHeight,
              dataTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy',
                fontSize: 0.028 * _screenHeight,
              ),
              columns: [
                DataColumn(label: Text("Meal Name")),
                DataColumn(label: Text("Serving")),
                DataColumn(label: Text("Calories")),
                DataColumn(label: Text("Fiber")),
                DataColumn(label: Text("Carbohydrates")),
                DataColumn(label: Text("Fats")),
                DataColumn(label: Text("Protein")),
              ],
              rows: snek
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          Text(e.dishName),
                        ),
                        DataCell(
                          Text(e.serving),
                        ),
                        DataCell(
                          Text(e.calories),
                        ),
                        DataCell(
                          Text(e.fiber),
                        ),
                        DataCell(Text(e.carbs)),
                        DataCell(
                          Text(e.fats),
                        ),
                        DataCell(
                          Text(e.protein),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: _screenWidth * 0.025),
            child: Container(
              width: 0.3 * _screenWidth,
              decoration: BoxDecoration(
                color: Color(0xFFC9CCD5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.05 * _screenHeight),
                  topRight: Radius.circular(0.05 * _screenHeight),
                  bottomLeft: Radius.circular(0.05 * _screenHeight),
                  bottomRight: Radius.circular(0.05 * _screenHeight),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "swipe",
                    style: TextStyle(
                        fontFamily: 'Gilroy', fontSize: 0.02 * _screenHeight),
                  ),
                  Icon(
                    Icons.arrow_forward,
                  )
                ],
              ),
            ),
          ),
        ]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.0125 * _screenHeight,
            ),
            Row(
              children: [
                SizedBox(
                  width: 0.05 * _screenWidth,
                ),
                Container(
                  height: 0.125 * _screenHeight,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/cutlery.png"),
                  ),
                ),
                SizedBox(
                  width: 0.05 * _screenWidth,
                ),
                Text("DINNER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 0.06 * _screenHeight,
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
                    fontSize: 0.028 * _screenHeight,
                    fontWeight: FontWeight.bold),
                dataRowHeight: 0.068 * _screenHeight,
                dataTextStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gilroy',
                  fontSize: 0.028 * _screenHeight,
                ),
                columns: [
                  DataColumn(label: Text("Meal Name")),
                  DataColumn(label: Text("Serving")),
                  DataColumn(label: Text("Calories")),
                  DataColumn(label: Text("Fiber")),
                  DataColumn(label: Text("Carbohydrates")),
                  DataColumn(label: Text("Fats")),
                  DataColumn(label: Text("Protein")),
                ],
                rows: supper
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(
                            Text(e.dishName),
                          ),
                          DataCell(
                            Text(e.serving),
                          ),
                          DataCell(
                            Text(e.calories),
                          ),
                          DataCell(
                            Text(e.fiber),
                          ),
                          DataCell(Text(e.carbs)),
                          DataCell(
                            Text(e.fats),
                          ),
                          DataCell(
                            Text(e.protein),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: _screenWidth * 0.025),
              child: Container(
                width: 0.3 * _screenWidth,
                decoration: BoxDecoration(
                  color: Color(0xFFC9CCD5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.05 * _screenHeight),
                    topRight: Radius.circular(0.05 * _screenHeight),
                    bottomLeft: Radius.circular(0.05 * _screenHeight),
                    bottomRight: Radius.circular(0.05 * _screenHeight),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "swipe",
                      style: TextStyle(
                          fontFamily: 'Gilroy', fontSize: 0.02 * _screenHeight),
                    ),
                    Icon(
                      Icons.arrow_forward,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
      scrollDirection: Axis.vertical,
    ),
  );
}
