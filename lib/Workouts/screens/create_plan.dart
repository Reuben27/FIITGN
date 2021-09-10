import 'package:fiitgn/Providers/DataProvider.dart';
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
          backgroundColor: Colors.red[400],
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
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'CREATE PLAN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: PageView.builder(
          itemCount: 1,
          itemBuilder: (ctx, i) => Container(
            height: _screenHeight,
            child: Column(children: [
              Container(child: Text("Week " + (i + 1).toString())),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (ctx, j) => Container(
                          child: Row(
                            children: routeArgs.workoutsForDays
                                        .containsKey((j + 1).toString()) ==
                                    false // doesnt contain that data
                                ? [
                                    Text("Day " + (j + 1).toString()),
                                    InkWell(
                                      onTap: () {
                                        routeArgs.dayNum = j + 1;
                                        Navigator.pushReplacementNamed(context,
                                            Create_Workout_for_Plan.routeName,
                                            arguments: routeArgs);
                                      }, ////send to create workout and then bring back
                                      child: Text("Create"),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        routeArgs.dayNum = j + 1;
                                        Navigator.pushReplacementNamed(context,
                                            Explore_Workouts_For_Plan.routeName,
                                            arguments: routeArgs);
                                      }, ////send to explore workout to choose and get back
                                      child: Text("Explore"),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        routeArgs.dayNum = j + 1;
                                        routeArgs.workoutsForDays[
                                                routeArgs.dayNum.toString()] =
                                            CreateArguments.rest_model;
                                        setState(() {});
                                      },
                                      child: Text("Rest"),
                                    ),
                                  ]
                                : [
                                    Text("Day " + (j + 1).toString()),
                                    Text('Selected'),
                                    RaisedButton(
                                      onPressed: () {
                                        undoFunc(j + 1, routeArgs);
                                      },
                                      child: Text('Undo'),
                                    )
                                  ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
