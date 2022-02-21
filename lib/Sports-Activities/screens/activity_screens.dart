import 'package:flutter/material.dart';
import '../data/activity_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Activity_Screen extends StatefulWidget {
  static const routeName = '\ActivitiesScreen';
  @override
  _Activity_ScreenState createState() => _Activity_ScreenState();
}

class _Activity_ScreenState extends State<Activity_Screen> {
  List<ActivityData> activities = List<ActivityData>.empty();
  bool isLoading = true;
  var isInit = true;

  Future<void> launchSocialMedia(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print("error in opening zoom link");
      print(e);
    }
  }

  @override
  void didChangeDependencies() async {
    if (ActivityData.activites_static.length == 0) {
      await inInIt();
    } else {
      activities = ActivityData.activites_static;
      setState(() {
        isLoading = false;
      });
    }
    super.didChangeDependencies();
    isInit = false;
  }

  inInIt() async {
    activities = await getActivityData();
    print("activities loaded");
    setState(() {
      print(isLoading);
      print("is loading became false");
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Color(0xFF93B5C6),
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
          body: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        if (activities[i].link != 'Null') {
                          launchSocialMedia(activities[i].link);
                        }
                      },
                      child: Container(
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
                                child: Text(
                                  // "with " +
                                  activities[i].instructors.toUpperCase(),
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
                                                fontSize:
                                                    0.026 * _screenHeight),
                                          ),
                                          Text(
                                            activities[i]
                                                .time_of_class
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Gilroy',
                                                fontSize:
                                                    0.026 * _screenHeight),
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
                                                activities[i]
                                                    .venue
                                                    .toUpperCase(),
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
                        ),
                      ),
                    );
                  })),
    );
  }
}
