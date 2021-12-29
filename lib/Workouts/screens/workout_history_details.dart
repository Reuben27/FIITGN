import 'package:fiitgn/Workouts/models/Passer3-4.dart';
import 'package:flutter/material.dart';
import './workouts_history.dart';
import '../models/Workouts_Log_Model.dart';

class Workout_History_Details extends StatelessWidget {
  static const routeName = '/workout_details';
  // const Workout_History_Details({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    final Passer3_4 p = ModalRoute.of(context).settings.arguments;
    final List<Workout_Log_Model> workout_details = p.listOfSetsReps;
    final duration_hours = p.duration_hours;
    final durarion_minutes = p.duration_minutes;
    final duration_seconds = p.duration_seconds;
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF93B5C6),
          title: Text(
            "WORKOUT NAME",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
          bottom: PreferredSize(
            child: Container(
              // height: MediaQuery.of(context).size.height / 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.02 * _screenHeight),
                    child: Text(
                      "DURATION: " +
                          duration_hours +
                          "h " +
                          durarion_minutes +
                          "m " +
                          duration_seconds +
                          "s",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 0.03 * _screenHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size(_screenWidth, 0.05 * _screenHeight),
          ),
        ),
        body: ListView.builder(
            itemCount: workout_details.length,
            itemBuilder: (ctx, i) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFC9CCD5),
                  borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                ),
                // margin: EdgeInsets.only(top:10,bottom:10,left: 10, right: 15),
                margin: EdgeInsets.only(
                  top: 0.00625 * _screenHeight,
                  bottom: 0.00625 * _screenHeight,
                  left: 0.03 * _screenWidth,
                  right: 0.03 * _screenWidth,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: 0.00625 * _screenHeight,
                    bottom: 0.0125 * _screenHeight,
                    left: 0.03 * _screenWidth,
                    right: 0.03 * _screenWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        workout_details[i].exerciseName,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 0.04 * _screenHeight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      Container(
                        height: 0.05 * _screenHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Set:",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      workout_details[i].setNumber.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                VerticalDivider(color: Colors.black),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reps:",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      workout_details[i].numOfReps.toString(),
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                VerticalDivider(
                                  color: Colors.black,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Weight:",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      workout_details[i].weight.toString() +
                                          " kg",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
