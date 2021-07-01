// import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
import 'package:date_format/date_format.dart';
// import 'package:fiitgn/Notifications/LocalNotifications.dart';
// import 'package:fiitgn/Notifications/utils/addNotification.dart';
// import 'package:fiitgn/Providers/DataProvider.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../models/Workout_provider.dart';
import '../models/WorkoutModel.dart';
import '../screens/exercises_in_workout.dart';
import '../models/Exercise_db_model.dart';
import '../models/expanded_panel_model.dart';

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
  var unFollowIcon = Icon(Icons.favorite_border);
  var followIcon = Icon(Icons.favorite);
  var ongoing_followIcon = Icon(Icons.add_box);
  var ongoing_unfollowIcon = Icon(Icons.add_box_outlined);
  var icon = Icon(Icons.add_box_outlined);
  List<dynamic> iconList = [];
  List<dynamic> ongoing_iconList = [];

  String dateTime;
  String _hourEntry, _minuteEntry, _timeEntry;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  List<Item_Model> workouts_expansion_list = List.empty(growable: true);

  // TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    List<WorkoutModel> workoutsList = workoutDataProvider.workoutList;
    workouts_expansion_list = Item_Model.get_list_item_model(workoutsList);
    //   _timeController.text = formatDate(
    //       DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
    //       [hh, ':', nn, " ", am]).toString();
  }

  showAlertDialog(BuildContext context, TimeOfDay selectedTime) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text(
          "Your Notification is set for ${selectedTime.hour} : ${selectedTime.minute}"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<Null> _selectTime(BuildContext context, WorkoutModel workout,
      String workoutId, int index) async {
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 00, minute: 00),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hourEntry = selectedTime.hour.toString();
        _minuteEntry = selectedTime.minute.toString();

        ongoing_iconList[index] = ongoing_followIcon;
        print("THETAAA");
      });
      await workoutDataProvider.addWorkoutToOngoingDB(
          workout, workoutId, selectedTime.hour, selectedTime.minute);
      print("workout added to ongoing");
    }
  }

  @override
  Widget build(BuildContext context) {
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    List<WorkoutModel> workoutsList = workoutDataProvider.workoutList;
    // final List<Item_Model> workouts_expansion_list =
    //     Item_Model.get_list_item_model(workoutsList);
    print("alpha");
    final String user_id = workoutDataProvider.userId;
    print("checking pos");
    workoutsList.forEach((element) {
      if (element.listOfFollowersId.contains(user_id)) {
        iconList.add(followIcon);
      } else {
        iconList.add(unFollowIcon);
      }
      if (element.listOfOnGoingId.contains(user_id)) {
        ongoing_iconList.add(ongoing_followIcon);
      } else {
        ongoing_iconList.add(ongoing_unfollowIcon);
      }
    });
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'All Workouts',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).viewPadding.top) /
                    28,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: workouts_expansion_list.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).viewPadding.top) /
                        70,
                    bottom: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).viewPadding.top) /
                        70),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.blueGrey[200],
                    width: MediaQuery.of(context).size.width / 205,
                  )),
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 29,
                      right: MediaQuery.of(context).size.width / 29),
                  child: ExpansionPanelList(
                    elevation: 0,
                    animationDuration: Duration(milliseconds: 500),
                    children: [
                      ExpansionPanel(
                        headerBuilder: (ctx, bool isExpanded) {
                          return Container(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).viewPadding.top) /
                                8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  workouts_expansion_list[i].workoutName,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      //   color: Colors.red,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              12,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  "by " +
                                      workouts_expansion_list[i].creator_name,
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize:
                                        MediaQuery.of(context).size.width / 25,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: (MediaQuery.of(context).size.height -
                                            MediaQuery.of(context)
                                                .viewPadding
                                                .top) /
                                        120,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40),
                                        child: InkWell(
                                          child: iconList[i],
                                          onTap: () async {
                                            //  function to follow/unfollow the workout
                                            print("test");
                                            if (workouts_expansion_list[i]
                                                .listOfFollowersId
                                                .contains(user_id)) {
                                              if (workoutsList[i].creatorId !=
                                                      user_id ||
                                                  true) {
                                                await workoutDataProvider
                                                    .unFollowWorkout(
                                                        workoutsList[i],
                                                        workoutsList[i]
                                                            .workoutId);
                                                print("http unfollow done");
                                                setState(() {
                                                  iconList[i] = unFollowIcon;
                                                  print("state set");
                                                });
                                              }
                                              // } else {
                                              //   // cant unfollow your own workout
                                              //   print("cant unfollow your own workout");
                                              //   //
                                              //   // TODO Add a snackbar thats tells user they cant unfollow workouts they have created
                                              // }
                                            } else if (!workoutsList[i]
                                                .listOfFollowersId
                                                .contains(user_id)) {
                                              await workoutDataProvider
                                                  .followWorkout(
                                                      workoutsList[i],
                                                      workoutsList[i]
                                                          .workoutId);
                                              print("http follow done");
                                              setState(() {
                                                iconList[i] = followIcon;
                                                print("state set");
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                40),
                                        child: InkWell(
                                          child: ongoing_iconList[i],
                                          // onTap: () {},
                                          onTap: () async {
                                            //  function to follow/unfollow the workout
                                            print("test");
                                            if (workoutsList[i]
                                                .listOfOnGoingId
                                                .contains(user_id)) {
                                              await workoutDataProvider
                                                  .removeWorkoutFromOngoingDB(
                                                      workoutsList[i],
                                                      workoutsList[i]
                                                          .workoutId);
                                              print(
                                                  "http removed from ongoing done");
                                              setState(() {
                                                ongoing_iconList[i] =
                                                    ongoing_unfollowIcon;
                                                print("state set");
                                              });
                                            } else if (!workoutsList[i]
                                                .listOfOnGoingId
                                                .contains(user_id)) {
                                              print("QQQQQQQQQQQQQQQQQQQQQ");
                                              await _selectTime(
                                                  context,
                                                  workoutsList[i],
                                                  workoutsList[i].workoutId,
                                                  i);
                                              print(_hourEntry);
                                              print(_minuteEntry);
                                              print("ZUMBAAAA");
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Text("Creator Id - " + workoutsList[i].creatorId),
                          );
                        },
                        isExpanded: workouts_expansion_list[i].expanded,
                        body: Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 29,
                            bottom: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).viewPadding.top) /
                                120,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    workouts_expansion_list[i].description,
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              22,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                workouts_expansion_list[i]
                                    .listOfExercisesId
                                    .toString(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize:
                                      MediaQuery.of(context).size.width / 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    expansionCallback: (int item, bool isExpanded) {
                      setState(() {
                        print(workouts_expansion_list[i].expanded);
                        workouts_expansion_list[i].expanded =
                            !workouts_expansion_list[i].expanded;
                        // print(workouts_expansion_list[i].expanded);
                        print(workouts_expansion_list[i].expanded);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
