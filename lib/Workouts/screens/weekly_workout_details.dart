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
    print("exercise ids are as follows");
    print(exercise_ids);
    final String workoutName = args['workoutName'];
    // ModalRoute.of(context).settings.arguments as List<String>;
    List<ExerciseDbModel> exerciseAndNames =
        exerciseDataProvider.exercisesBasesOnId(exercise_ids);
    // print("exercise and names");
    // print(exerciseAndNames);
    // print(exerciseAndNames[0].category);
    // print(exerciseAndNames[0x`].description);
    // print(exerciseAndNames[0].exerciseId);
    // print(exerciseAndNames[0].exerciseName);
    // print(exerciseAndNames[0].imageUrl);
    // print(exerciseAndNames[0].isWeighted);
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF93B5C6),
            title: Text(
              workoutName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 0.04 * _screenHeight,
                  fontFamily: 'Gilroy'),
            ),
          ),
          body: ListView.builder(
            itemCount: exerciseAndNames.length,
            itemBuilder: (_, i) {
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: 0.0125 * _screenHeight,
                      bottom: 0.0125 * _screenHeight,
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
                         color: Color(0xFFC9CCD5),
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
                                      "Info",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  //// add shit here @abhiram
                                  ///yeah leave this for now i got this later on
                                  ///theres no functionality here so yeah
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
          )),
    );
  }
}
