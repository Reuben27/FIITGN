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
            backgroundColor: Colors.green[200],
            centerTitle: true,
            title: Text(
              'SPORTS ACTIVITIES',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Gilroy'),
            ),
          ),
          body: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green[200],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Flexible(
                              child: Text(
                                activities[i].activities.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 300,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Flexible(
                              child: Text(
                                "with " +
                                    activities[i].instructors.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: 'Gilroy', fontSize: 20),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activities[i].schedule,
                                        style: TextStyle(
                                            fontFamily: 'Gilroy', fontSize: 20),
                                      ),
                                      Text(
                                        activities[i]
                                            .time_of_class
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontFamily: 'Gilroy', fontSize: 20),
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
                                                  fontFamily: 'Gilroy', fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                 ),
                               ),
                              ],
                            ),
                          ),

                          //
                        ],
                      ),
                      //add here
                    ),
                  ),
                );
              })),
    );
  }
}
