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
  int finishFlag = 0; // flag to check if finish should be showed or no
  int pauseFlag = 0;
  int resume_end_flag = 0;
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  String displayTime;

  TextEditingController weightsEditingController = TextEditingController();

  @override
  void initState() {
    print("workout logging has started");
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

  void saveData(List<Workout_Log_Model> exercices, String planName, int planDay,
      String planId, var _screenHeight, var _screenWeight) {
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
          planName: planName,
          planDay: planDay,
          planId: planId,
          duration_seconds: duration_seconds,
          duration_hours: duration_hours,
          duration_minutes: duration_minutes,
          databaseId: "",
          uid: uid,
          date: date,
          listOfSetsRepsWeights: exercices,
          user_name: Data_Provider().name,
          workoutName: planName);
      // ignore: deprecated_member_use
      // setsAndReps = List<Workout_Log_Model>();

      showDialog(
        context: context,
        builder: (ctx) {
          stopTimer();
          return AlertDialog(
            title: Text(
              "Save and Exit?",
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 0.025 * _screenHeight,
              ),
            ),
            actions: [
              OutlinedButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontFamily: 'Gilroy', fontSize: 0.025 * _screenHeight),
                ),
                onPressed: () async {
                  // ignore: deprecated_member_use
                  setsAndReps = List<Workout_Log_Model>();
                  await Workouts_Provider().saveWorkoutToDb(data);
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                },
              ),
              OutlinedButton(
                child: Text(
                  "No",
                  style: TextStyle(
                      fontFamily: 'Gilroy', fontSize: 0.025 * _screenHeight),
                ),
                onPressed: () {
                  startTimer();
                  Navigator.of(context).pop(true);
                  // setState(() {

                  // });
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
    setState(() {
      resume_end_flag = 0;
    });
  }

  stopTimer() async {
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    setState(() {
      resume_end_flag = 1;
    });
  }

  removeLog(int i) {
    setsAndReps.removeAt(i);
    setState(() {});
    // setsAndReps.forEach(
    //   (element) {
    //   //  String currentExerciseId = exercises[index].exerciseId;
    //   //   if (element.exerciseId == currentExerciseId) {
    //   //     workoutList.add(element);
    //   //     print(workoutList[workoutList.length - 1]);
    //   //     setState(() {});
    //   //   }
    //   },
    // );
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

  Widget addWeights(var _screenHeight, var _screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weights (in kilograms)",
          textScaleFactor: 0.8,
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 0.025 * _screenHeight,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 0.2 * _screenWidth,
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: weightsEditingController,
            style:
                TextStyle(fontFamily: 'Gilroy', fontSize: 0.02 * _screenHeight),
          ),
        ),
      ],
    );
  }

  Widget done(BuildContext ctx, List<ExerciseDbModel> exercises, int index) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: 0.3 * _screenWidth,
      child: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Done",
              textScaleFactor: 0.8,
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 0.025 * _screenHeight,
                  color: Colors.black),
            ),
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          ],
        ),
        onPressed: () {
          String repVal = "0";
          String setVal = "0";
          String weightsVal = "0";
          repVal = Rep_CounterState.counter.toString();
          print("rep Val is " + repVal);
          setVal = Set_CounterState.counter.toString();
          weightsVal = weightsEditingController.text;
          print("repVal-->" + repVal);
          print("setVal-->" + setVal);
          print("weightsVal-->" + weightsVal);
          // Resetting variables
          Rep_CounterState.counter = 0;
          Set_CounterState.counter = 0;
          weightsEditingController = new TextEditingController();
          print("rep Val is " + repVal);
          if (repVal == "") {
            repVal = "0";
          }
          if (setVal == "") {
            setVal = "0";
          }
          if (weightsVal == "") {
            weightsVal = "0";
          }
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
            // print(index.toString() + " ---> val of i after popping");
            // print(setsAndReps.length.toString() + "--> len of sets and reps");
          }
        },
      ),
    );
  }

  Future addSetsRepsWeights(
      BuildContext context,
      List<ExerciseDbModel> exercises,
      int index,
      var _screenHeight,
      var _screenWidth) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        color: Colors.blueGrey[200],
        child: Container(
          margin: EdgeInsets.only(
            top: 0.0125 * _screenHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                exercises[index].exerciseName + " LOG",
                textScaleFactor: 0.8,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 0.04 * _screenHeight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Text(
                "Set Number",
                textScaleFactor: 0.8,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 0.025 * _screenHeight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(child: Container(child: addSet())),
              Text(
                "Reps",
                textScaleFactor: 0.8,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 0.025 * _screenHeight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(child: Container(child: addRep())),
              addWeights(_screenHeight, _screenWidth),
              SizedBox(
                height: 0.01 * _screenHeight,
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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final Map<String, dynamic> routeArgs =
        ModalRoute.of(context).settings.arguments as Map;
    List<ExerciseDbModel> exercises = routeArgs['exercises'];
    String planName = routeArgs['planName'];
    String planId = routeArgs['planId'];
    int planDay = routeArgs['planDay'];
    int pauser = 0;
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                child: Container(
                  // height: MediaQuery.of(context).size.height / 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        "DURATION",
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 0.018 * _screenHeight,
                        ),
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
                                fontSize: 0.05 * _screenHeight,
                                // color: Colors.white,
                                fontWeight: FontWeight.w700),
                          );
                        },
                      ),
                      resume_end_flag == 0
                          ? Container(
                              width: 0.3 * _screenWidth,
                              child: OutlinedButton(
                                onPressed: stopTimer,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Pause",
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.pause,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 0.3 * _screenWidth,
                                  child: OutlinedButton(
                                    onPressed: () => saveData(
                                        setsAndReps,
                                        planName,
                                        planDay,
                                        planId,
                                        _screenHeight,
                                        _screenWidth),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Finish",
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontSize: 0.025 * _screenHeight,
                                              color: Colors.black),
                                        ),
                                        Icon(
                                          Icons.stop,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.3 * _screenWidth,
                                  child: OutlinedButton(
                                    onPressed: startTimer,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Resume",
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontSize: 0.025 * _screenHeight,
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
                preferredSize: Size(_screenWidth, 0.13 * _screenHeight),
              ),
              centerTitle: true,
              backgroundColor: Colors.blueGrey[300],
              title: Text(
                planName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 0.04 * _screenHeight,
                    fontFamily: 'Gilroy'),
              ),
            ),
            body: PageView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 0.02 * _screenHeight,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                            separatorBuilder: (ctx, i) => SizedBox(
                                  height: 0.02 * _screenHeight,
                                ),
                            itemCount: exercises.length,
                            itemBuilder: (ctx, i) {
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
                                        topLeft: Radius.circular(
                                            0.02 * _screenHeight),
                                        topRight: Radius.circular(
                                            0.02 * _screenHeight),
                                      ),
                                      child: Image(
                                        image:
                                            NetworkImage(exercises[i].imageUrl),
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
                                          bottomRight: Radius.circular(
                                              0.02 * _screenHeight),
                                          bottomLeft: Radius.circular(
                                              0.02 * _screenHeight),
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
                                              exercises[i].exerciseName,
                                              style: TextStyle(
                                                  fontFamily: "Gilroy",
                                                  fontSize:
                                                      0.04 * _screenHeight,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 0.35 * _screenWidth,
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
                                                          fontSize: 0.025 *
                                                              _screenHeight,
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
                                                      ctx,
                                                      exercises,
                                                      i,
                                                      _screenHeight,
                                                      _screenWidth);
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
                  // color: Colors.grey[200],
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0.01 * _screenHeight,
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (ctx, j) => SizedBox(
                            height: 0.005 * _screenHeight,
                          ),
                          itemCount: setsAndReps.length,
                          itemBuilder: (ctx, j) {
                            // print("abcde");
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[200],
                                borderRadius:
                                    BorderRadius.circular(0.02 * _screenHeight),
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
                                    Row(
                                      children: [
                                        Text(
                                          setsAndReps[j].exerciseName,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 0.04 * _screenHeight,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete_forever),
                                          onPressed: () {
                                            removeLog(j);
                                          },
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Container(
                                      height: 0.05 * _screenHeight,
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
                                                        fontSize: 0.025 *
                                                            _screenHeight,
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
                                                        fontSize: 0.025 *
                                                            _screenHeight,
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
                                                  color: Colors.black),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Reps:",
                                                    style: TextStyle(
                                                        fontFamily: 'Gilroy',
                                                        fontSize: 0.025 *
                                                            _screenHeight,
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
                                                        fontSize: 0.025 *
                                                            _screenHeight,
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
                                                        fontSize: 0.025 *
                                                            _screenHeight,
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
                                                        fontSize: 0.025 *
                                                            _screenHeight,
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
        ),
      ),
    );
  }
}
