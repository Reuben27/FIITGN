import 'package:fiitgn/Workouts/models/Exercise_db_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeeklyWorkoutDetails extends StatelessWidget {
  static const routeName = 'WeeklyWorkoutDetails';
  @override
  Widget build(BuildContext context) {
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    final List<String> exercise_ids = args['exercise_ids'];
    final String workoutName = args['workoutName'];
    ModalRoute.of(context).settings.arguments as List<String>;
    Map<String, ExerciseDbModel> exerciseAndNames =
        exerciseDataProvider.map_exerId_exerName_per_exercise(exercise_ids);
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(workoutName),
        ),
        body: ListView.builder(
          itemCount: exerciseAndNames.length,
          itemBuilder: (_, i) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    left: 0.03 * _screenWidth,
                    right: 0.03 * _screenWidth,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.02 * _screenHeight),
                      topRight: Radius.circular(0.02 * _screenHeight),
                    ),
                    child: Image(
                      image: NetworkImage(exerciseAndNames[i].imageUrl),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    left: 0.03 * _screenWidth,
                    right: 0.03 * _screenWidth,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(0.02 * _screenHeight),
                        bottomLeft: Radius.circular(0.02 * _screenHeight),
                      )),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0.00625 * _screenHeight,
                        bottom: 0.00625 * _screenHeight,
                      ),
                      child: Column(
                        children: [
                          Text(
                            exerciseAndNames[i].exerciseName,
                            style: TextStyle(
                                fontFamily: "Gilroy",
                                fontSize: 0.04 * _screenHeight,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 0.35 * _screenWidth,
                            child: OutlinedButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Record Set",
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 0.025 * _screenHeight,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.note_add_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              onPressed: () {
                                //// add shit here @abhiram
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
