import 'package:flutter/material.dart';
import '../data/nutrition.dart';
import '../widgets/day.dart';

class NutritionScreen extends StatefulWidget {
  static const routeName = '\Nutrition_Screen';
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
    items = nutri_data;
    getIndices(items);
    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple[100],
            bottom: TabBar(
              indicatorWeight: 3,
              tabs: [
                Tab(
                  child: Text(
                    "Today",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Tomorrow",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                )
              ],
            ),
            title: Text(
              "MESS AND NUTRITION",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Gilroy'),
            ),
          ),
          body: TabBarView(
            children: [
              // SizedBox(height: 26),

              getDay(context, items, DateTime.now().weekday),

              getDay(context, items, DateTime.now().weekday + 1),
              // SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
