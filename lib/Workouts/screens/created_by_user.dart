import 'package:flutter/material.dart';
import '../models/Workout_provider.dart';
import 'package:provider/provider.dart';
import '../models/WorkoutModel.dart';
import '../models/expanded_panel_model.dart';

class Created_by_user extends StatefulWidget {
  static const routeName = '\workouts_created_by_user';

  @override
  _Created_by_userState createState() => _Created_by_userState();
}

class _Created_by_userState extends State<Created_by_user> {
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

  @override
  void initState() {
    super.initState();
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    final List<WorkoutModel> user_created_workouts =
        workoutDataProvider.created_by_user();
    workouts_expansion_list =
        Item_Model.get_list_item_model(user_created_workouts);
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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[300],
        title: Text(
          'CREATED BY YOU',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 0.04 * _screenHeight,
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
                top: 0.0125 * _screenHeight,
                bottom: 0.0125 * _screenHeight,
              ),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.blueGrey[200],
                  width: 0.005 * _screenWidth,
                )),
                margin: EdgeInsets.only(
                  left: 0.03 * _screenWidth,
                  right: 0.03 * _screenWidth,
                ),
                child: ExpansionPanelList(
                  elevation: 0,
                  animationDuration: Duration(milliseconds: 500),
                  children: [
                    ExpansionPanel(
                      headerBuilder: (ctx, bool isExpanded) {
                        return Container(
                           margin: EdgeInsets.only(
                            top: 0.00625 * _screenHeight,
                            bottom: 0.00625 * _screenHeight,
                          ),
                          // height: (MediaQuery.of(context).size.height -
                          //         MediaQuery.of(context).viewPadding.top) /
                          //     8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                workouts_expansion_list[i].workoutName,
                                style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    //   color: Colors.red,
                                    fontSize: 0.045 * _screenHeight,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                "by " + workouts_expansion_list[i].creator_name,
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                   fontSize: 0.025 * _screenHeight,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0.00625 * _screenHeight,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                           left: 0.025 * _screenWidth,
                                        right: 0.025 * _screenWidth,),
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
                                                .followWorkout(workoutsList[i],
                                                    workoutsList[i].workoutId);
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
                                           left: 0.025 * _screenWidth,
                                        right: 0.025 * _screenWidth,),
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
                                                    workoutsList[i].workoutId);
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
                         left: 0.025 * _screenWidth,
                          bottom: 0.0125 * _screenHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    workouts_expansion_list[i].description,
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                     fontSize: 0.022 * _screenHeight,
                                     fontWeight: FontWeight.bold
                                    ),
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
                                fontSize: 0.022 * _screenHeight,
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
    );
  }
}
