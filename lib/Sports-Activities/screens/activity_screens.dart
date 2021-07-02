import 'package:fiitgn/Widgets/stickynote.dart';
import 'package:flutter/material.dart';
import '../data/activity_data.dart';

class Activity_Screen extends StatefulWidget {
  static const routeName = '\ActivitiesScreen';
  @override
  _Activity_ScreenState createState() => _Activity_ScreenState();
}

class _Activity_ScreenState extends State<Activity_Screen> {
  List<ActivityData> activities = List<ActivityData>.empty();

  @override
  void initState() {
    // TODO: implement initState
    inInIt();
    setState(() {});
    print(" in init ran");
    super.initState();
  }

  void inInIt() async {
    activities = activities_data;
    print("activities loaded");
    setState(() {});
  }

  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green[200],
              centerTitle: true,
              title: Text(
                'SPORTS ACTIVITIES',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 0.04 * _screenHeight,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
            body: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (ctx, i) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: 0.00625 * _screenHeight,
                      bottom: 0.00625 * _screenHeight,
                      left: 0.03 * _screenWidth,
                      right: 0.03 * _screenWidth,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                      color: Colors.green[200],
                    ),
                    width: MediaQuery.of(context).size.width,
                    //  height: MediaQuery.of(context).size.height / 3.5,
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
                            //width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              activities[i].activities.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.06 * _screenHeight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.004 * _screenHeight,
                          ),
                          Container(
                            //  width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              "with " + activities[i].instructors.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.026 * _screenHeight),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Container(
                            height: 0.09 * _screenHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 0.4 * _screenWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activities[i].schedule,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gilroy',
                                            fontSize: 0.026 * _screenHeight),
                                      ),
                                      Text(
                                        activities[i]
                                            .time_of_class
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gilroy',
                                            fontSize: 0.026 * _screenHeight),
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            activities[i].venue.toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Gilroy',
                                                fontSize:
                                                    0.026 * _screenHeight),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //add here
                    ),
                  );
                })),
      
    );
  }
}
