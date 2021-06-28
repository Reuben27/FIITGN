import 'package:date_format/date_format.dart';
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
    if (exercices.length == 0) {
      print("no exercises to log");
    } else {
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
  }

  startTimer() {
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  stopTimer() {
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  Widget addSet() {
    /// returns a row
    return Center(
      child: Container(
        // crossAxisAlignment: CrossAxisAlignment.center,

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
    return Center(
      child: Container(
        // crossAxisAlignment: CrossAxisAlignment.center,

        // width: MediaQuery.of(context).size.width / 5,
        child: Rep_Counter(),
      ),
    );
  }

  Widget addWeights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weights (in kilograms)",
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Done",
              style: TextStyle(
                  fontFamily: 'Gilroy', fontSize: 20, color: Colors.black),
            ),
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          ],
        ),
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
      ),
    );
  }

  Future addSetsRepsWeights(
      BuildContext context, List<ExerciseDbModel> exercises, int index) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        // margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0), topRight: Radius.circular(0)),
          color: Colors.blueGrey[200],
        ),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                exercises[index].exerciseName,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Text(
                "Set Number",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(child: Container(child: addSet())),
              Text(
                "Reps",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(child: Container(child: addRep())),
              addWeights(),
              SizedBox(
                width: MediaQuery.of(context).size.height / 50,
              ),
              done(context, exercises, index),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> routeArgs =
        ModalRoute.of(context).settings.arguments as Map;
    List<ExerciseDbModel> exercises = routeArgs['exercises'];
    String workoutName = routeArgs['workoutName'];
    int pauser = 0;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.blueGrey[300],
        //   elevation: 0,
        //   onPressed: () {},
        //   child: Row(
        //     children: [
        //       Text(
        //         "Swipe",
        //         style: TextStyle(
        //           fontStyle: FontStyle.italic,
        //           fontFamily: 'Gilroy',
        //         ),
        //       ),
        //       Icon(
        //         Icons.arrow_forward_ios,
        //         color: Colors.white,
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          bottom: PreferredSize(
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "DURATION",
                    style: TextStyle(fontFamily: 'Gilroy'),
                  )),
                  StreamBuilder<int>(
                    stream: stopWatchTimer.rawTime,
                    initialData: stopWatchTimer.rawTime.value,
                    builder: (context, snapshot) {
                      final value = snapshot.data;
                      displayTime = StopWatchTimer.getDisplayTime(value,
                          hours: true, milliSecond: false);
                      return Text(
                        displayTime,
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize:
                                0.15 * MediaQuery.of(context).size.height / 3,
                            // color: Colors.white,
                            fontWeight: FontWeight.w700),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: OutlinedButton(
                          onPressed: stopTimer,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pause",
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.pause,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: OutlinedButton(
                          onPressed: startTimer,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Resume",
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 7),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            workoutName.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: PageView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Expanded(
                  child: Container(
                    child: ListView.separated(
                        separatorBuilder: (ctx, i) => SizedBox(
                              height: MediaQuery.of(context).size.height / 50,
                            ),
                        itemCount: exercises.length,
                        itemBuilder: (ctx, i) {
                          return Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: Image(
                                    image: NetworkImage(exercises[i].imageUrl),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[200],
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20))),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Column(
                                      children: [
                                        Text(
                                          exercises[i].exerciseName,
                                          style: TextStyle(
                                              fontFamily: "Gilroy",
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.8,
                                          child: OutlinedButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Record Set",
                                                  style: TextStyle(
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                Icon(
                                                  Icons.note_add_outlined,
                                                  color: Colors.black,
                                                )
                                              ],
                                            ),
                                            onPressed: () {
                                              // print("i= " + index.toString());
                                              addSetsRepsWeights(
                                                  ctx, exercises, i);
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
                        }),
                  ),
                )
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
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius: BorderRadius.circular(20)),
                          // margin: EdgeInsets.only(top:10,bottom:10,left: 10, right: 15),
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 20, bottom: 20, left: 10, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  setsAndReps[j].exerciseName,
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          VerticalDivider(
                                            color: Colors.black,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Set:",
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                setsAndReps[j]
                                                    .setNumber
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          VerticalDivider(color: Colors.black),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Reps:",
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                setsAndReps[j]
                                                    .numOfReps
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Weight:",
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                setsAndReps[j]
                                                        .weight
                                                        .toString() +
                                                    " kg",
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
