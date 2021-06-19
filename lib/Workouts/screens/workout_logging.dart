import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../models/Exercise_db_model.dart';
import '../models/Workouts_Log_Model.dart';
import 'package:intl/intl.dart';
import '../../Screens/HomeScreen.dart';
import '../../Providers/DataProvider.dart';
import '../models/Workout_Data_Log_Model.dart';
import '../Widgets/rep_counter.dart';
import '../Widgets/set_counter.dart';
import '../models/Workout_provider.dart';

class Workout_Logging extends StatefulWidget {
  static const routeName = '\Workout_Logging_Screen';

  @override
  _Workout_LoggingState createState() => _Workout_LoggingState();
}

// STORES THE DATA OF THE SETS AND REPS DONE
// ignore: deprecated_member_use
List<Workout_Log_Model> setsAndReps = List<Workout_Log_Model>();
// ignore: deprecated_member_use
List<Workout_Log_Model> workoutList = List<Workout_Log_Model>();

class _Workout_LoggingState extends State<Workout_Logging> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  String displayTime;

  TextEditingController weightsEditingController = TextEditingController();

  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    weightsEditingController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
    stopTimer();
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'End Workout without Logging?',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                // ignore: deprecated_member_use
                setsAndReps = List<Workout_Log_Model>();
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
                // Navigator.of(context).pop(true);
                // Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                startTimer();
                Navigator.of(_).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void addNewSet(String exerciseName, String exerciseId, int setVal, int repVal,
      int weightsVal) {
    final Workout_Log_Model newData = Workout_Log_Model(
      exerciseName: exerciseName,
      exerciseId: exerciseId,
      numOfReps: repVal,
      setNumber: setVal,
      weight: weightsVal,
    );
    setsAndReps.add(newData);
  }

  void saveData(List<Workout_Log_Model> exercices, String workoutName) {
    print("save data initiated");
    String uid = Data_Provider().uid;
    List time = displayTime.split(":");
    String duration_minutes = time[1];
    String duration_hours = time[0];
    String duration_seconds = time[2];

    /// change this date to the starting time of the workout
    String date = DateTime.now().toIso8601String();
    Workout_Data_Model data = Workout_Data_Model(
        duration_seconds: duration_seconds,
        duration_hours: duration_hours,
        duration_minutes: duration_minutes,
        databaseId: "",
        uid: uid,
        date: date,
        listOfSetsRepsWeights: exercices,
        user_name: Data_Provider().name,
        workoutName: workoutName);
    // ignore: deprecated_member_use
    setsAndReps = List<Workout_Log_Model>();
    showDialog(
      context: context,
      builder: (ctx) {
        stopTimer();
        return AlertDialog(
          title: Text("Do you want to save and End?"),
          actions: [
            FloatingActionButton(
              child: Text("Yes"),
              onPressed: () async {
                await Workouts_Provider().saveWorkoutToDb(data);
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
            ),
            FloatingActionButton(
              child: Text("No"),
              onPressed: () {
                startTimer();
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  startTimer() {
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  stopTimer() {
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  Widget addSet() {
    /// returns a row
    return Container(
      // crossAxisAlignment: CrossAxisAlignment.center,
      child:
          // Text("Add Set Number:  "),
          Container(
        // width: MediaQuery.of(context).size.width / 5,
        child: Set_Counter(),
      ),
    );
  }

  Widget addRep() {
    /// returns a row
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Text("Add number of reps:  "),
    //     Container(
    //       width: MediaQuery.of(context).size.width / 2,
    //       child: Rep_Counter(),
    //     )
    //   ],
    // );
    return Container(
      // crossAxisAlignment: CrossAxisAlignment.center,
      child:
          // Text("Add Set Number:  "),
          Container(
        // width: MediaQuery.of(context).size.width / 5,
        child: Rep_Counter(),
      ),
    );
  }

  Widget addWeights() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Add Weights:  "),
        Container(
          width: MediaQuery.of(context).size.width / 5,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: weightsEditingController,
          ),
        ),
      ],
    );
  }

  Widget done(BuildContext ctx, List<ExerciseDbModel> exercises, int index) {
    return FlatButton(
      child: Text("Done"),
      onPressed: () {
        String repVal = "";
        String setVal = "";
        String weightsVal = "";
        repVal = Rep_CounterState.counter.toString();
        print("rep Val is " + repVal);
        setVal = Set_CounterState.counter.toString();
        weightsVal = weightsEditingController.text;
        // Resetting variables
        Rep_CounterState.counter = 0;
        Set_CounterState.counter = 0;
        weightsEditingController = new TextEditingController();
        print("rep Val is " + repVal);
        if (repVal == "" || setVal == "" || weightsVal == "") {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('No field should be empty.'),
                actions: [
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'))
                ],
              );
            },
          );
        } else {
          String currentExerciseId = exercises[index].exerciseId;
          String currentExerciseName = exercises[index].exerciseName;
          print(currentExerciseId + " is the id");
          // print("same exercise");
          addNewSet(
            currentExerciseName,
            currentExerciseId,
            int.parse(setVal),
            int.parse(repVal),
            int.parse(weightsVal),
          );
          // print("different exercise");
          Navigator.of(ctx).pop(true);

          setsAndReps.forEach(
            (element) {
              if (element.exerciseId == currentExerciseId) {
                workoutList.add(element);
                print(workoutList[workoutList.length - 1]);
                setState(() {});
              }
            },
          );
          // testing
          print(index.toString() + " ---> val of i after popping");
          print(setsAndReps.length.toString() + "--> len of sets and reps");
        }
      },
    );
  }

  Future addSetsRepsWeights(
      BuildContext context, List<ExerciseDbModel> exercises, int index) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add Reps'),
        actions: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addSet(),
                addRep(),
                addWeights(),
                done(context, exercises, index),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> routeArgs =
        ModalRoute.of(context).settings.arguments as Map;
    List<ExerciseDbModel> exercises = routeArgs['exercises'];
    String workoutName = routeArgs['workoutName'];
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              child: Icon(Icons.save),
              onTap: startTimer,
            ),
          ],
          title: Text(workoutName),
        ),
        body: PageView(
          children: [
            Column(
              children: [
                StreamBuilder<int>(
                  stream: stopWatchTimer.rawTime,
                  initialData: stopWatchTimer.rawTime.value,
                  builder: (context, snapshot) {
                    final value = snapshot.data;
                    displayTime = StopWatchTimer.getDisplayTime(value,
                        hours: true, milliSecond: false);
                    return Text(
                      displayTime,
                      style: TextStyle(fontSize: 40),
                    );
                  },
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: exercises.length,
                    itemBuilder: (ctx, i) {
                      return ListTile(
                        title: Text(exercises[i].exerciseName),
                        trailing: RaisedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text('Add Log'),
                          onPressed: () {
                            // print("i= " + index.toString());
                            addSetsRepsWeights(ctx, exercises, i);
                          },
                        ),
                      );
                    }),
              ],
            ),
            /////// SECOND PAGE
            Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Workout Details",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 10,
                                fontWeight: FontWeight.bold),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              saveData(setsAndReps, workoutName);
                            },
                            child: Icon(Icons.save),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: setsAndReps.length,
                      itemBuilder: (ctx, j) {
                        // print("abcde");
                        return Container(
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    image: NetworkImage(
                                      exercises
                                          .firstWhere((element) =>
                                              element.exerciseId ==
                                              setsAndReps[j].exerciseId)
                                          .imageUrl,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      setsAndReps[j].exerciseName,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Set - " +
                                              setsAndReps[j]
                                                  .setNumber
                                                  .toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "|",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Reps - " +
                                              setsAndReps[j]
                                                  .numOfReps
                                                  .toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "|",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "Weights - " +
                                              setsAndReps[j].weight.toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
