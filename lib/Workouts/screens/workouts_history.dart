import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Workout_provider.dart';
import '../models/Workout_Data_Log_Model.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  static const routeName = 'workout_history';
  // const WorkoutHistoryScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    final workouts_provider = Provider.of<Workouts_Provider>(context);
    final List<Workout_Data_Model> workout_histories =
        workouts_provider.loggedWorkouts;
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'WORKOUTS HISTORY',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: ListView.builder(
          itemCount: workout_histories.length,
          itemBuilder: (ctx, i) {
            String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(
              DateTime.parse(workout_histories[i].date),
            );
            return Padding(
              padding: EdgeInsets.only(
                top: 0.00625 * _screenHeight,
                bottom: 0.00625 * _screenHeight,
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
              ),
              child: Container(
                width: _screenWidth,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 0.00625 * _screenHeight,
                    bottom: 0.00625 * _screenHeight,
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
                            workout_histories[i].workoutName,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 0.04 * _screenHeight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formattedDate,
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
            );
          },
        ),
      ),
    );
  }
}
