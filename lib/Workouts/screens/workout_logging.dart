import 'package:flutter/material.dart';
import '../models/Exercise_db_model.dart';
import '../models/Workouts_Log_Model.dart';
import 'package:intl/intl.dart';
import '../../Screens/HomeScreen.dart';
import '../../Providers/DataProvider.dart';
import '../models/Workout_Data_Log_Model.dart';

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
  TextEditingController repEditingController = TextEditingController();
  TextEditingController setEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    repEditingController.dispose();
    setEditingController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
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
                Navigator.of(_).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void addNewSet(String exerciseId, int setVal, int repVal) {
    final Workout_Log_Model newData = Workout_Log_Model(
      exerciseId: exerciseId,
      numOfReps: repVal,
      setNumber: setVal,
    );

    setsAndReps.add(newData);
    // testing
    print(newData.setNumber);
    print("Value aded " + setsAndReps[setsAndReps.length - 1].exerciseId);
  }

  void saveData(String uid, String date, List<Workout_Log_Model> exercices,
      String workoutName) {
    print("save data initiated");
    print("User UID is " + uid);
    Workout_Data_Model data = Workout_Data_Model(
        databaseId: "",
        uid: uid,
        date: date,
        listOfSetsReps: exercices,
        user_name: Data_Provider().name,
        workoutName: workoutName);
    // ignore: deprecated_member_use
    setsAndReps = List<Workout_Log_Model>();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Do you want to save and End?"),
        actions: [
          FloatingActionButton(
            child: Text("Yes"),
            onPressed: () {
              //////////////////
              //
              ////////////
              //
              //
              //
              //
              //
              // ADD FUNCTION TO STORE DATA ON DB
              // workoutDataProvider.saveToYourWorkouts(data);
              Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);
            },
          ),
          FloatingActionButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // the list of exercises in the workout clicked to be done
    final Map<String, dynamic> routeArgs =
        ModalRoute.of(context).settings.arguments as Map;
    List<ExerciseDbModel> exercises = routeArgs['exercises'];
    String workoutName = routeArgs['workoutName'];
    String uid = Data_Provider().uid;
    // String uid = workoutDataProvider.getUid;

    final DateTime date = DateTime.now();
    final String dateIso = date.toIso8601String();
    // final String day = DateFormat.EEEE().format(date);

    // MOVE THIS FUNCTION outside the build method when saving is enabled again WITHOUT FAIL

    return Scaffold(
        body: WillPopScope(
      onWillPop: _onBackPressed,

      /// adding code that handles back button pressing
      child: PageView(
        children: [
          ListView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: exercises.length,
                      itemBuilder: (ctx, index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                          ),
                          ClipRRect(
                            child: exercises[index].imageUrl == null
                                ? Text('No Image yet')
                                : Image.asset(
                                    exercises[index].imageUrl,
                                    height: 300,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  exercises[index].exerciseName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 30),
                                ),
                                // ignore: deprecated_member_use
                                RaisedButton.icon(
                                  icon: Icon(Icons.add),
                                  label: Text('Add Log'),
                                  onPressed: () {
                                    // print("i= " + index.toString());
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text('Add Reps'),
                                        actions: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text("Add Set Number:  "),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            setEditingController,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Add Rep Count:  "),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            repEditingController,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                  child: Text("Done"),
                                                  onPressed: () {
                                                    String repVal = "";
                                                    String setVal = "";
                                                    repVal =
                                                        repEditingController
                                                            .text;
                                                    setVal =
                                                        setEditingController
                                                            .text;
                                                    // print(index
                                                    // .toString() +
                                                    // " this is the value of i ");
                                                    if (repVal == "" ||
                                                        setVal == "") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'No field should be empty.'),
                                                            actions: [
                                                              // ignore: deprecated_member_use
                                                              FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'OK'))
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      String currentExerciseId =
                                                          exercises[index]
                                                              .exerciseId;
                                                      print(currentExerciseId +
                                                          " is the id");
                                                      // print("same exercise");
                                                      addNewSet(
                                                        currentExerciseId,
                                                        int.parse(setVal),
                                                        int.parse(repVal),
                                                      );
                                                      repEditingController =
                                                          TextEditingController();
                                                      setEditingController =
                                                          TextEditingController();
                                                      // print("different exercise");
                                                      Navigator.of(ctx)
                                                          .pop(true);

                                                      setsAndReps.forEach(
                                                        (element) {
                                                          if (element
                                                                  .exerciseId ==
                                                              currentExerciseId) {
                                                            workoutList
                                                                .add(element);
                                                            print(workoutList[
                                                                workoutList
                                                                        .length -
                                                                    1]);
                                                            setState(() {});
                                                          }
                                                        },
                                                      );
                                                      // testing
                                                      print(index.toString() +
                                                          " val of i after popping");
                                                      print(setsAndReps.length
                                                              .toString() +
                                                          " len");
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                              fontSize: MediaQuery.of(context).size.width / 10,
                              fontWeight: FontWeight.bold),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            saveData(uid, dateIso, setsAndReps, workoutName);
                          },
                          child: Icon(Icons.save),
                        ),
                      ]),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: setsAndReps.length,
                    itemBuilder: (ctx, t) {
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
                                  width: MediaQuery.of(context).size.width / 4,
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  image: AssetImage(
                                    exercises
                                        .firstWhere((element) =>
                                            element.exerciseId ==
                                            setsAndReps[t].exerciseId)
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
                                    setsAndReps[t].exerciseId,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Set - " +
                                              setsAndReps[t]
                                                  .setNumber
                                                  .toString(),
                                          style: TextStyle(fontSize: 18)),
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
                                            setsAndReps[t].numOfReps.toString(),
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
    ));
  }
}
