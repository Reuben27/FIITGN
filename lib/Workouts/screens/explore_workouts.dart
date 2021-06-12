// import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Workout_provider.dart';
import '../models/WorkoutModel.dart';
import '../screens/exercises_in_workout.dart';
import '../models/Exercise_db_model.dart';

class Explore_Workouts extends StatefulWidget {
  static const routeName = '\allWorkouts';

  @override
  _Explore_WorkoutsState createState() => _Explore_WorkoutsState();
}

class _Explore_WorkoutsState extends State<Explore_Workouts> {
  //  final workoutDataProvider = Provider.of<WorkoutsProvider>(context);
  // TODO
  //
  // ADD DIFFERENT SLIDING PAGES FOR PRIVATE AND PUBLIC WORKOUTS
  // SHOW OTHER DETAILS AND IMAGES AND STUFF
  var isInit = true;
  var unFollowIcon = Icon(Icons.add_box_outlined);
  var followIcon = Icon(Icons.add_box);
  var icon = Icon(Icons.add_box_outlined);
  List<dynamic> iconList = [];
  void followWorkout(String workoutId) {
    final workoutDataProvider = Provider.of<Workouts_Provider>(context);
    List<WorkoutModel> workoutsLists = workoutDataProvider.workoutList;
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<Workouts_Provider>(context).showAllWorkouts();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final workoutDataProvider = Provider.of<Workouts_Provider>(context);
    final exercise_provier =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context);
    final List<WorkoutModel> workoutsList = workoutDataProvider.workoutList;
    final String user_id = workoutDataProvider.userId;
    workoutsList.forEach((element) {
      if (element.listOfFollowersId.contains(user_id)) {
        iconList.add(followIcon);
      } else {
        iconList.add(unFollowIcon);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('All Workouts'),
      ),
      body: ListView.builder(
        itemCount: workoutsList.length,
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              List<ExerciseDbModel> exercises = exercise_provier
                  .exercisesBasesOnId(workoutsList[i].listOfExercisesId);
              Navigator.pushNamed(context, Exercises_in_Workout.routeName,
                  arguments: exercises);
            },
            child: Card(
              child: Column(
                children: [
                  Text(
                    workoutsList[i].workoutName,
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
                  ),
                  Text("Creator - " + workoutsList[i].creator_name),
                  // Text("Creator Id - " + workoutsList[i].creatorId),
                  InkWell(
                    child: iconList[i],
                    onTap: () async {
                      //  function to follow/unfollow the workout
                      print("test");
                      if (workoutsList[i].listOfFollowersId.contains(user_id)) {
                        if (workoutsList[i].creatorId != user_id) {
                          await workoutDataProvider.unFollowWorkout(
                              workoutsList[i], workoutsList[i].workoutId);
                          print("http unfollow done");
                          setState(() {
                            iconList[i] = unFollowIcon;
                            print("state set");
                          });
                        } else {
                          // cant unfollow your own workout
                          print("cant unfollow your own workout");
                          //
                          // TODO Add a snackbar thats tells user they cant unfollow workouts they have created
                        }
                      } else if (!workoutsList[i]
                          .listOfFollowersId
                          .contains(user_id)) {
                        await workoutDataProvider.followWorkout(
                            workoutsList[i], workoutsList[i].workoutId);
                        print("http follow done");
                        setState(() {
                          iconList[i] = followIcon;
                          print("state set");
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
