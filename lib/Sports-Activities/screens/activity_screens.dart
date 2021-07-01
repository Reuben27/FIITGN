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
                  fontSize: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).viewPadding.top) /
                      28,
                  fontFamily: 'Gilroy'),
            ),
          ),
          body: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (ctx, i) {
                return Container(
                  margin: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).viewPadding.top) /
                        84.5,
                    bottom: 0,
                    left: MediaQuery.of(context).size.width / 40,
                    right: MediaQuery.of(context).size.width / 40,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 51.425),
                    color: Colors.green[200],
                  ),
                  width: MediaQuery.of(context).size.width,
                  //  height: MediaQuery.of(context).size.height / 3.5,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).viewPadding.top) /
                          50,
                      bottom: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).viewPadding.top) /
                          50,
                      left: MediaQuery.of(context).size.width / 29,
                      right: MediaQuery.of(context).size.width / 29,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child:  Text(
                              activities[i].activities.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                 fontSize: MediaQuery.of(context).size.width / 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 300,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child:  Text(
                              "with " + activities[i].instructors.toUpperCase(),
                              style:
                                  TextStyle(fontFamily: 'Gilroy', fontSize: MediaQuery.of(context).size.width / 20),
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
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      activities[i].schedule,
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          fontFamily: 'Gilroy', fontSize: MediaQuery.of(context).size.width / 20),
                                    ),
                                    Text(
                                      activities[i].time_of_class.toUpperCase(),
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          fontFamily: 'Gilroy', fontSize: MediaQuery.of(context).size.width / 20),
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
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              fontSize: MediaQuery.of(context).size.width / 20),
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
                );
              })),
    );
  }
}
