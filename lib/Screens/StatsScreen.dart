import 'dart:ui';
import 'package:flutter/material.dart';
import '../Cardio/screens/YourRunsStatsScreen.dart';
import '../Cardio/screens/yourCycleStatsScreen.dart';
import '../../Notifications/Notifications.dart';

class StatsScreen extends StatelessWidget {
  static const routeName = '\statsScreenRouteName';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: Hero(
                    tag: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.asset(
                        'assets/statsTile2.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 40,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: MediaQuery.of(context).size.width / 13.5,
                    color: Colors.black,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 25.5,
                  bottom: MediaQuery.of(context).size.height / 20,
                  child: Text(
                    'Check your Stats:',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 10.3,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, YourRuns.routeName),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: ExactAssetImage("assets/yourRunsblur.jpg"),
                          fit: BoxFit.cover),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Text('Runs',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 6)),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, Notifications.routeName),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: ExactAssetImage("assets/yourRunsblur.jpg"),
                          fit: BoxFit.cover),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Text('Notifications',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 6)),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, YourCycleStats.routeName),
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: ExactAssetImage("assets/cyclingStats.jpg"),
                        fit: BoxFit.cover),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Text('Cycling',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 6)),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            InkWell(
              onTap: () {
                //Navigator.pushNamed(context, WorkoutStatScreen.routeName),
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: ExactAssetImage("assets/yourWorkblurr.jpg"),
                          fit: BoxFit.cover),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Text('Workouts',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 6)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
