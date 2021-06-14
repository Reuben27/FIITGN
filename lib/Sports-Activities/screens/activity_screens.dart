import 'package:flutter/material.dart';
import '../data/activity_data.dart';

class Activity_Screen extends StatefulWidget {
  static const routeName = '\ActivitiesScreen';
  @override
  _Activity_ScreenState createState() => _Activity_ScreenState();
}

class _Activity_ScreenState extends State<Activity_Screen> {
  List<ActivityData> activities = List<ActivityData>.empty();

  @override
  void initState() {
    // TODO: implement initState
    inInIt();
    print(" in init ran");
    super.initState();
  }

  void inInIt() async {
    activities = await getActivityData();
    print("activities loaded");
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Activities'),
        ),
        body: ListView.builder(
            itemCount: activities.length,
            itemBuilder: (ctx, i) {
              return Text(activities[i].activities);
            }));
  }
}
