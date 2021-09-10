import 'package:fiitgn/Workouts/Widgets/create_passer.dart';
import 'package:fiitgn/Workouts/models/WorkoutModel.dart';
import 'package:fiitgn/Workouts/screens/explore_plans.dart';
import 'package:fiitgn/Workouts/screens/plans_created_by_user.dart';
import 'package:fiitgn/Workouts/screens/plans_following_now.dart';

import './create_workouts1.dart';
import './wishlist.dart';
import 'package:flutter/material.dart';
import './explore_workouts.dart';
import './created_by_user.dart';
import 'create_plan.dart';
import 'ongoing_workouts.dart';
import './workouts_history.dart';

class Workouts_Plans extends StatelessWidget {
  static const routeName = '\Workouts-Plans';
  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 0.8),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(_screenWidth, 0.155 * _screenHeight),
            child: Container(
              margin: EdgeInsets.only(bottom: 0.010 * _screenHeight),
              child: Column(
                children: [
                  Container(
                    height: 0.1 * _screenHeight,

                    //   borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/4805.png',
                      //  height: MediaQuery.of(context).size.height / 4.87,
                      // width: MediaQuery.of(context).size.width / 2.28,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    height: 0.045 * _screenHeight,
                    width: 0.4 * _screenWidth,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFF).withOpacity(0.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(0.05 * _screenHeight),
                      ),
                    ),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          Text('Explore',
                              style: TextStyle(
                                fontSize: 0.035 * _screenHeight,
                                fontFamily: "Gilroy",
                              ))
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Explore_Plans.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'WORKOUT PLANS',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: 0.025 * _screenHeight,
                  bottom: 0.025 * _screenHeight,
                ),
                // height: MediaQuery.of(context).size.height / 6,
                child: Column(
                  children: [
                    Text(
                      'Your Plans',
                      style: TextStyle(
                        fontSize: 0.04 * _screenHeight,
                        fontFamily: "Gilroy",
                      ),
                    ),
                    SizedBox(
                      height: 0.0125 * _screenHeight,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Following_now_Plans.routeName);
                            },
                            child: Container(
                              width: 0.4 * _screenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(
                                      0.025 * _screenHeight)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: (0.02 * _screenHeight),
                                  bottom: (0.02 * _screenHeight),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/clok.png',
                                        fit: BoxFit.contain,
                                      ),
                                      width: 0.125 * _screenWidth,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.018 * _screenHeight),
                                      child: Text(
                                        "FOLLOWING PLANS",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 0.022 * _screenHeight,
                                          fontFamily: "Gilroy",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Plans_createdByUser.routeName);
                            },
                            child: Container(
                              width: 0.4 * _screenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(
                                      0.025 * _screenHeight)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: (0.02 * _screenHeight),
                                  bottom: (0.02 * _screenHeight),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/idea.png',
                                        fit: BoxFit.contain,
                                      ),
                                      width: 0.125 * _screenWidth,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.018 * _screenHeight),
                                      child: Text(
                                        "CREATED BY YOU",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 0.022 * _screenHeight,
                                          fontFamily: "Gilroy",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.0125 * _screenHeight,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Wishlist.routeName);
                            },
                            child: Container(
                              width: 0.4 * _screenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(
                                      0.025 * _screenHeight)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: (0.02 * _screenHeight),
                                  bottom: (0.02 * _screenHeight),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/wiss.png',
                                        fit: BoxFit.contain,
                                      ),
                                      width: 0.16 * _screenWidth,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Text(
                                        "WISHLIST",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 0.022 * _screenHeight,
                                          fontFamily: "Gilroy",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, WorkoutHistoryScreen.routeName);
                            },
                            child: Container(
                              width: 0.4 * _screenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(
                                      0.025 * _screenHeight)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: (0.02 * _screenHeight),
                                  bottom: (0.02 * _screenHeight),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/hiss.png',
                                        fit: BoxFit.contain,
                                      ),
                                      width: 0.16 * _screenWidth,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Text(
                                        "HISTORY",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 0.022 * _screenHeight,
                                          fontFamily: "Gilroy",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Map<String, WorkoutModel> workoutsForDays =
                    Map<String, WorkoutModel>();
                workoutsForDays['-1'] = CreateArguments.rest_model;
                CreateArguments arguments = CreateArguments(
                    dayNum: -1, workoutsForDays: workoutsForDays);
                print("passed the workoutForDays to Create plan from home");
                Navigator.pushNamed(context, CreatePlan.routeName,
                    arguments: arguments);
              },
              child: Container(
                width: _screenWidth,
                margin: EdgeInsets.only(
                    left: 0.0245 * _screenWidth, right: 0.0245 * _screenWidth),
                //  height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.025 * _screenHeight),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 0.0245 * _screenWidth,
                    right: 0.0245 * _screenWidth,
                    top: (0.02 * _screenHeight),
                    bottom: (0.02 * _screenHeight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Create Plan',
                          style: TextStyle(
                            fontSize: 0.04 * _screenHeight,
                            fontFamily: "Gilroy",
                          ),
                        ),
                      ),
                      Container(
                        width: 0.25 * _screenWidth,
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/23.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0.025 * _screenHeight,
                bottom: 0.025 * _screenHeight,
              ),
              child: Column(
                children: [
                  Text(
                    'Workouts',
                    style: TextStyle(
                      fontSize: 0.04 * _screenHeight,
                      fontFamily: "Gilroy",
                    ),
                  ),
                  SizedBox(
                    height: 0.0125 * _screenHeight,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 0.1 * _screenHeight,

                        //   borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'assets/4805.png',
                          //  height: MediaQuery.of(context).size.height / 4.87,
                          // width: MediaQuery.of(context).size.width / 2.28,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        height: 0.045 * _screenHeight,
                        width: 0.4 * _screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.05 * _screenHeight),
                          ),
                        ),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search),
                              Text('Explore',
                                  style: TextStyle(
                                    fontSize: 0.035 * _screenHeight,
                                    fontFamily: "Gilroy",
                                  ))
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, Explore_Workouts.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.0125 * _screenHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.03 * _screenWidth, right: 0.03 * _screenWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Wishlist.routeName);
                          },
                          child: Container(
                            width: 0.4 * _screenWidth,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(
                                    0.025 * _screenHeight)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: (0.02 * _screenHeight),
                                bottom: (0.02 * _screenHeight),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/wiss.png',
                                      fit: BoxFit.contain,
                                    ),
                                    width: 0.16 * _screenWidth,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Text(
                                      "WISHLIST",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 0.022 * _screenHeight,
                                        fontFamily: "Gilroy",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Created_by_user.routeName);
                          },
                          child: Container(
                            width: 0.4 * _screenWidth,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(
                                    0.025 * _screenHeight)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: (0.02 * _screenHeight),
                                bottom: (0.02 * _screenHeight),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      'assets/idea.png',
                                      fit: BoxFit.contain,
                                    ),
                                    width: 0.125 * _screenWidth,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.018 * _screenHeight),
                                    child: Text(
                                      "CREATED BY YOU",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 0.022 * _screenHeight,
                                        fontFamily: "Gilroy",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Create_Workout2.routeName);
              },
              child: Container(
                width: _screenWidth,
                margin: EdgeInsets.only(
                    left: 0.0245 * _screenWidth, right: 0.0245 * _screenWidth),
                //  height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.025 * _screenHeight),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 0.0245 * _screenWidth,
                    right: 0.0245 * _screenWidth,
                    top: (0.02 * _screenHeight),
                    bottom: (0.02 * _screenHeight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Create Workout',
                          style: TextStyle(
                            fontSize: 0.04 * _screenHeight,
                            fontFamily: "Gilroy",
                          ),
                        ),
                      ),
                      Container(
                        width: 0.25 * _screenWidth,
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/23.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
