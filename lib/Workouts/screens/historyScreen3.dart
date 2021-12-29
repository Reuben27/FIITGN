import 'package:fiitgn/Workouts/models/Passer2-3.dart';
import 'package:fiitgn/Workouts/models/Passer3-4.dart';
import 'package:fiitgn/Workouts/models/Workout_Data_Log_Model.dart';
import 'package:fiitgn/Workouts/models/Workouts_Log_Model.dart';
import 'package:fiitgn/Workouts/screens/workout_history_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutsHistory3 extends StatefulWidget {
  static const routeName = 'workoutHistory3';

  @override
  _WorkoutsHistory3State createState() => _WorkoutsHistory3State();
}

class _WorkoutsHistory3State extends State<WorkoutsHistory3> {
  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    final Passer p = ModalRoute.of(context).settings.arguments as Passer;
    final List<Workout_Data_Model> workout_histories = p.x;
    final String dayName = p.dayName;
    print("workout histories is ");
    print(workout_histories);
    // final workouts_provider = Provider.of<Workouts_Provider>(context);
    // final List<Workout_Data_Model> workout_histories =
    //     workouts_provider.loggedWorkouts;
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF93B5C6),
          title: Text(
            p.dayName, //need to fix
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: workout_histories.length == 0
            ? Center(
                child: Text('No workouts logged yet'),
              )
            : ListView.builder(
                itemCount: workout_histories.length,
                itemBuilder: (ctx, i) {
                  String formattedDate = DateFormat.MMMMEEEEd()
                      .format(DateTime.parse(workout_histories[i].date));
                  String formattedTime = DateFormat.jm()
                      .format(DateTime.parse(workout_histories[i].date));
                  return InkWell(
                    onTap: () {
                      List<Workout_Log_Model> listOfSetsReps =
                          workout_histories[i].listOfSetsRepsWeights;
                      Passer3_4 p = Passer3_4(
                          listOfSetsReps: listOfSetsReps,
                          duration_hours: workout_histories[i].duration_hours,
                          duration_minutes:
                              workout_histories[i].duration_minutes,
                          duration_seconds:
                              workout_histories[i].duration_seconds);
                      Navigator.pushNamed(
                          context, Workout_History_Details.routeName,
                          arguments: p);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0.00625 * _screenHeight,
                        bottom: 0.00625 * _screenHeight,
                        left: 0.03 * _screenWidth,
                        right: 0.03 * _screenWidth,
                      ),
                      child: Container(
                        width: _screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xFFC9CCD5),
                          borderRadius:
                              BorderRadius.circular(0.02 * _screenHeight),
                        ),
                        // margin: EdgeInsets.only(top:10,bottom:10,left: 10, right: 15),

                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 0.025 * _screenHeight,
                            bottom: 0.025 * _screenHeight,
                            left: 0.03 * _screenWidth,
                            right: 0.03 * _screenWidth,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workout_histories[i]
                                        .workoutName, //pass workout name not plan name
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.04 * _screenHeight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    formattedDate + " at " + formattedTime,
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.025 * _screenHeight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
