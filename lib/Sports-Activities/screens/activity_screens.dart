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
    print(" in init ran");
    super.initState();
  }

  void inInIt() async {
    activities = await getActivityData();
    print("activities loaded");
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              child: Text(
                "SESSIONS CURRENTLY UNDERWAY",
                style: TextStyle(fontFamily: 'Gilroy'),
              ),
              preferredSize: Size.fromHeight(1),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'SPORTS ACTIVITIES',
              style: TextStyle(
                  color: Colors.black, fontSize: 30, fontFamily: 'Gilroy'),
            ),
          ),
          body: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 400,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(5),
                      //  // color: Colors.grey[200],
                      // ),
                      //  margin: EdgeInsets.all(20),

                      // elevation: 2,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(5),
                      // ),
                      child: Column(
                        children: [
                          Text(
                            activities[i].activities.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 400,
                          ),
                          Text(
                            "with " + activities[i].instructors.toUpperCase(),
                            style: TextStyle(fontFamily: 'Gilroy'),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 90,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 18,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // SizedBox(
                                    //   width: (3 / 8) *
                                    //       (MediaQuery.of(context).size.width),
                                    // ),
                                    Container(
                                      // height: 0.25 *
                                      //     MediaQuery.of(context).size.height /
                                      //     3,
                                      child: Center(
                                        child: Text(
                                          activities[i].schedule,
                                          style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              // fontSize: 0.15 *
                                              //     MediaQuery.of(context)
                                              //         .size
                                              //         .height /
                                              //     3,
                                              // color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          activities[i]
                                              .time_of_class
                                              .toUpperCase(),
                                          style: TextStyle(
                                              //      color: Colors.white,
                                              fontFamily: 'Gilroy'),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: (3 / 16) *
                                    //       (MediaQuery.of(context).size.width),
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 18,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // SizedBox(
                                    //   width: (3 / 8) *
                                    //       (MediaQuery.of(context).size.width),
                                    // ),
                                    Container(
                                      // height: 0.25 *
                                      //     MediaQuery.of(context).size.height /
                                      //     3,
                                      child: Center(
                                        child: Text(
                                          "at",
                                          style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            // fontSize: 0.15 *
                                            //     MediaQuery.of(context)
                                            //         .size
                                            //         .height /
                                            //     3,
                                            // color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          "TEMPORARY SPORTS FIELD",
                                          style: TextStyle(
                                              //      color: Colors.white,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: (3 / 16) *
                                    //       (MediaQuery.of(context).size.width),
                                    // ),
                                  ],
                                ),
                              ),

                              // SizedBox(
                              //   width: (3 / 8) *
                              //       (MediaQuery.of(context).size.width),
                              // ),
                              // Container(
                              //   width: MediaQuery.of(context).size.width / 2.2,
                              //   child: Column(
                              //     children: [
                              //       // SizedBox(
                              //       //   width: (3 / 8) *
                              //       //       (MediaQuery.of(context).size.width),
                              //       // ),
                              //       Container(
                              //         height: 0.25 *
                              //             MediaQuery.of(context).size.height /
                              //             3,
                              //         child: Center(
                              //           child: Text(
                              //             "at",
                              //             style: TextStyle(
                              //                 fontFamily: 'Gilroy',
                              //                 // fontSize: 0.15 *
                              //                 //     MediaQuery.of(context)
                              //                 //         .size
                              //                 //         .height /
                              //                 //     3,
                              //                 // color: Colors.white,
                              //                 fontWeight: FontWeight.w700),
                              //           ),
                              //         ),
                              //       ),
                              //       Container(
                              //         child: Center(
                              //           child: Text(
                              //             'TEMPORARY SPORTS FIELD',
                              //             style: TextStyle(
                              //                 //      color: Colors.white,
                              //                 fontFamily: 'Gilroy'),
                              //           ),
                              //         ),
                              //       ),
                              //       // SizedBox(
                              //       //   width: (3 / 16) *
                              //       //       (MediaQuery.of(context).size.width),
                              //       // ),
                              //     ],
                              //   ),
                              // ),

                              // SizedBox(
                              //   width: (3 / 16) *
                              //       (MediaQuery.of(context).size.width),
                              // ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Column(
                          //       children: [
                          //         Text(
                          //           activities[i].schedule,
                          //           style: TextStyle(fontFamily: 'Gilroy'),
                          //         ),
                          //         Text(
                          //           activities[i].time_of_class.toUpperCase(),
                          //           style: TextStyle(fontFamily: 'Gilroy'),
                          //         ),
                          //       ],
                          //     ),
                          //     Column(
                          //       children: [
                          //         Text(
                          //           "Venue",
                          //           style: TextStyle(fontFamily: 'Gilroy'),
                          //         ),
                          //         Text(
                          //           "Temporary Sports Field",
                          //           style: TextStyle(fontFamily: 'Gilroy'),
                          //         ),
                          //       ],
                          //     )
                          //   ],
                          // ),

                          // Text(activities[i].schedule),
                          // Text(activities[i].time_of_class),
                          //Text(activities[i].venue),
                          // Text(activities[i].online_offline),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                );
              })),
    );
  }
}
