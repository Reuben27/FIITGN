import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Workout_provider.dart';
import '../models/Workout_Data_Log_Model.dart';
import 'package:intl/intl.dart';
import './workout_history_details.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  static const routeName = 'workout_history';

  @override
  _WorkoutHistoryScreenState createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  List<Workout_Data_Model> workout_histories = List.empty(growable: true);

  @override
  void initState() {
    in_init();
    // TODO: implement initState
    super.initState();
  }

  void in_init() async {
    final workouts_provider =
        Provider.of<Workouts_Provider>(context, listen: false);
    await workouts_provider.getWorkoutLogFromDB();
  }

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
                      Navigator.pushNamed(
                          context, Workout_History_Details.routeName,
                          arguments:
                              workout_histories[i].listOfSetsRepsWeights);
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
                          color: Colors.blueGrey[200],
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
                                    workout_histories[i].workoutName,
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
