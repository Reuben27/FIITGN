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
  var isInit = true;
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
  // TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //   _timeController.text = formatDate(
    //       DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
    //       [hh, ':', nn, " ", am]).toString();
  }

  // @override
  // void didChangeDependencies() async {
  //   await Provider.of<Workouts_Provider>(context).showAllWorkouts();
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    final exercise_provier =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);
    final List<WorkoutModel> workoutsList = workoutDataProvider.workoutList;
    final List<ItemModel> workouts_expansion_list =
        ItemModel.get_list_item_model(workoutsList);
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[300],
        title: Text(
          'All Workouts',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'Gilroy'),
        ),
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
                  Row(
                    children: [
                      InkWell(
                        child: iconList[i],
                        onTap: () async {
                          //  function to follow/unfollow the workout
                          print("test");
                          if (workoutsList[i]
                              .listOfFollowersId
                              .contains(user_id)) {
                            if (workoutsList[i].creatorId != user_id || true) {
                              await workoutDataProvider.unFollowWorkout(
                                  workoutsList[i], workoutsList[i].workoutId);
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
                            await workoutDataProvider.followWorkout(
                                workoutsList[i], workoutsList[i].workoutId);
                            print("http follow done");
                            setState(() {
                              iconList[i] = followIcon;
                              print("state set");
                            });
                          }
                        },
                      ),
                      InkWell(
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
                                    workoutsList[i], workoutsList[i].workoutId);
                            print("http removed from ongoing done");
                            setState(() {
                              ongoing_iconList[i] = ongoing_unfollowIcon;
                              print("state set");
                            });
                          } else if (!workoutsList[i]
                              .listOfOnGoingId
                              .contains(user_id)) {
                            print("QQQQQQQQQQQQQQQQQQQQQ");
                            await _selectTime(context, workoutsList[i],
                                workoutsList[i].workoutId, i);
                            print(_hourEntry);
                            print(_minuteEntry);
                            print("ZUMBAAAA");
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// FlutterLocalNotificationsPlugin notificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// class NotificationsTimer extends StatefulWidget {
//   static const routeName = '\Notifications';
//   WorkoutModel workout;
//   String workoutId;

//   NotificationsTimer({
//     @required this.workout,
//     @required this.workoutId,
//   });

//   @override
//   NotificationsTimerState createState() =>
//       NotificationsTimerState(workout: workout, workoutId: workoutId);
// }

// class NotificationsTimerState extends State<NotificationsTimer> {
//   WorkoutModel workout;
//   String workoutId;

//   NotificationsTimerState({
//     @required this.workout,
//     @required this.workoutId,
//   });

//   String dateTime;
//   String _hourEntry, _minuteEntry, _timeEntry;
//   TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
//   // TextEditingController _timeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     LocalNotificationService.initializeSetting(context);
//     _timeController.text = formatDate(
//         DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
//         [hh, ':', nn, " ", am]).toString();

//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message.data != null) {
//         final routeName = message.data["route"];
//         print(routeName);
//         // Navigator.of(context).pushNamed(routeName);
//       }
//     });

//     //When Open.
//     FirebaseMessaging.onMessage.listen((message) {
//       if (message.notification != null) {
//         print(message.notification.title);
//         print(message.notification.body);
//       }
//       LocalNotificationService.display(message);
//     });

//     //When in bg but not killed
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       final routeName = message.data["route"];
//       print(routeName);
//       // Navigator.of(context).pushNamed(routeName);
//     });
//   }

//   Future<Null> _selectTime(BuildContext context) async {
//     final TimeOfDay picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (picked != null)
//       setState(() {
//         selectedTime = picked;
//         _hourEntry = selectedTime.hour.toString();
//         _minuteEntry = selectedTime.minute.toString();
//         _timeEntry = _hourEntry + ' : ' + _minuteEntry;
//         _timeController.text = _timeEntry;
//         _timeController.text = formatDate(
//             DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
//             [hh, ':', nn, " ", am]).toString();
//       });
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     _timeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final workoutDataProvider =
//         Provider.of<Workouts_Provider>(context, listen: false);
//     return Column(
//       children: <Widget>[
//         Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(16.0),
//           child: Text(
//             '',
//             textAlign: TextAlign.center,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.blue[500],
//               fontSize: 20,
//             ),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Text(
//                 'Choose Time',
//                 style: TextStyle(
//                     fontStyle: FontStyle.italic,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.5),
//               ),
//               InkWell(
//                 onTap: () {
//                   _selectTime(context).then((_) async {
//                     print("entered select time THEN block");
//                     String token = Data_Provider().notif_token;
//                     int hour = selectedTime.hour;
//                     int minute = selectedTime.minute;
//                     await workoutDataProvider.addWorkoutToOngoingDB(
//                         workout, workoutId, hour, minute);
//                     print("Workout added to ongoing");
//                     notiAdd(token, hour, minute, workout.workoutName);
//                     print("Notif added");
//                     showAlertDialog(context, selectedTime);
//                   });
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 2,
//                   height: MediaQuery.of(context).size.width / 10,
//                   margin: EdgeInsets.only(top: 10),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(color: Colors.grey[200]),
//                   child: TextFormField(
//                     style: TextStyle(fontSize: 25),
//                     textAlign: TextAlign.center,
//                     enabled: false,
//                     keyboardType: TextInputType.text,
//                     controller: _timeController,
//                     decoration: InputDecoration(
//                         disabledBorder:
//                             UnderlineInputBorder(borderSide: BorderSide.none),
//                         // labelText: 'Time',
//                         contentPadding: EdgeInsets.all(5)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//     ;
//   }

//   showAlertDialog(BuildContext context, TimeOfDay selectedTime) {
//     // set up the button
//     Widget okButton = FlatButton(
//       child: Text("OK"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("Notice"),
//       content: Text(
//           "Your Notification is set for ${selectedTime.hour} : ${selectedTime.minute}"),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
