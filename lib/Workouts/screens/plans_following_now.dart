// import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
import 'package:date_format/date_format.dart';
import 'package:fiitgn/Workouts/models/Plan_Model.dart';
import 'package:fiitgn/Workouts/screens/weekly_plan_display.dart';
// import 'package:fiitgn/Notifications/LocalNotifications.dart';
// import 'package:fiitgn/Notifications/utils/addNotification.dart';
// import 'package:fiitgn/Providers/DataProvider.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Workout_provider.dart';
import '../models/WorkoutModel.dart';
import '../screens/exercises_in_workout.dart';
import '../models/Exercise_db_model.dart';
import '../models/expanded_panel_model.dart';

class Following_now_Plans extends StatefulWidget {
  static const routeName = '\Following_nowPlans';

  @override
  _Following_now_PlansState createState() => _Following_now_PlansState();
}

class _Following_now_PlansState extends State<Following_now_Plans> {
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
  List<PlanModel> plansList = List.empty(growable: true);
  bool isLoading = true;

  // TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    in_init();
  }

  in_init() async {
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    await workoutDataProvider.showAllPlans();
    plansList = workoutDataProvider.ongoingPlans();
    print(plansList);
    setState(() {
      isLoading = false;
    });
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

  Future<Null> _selectTime(
      BuildContext context, PlanModel plan, String planId, int index) async {
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
      await workoutDataProvider.addPlanToOngoingDB(
          plan, planId, selectedTime.hour, selectedTime.minute);
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
    List<PlanModel> plansList = workoutDataProvider.plansList;
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);

    // final List<Item_Model> workouts_expansion_list =
    //     Item_Model.get_list_item_model(workoutsList);
    print("alpha");
    final String user_id = workoutDataProvider.userId;
    print("checking pos");
    plansList.forEach((element) {
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
          bottom: PreferredSize(
            preferredSize: Size(_screenWidth, 0.1 * _screenHeight),
            child: Container(
              margin: EdgeInsets.only(bottom: 0.010 * _screenHeight),

              // in the text below, add the last plan/workout that has been logged.


              child: Text(
                "Last Session: Insert Plan Name, Day Number, Workout Name",
                style: TextStyle(
                  fontSize: 0.03 * _screenHeight,
                  fontFamily: "Gilroy",
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'FOLLOWING PLANS',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: isLoading == false && plansList.length == 0
            ? Center(
                child: Text('No plans to explore right now come back later'),
              )
            : isLoading == true
                ?
                // a loading spinner should come rotating
                Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : isLoading == false && plansList.length > 0
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: plansList.length,
                          itemBuilder: (ctx, i) {
                            return InkWell(
                              onTap: () {
                                ///////////
                                Navigator.pushReplacementNamed(
                                    context, WeeklyPlanDisplay.routeName,
                                    arguments: plansList[i]);
                              },
                              child: Padding(
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
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 0.00625 * _screenHeight,
                                      bottom: 0.00625 * _screenHeight,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          plansList[i].planName,
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              //   color: Colors.red,
                                              fontSize: 0.045 * _screenHeight,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          "by " + plansList[i].creator_name,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 0.025 * _screenHeight,
                                          ),
                                        ),

                                        //display number of weeks a plan has in the below text widget


                                        
                                        Text(
                                          "Weeks: xxx",
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 0.025 * _screenHeight,
                                          ),
                                        ),


                                        // in the inkwell below add the function for removing a plan from following


                                        InkWell(
                                          child: Text("Remove"),
                                          onTap: () {},
                                        )
                                      ],
                                    ),
                                    // Text("Creator Id - " + workoutsList[i].creatorId),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : null,
      ),
    );
  }
}
