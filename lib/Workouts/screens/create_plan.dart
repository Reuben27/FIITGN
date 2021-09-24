import 'package:fiitgn/Providers/DataProvider.dart';
import 'package:fiitgn/Screens/HomeScreen.dart';
import 'package:fiitgn/Workouts/Widgets/create_passer.dart';
import 'package:fiitgn/Workouts/models/WorkoutModel.dart';
import 'package:fiitgn/Workouts/models/Workout_provider.dart';
import 'package:fiitgn/Workouts/screens/explore_workouts_plan_plan.dart';
import 'package:fiitgn/Workouts/screens/plan_plan_create_create_workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePlan extends StatefulWidget {
  static const routeName = 'createPlan';
  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  undoFunc(int dayNum, CreateArguments routeArgs) {
    String day = dayNum.toString();
    routeArgs.workoutsForDays.remove(day);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final CreateArguments routeArgs =
        ModalRoute.of(context).settings.arguments as CreateArguments;

    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    print(routeArgs);
    print("routeArgs.dayNumber is ");
    print(routeArgs.getDayNum());
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF93B5C6),
          child: Icon(Icons.save),
          onPressed: () async {
            List<List<WorkoutModel>> listOfPlans =
                CreateArguments.returnListWorkouts(routeArgs);
            List<String> listOfFollowersId = ['alpha'];
            List<String> listOfOngoingId = ['alpha'];
            String creatorId = Data_Provider().uid;
            String creatorName = Data_Provider().name;
            String planName = 'Temp1';
            String description = 'Description';
            String access = 'Private';
            await workoutDataProvider.createPlanAndAddToDB(
                creatorId,
                creatorName,
                planName,
                1,
                description,
                access,
                listOfPlans,
                listOfFollowersId,
                listOfOngoingId);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF93B5C6),
          title: Text(
            'CREATE PLAN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: Container(
          height: _screenHeight,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (ctx, j) => Container(
                      margin: EdgeInsets.only(
                        top: 0.00625 * _screenHeight,
                        bottom: 0.00625 * _screenHeight,
                        left: 0.03 * _screenWidth,
                        right: 0.03 * _screenWidth,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(0.02 * _screenHeight),
                        color: Color(0xFFC9CCD5),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 0.0125 * _screenHeight,
                          bottom: 0.0125 * _screenHeight,
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Day " + (j + 1).toString(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.03 * _screenHeight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: routeArgs.workoutsForDays
                                          .containsKey((j + 1).toString()) ==
                                      false // doesnt contain that data
                                  ? [
                                      OutlinedButton(
                                        onPressed: () {
                                          routeArgs.dayNum = j + 1;
                                          Navigator.pushReplacementNamed(
                                              context,
                                              Create_Workout_for_Plan.routeName,
                                              arguments: routeArgs);
                                        },
                                        child: Text(
                                          "CREATE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Colors.black),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          routeArgs.dayNum = j + 1;
                                          Navigator.pushReplacementNamed(
                                              context,
                                              Explore_Workouts_For_Plan
                                                  .routeName,
                                              arguments: routeArgs);
                                        },
                                        child: Text(
                                          "EXPLORE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Colors.black),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          routeArgs.dayNum = j + 1;
                                          routeArgs.workoutsForDays[
                                                  routeArgs.dayNum.toString()] =
                                              CreateArguments.rest_model;
                                          setState(() {});
                                        },
                                        child: Text(
                                          "REST DAY",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Colors.black),
                                        ),
                                      ),
                                    ]
                                  : [
                                      Text(
                                        'Selected',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gilroy',
                                            color: Colors.black),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          undoFunc(j + 1, routeArgs);
                                        },
                                        child: Text(
                                          "UNDO",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ],
                        ),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
