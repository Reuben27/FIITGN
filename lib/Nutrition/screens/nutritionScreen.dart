import 'package:flutter/material.dart';
import '../data/nutrition.dart';
import '../widgets/day.dart';
import '../widgets/now.dart';

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
      body: ListView(
        children: [
          Text("Now: "),
          getNow(items),
          SizedBox(height: 26),
          Text("Today: "),
          getDay(items, DateTime.now().weekday),
          SizedBox(height: 26),
          Text("Tomorrow: "),
          getDay(items, DateTime.now().weekday + 1),
          SizedBox(height: 26),
        ],
      ),
    );
  }
}
