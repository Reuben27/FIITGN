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
    var _screenHeight = MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
  var _screenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 0.8,
      ),
      child: DefaultTabController(
        length: 2,
        child:  Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.purple[100],
              bottom: TabBar(
                indicatorWeight: 0.002* _screenHeight,
                tabs: [
                  Tab(
                    child: Text(
                      "Today",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.035 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Tomorrow",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.035 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  )
                ],
              ),
              title: Text(
                "MESS MENU",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize:0.04 * _screenHeight,
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
