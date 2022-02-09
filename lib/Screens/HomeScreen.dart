import 'package:fiitgn/Cardio/screens/YourRunsStatsScreen.dart';
import 'package:fiitgn/Important-Contacts/important-contacts.dart';
import 'package:fiitgn/QuickLinks/QuickLinks.dart';
import 'package:fiitgn/Screens/developers_page.dart';
import 'package:fiitgn/Workouts/screens/workout_plans_home.dart';
import 'package:googleapis/chat/v1.dart';
import 'package:flutter/src/widgets/image.dart' as img;

import '../Allocation/screens/sports.dart';
import '../Providers/DataProvider.dart';
import '../Cardio/screens/RunScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Cardio/screens/CycleScreen.dart';
import '../Widgets/HomeScreenItem.dart';
import 'package:flutter/services.dart';
import '../Screens/StatsScreen.dart';
import '../Cardio/providers/CycleDataProvider.dart';
import '../Cardio/providers/RunDataProvider.dart';
import 'package:provider/provider.dart';
import 'GAuth.dart';
import '../Calendar-Schedule/schedueCalendar.dart';
import '../Calendar-Schedule/calendar_try_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:image/image.dart' as Image;

//// WORKOUTS
import '../Workouts/screens/workouts-home.dart';
import '../Workouts/models/Admin_db_model.dart';
import '../Workouts/models/Exercise_db_model.dart';
import '../Workouts/models/Workout_provider.dart';

//// NUTRITION
import '../Nutrition/screens/nutritionScreen.dart';

//// ACTIVITIES
import '../Sports-Activities/screens/activity_screens.dart';

//// ADMIN
import 'package:fiitgn/Admin/screens/admin_home.dart';

//// Temp Expansion Panel
import './expansion_list.dart';
import '../Screens/stopwatch.dart';

//// PROFILE
import '../Profile/screens/profile_page.dart';

import '../QuickLinks/QuickLinks.dart';

class HomeScreen extends StatefulWidget {
  @override
  static const routeName = '\HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  insideInIt() async {
    final data_provider = Provider.of<Data_Provider>(context, listen: false);
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    print("Home Screen Inside init has succesfully run");
    // TO IMPROVISE SECURITY TOKEN WILL BE SET LATER
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((e) async {
      await insideInIt();
    });
  }

  final List<IconData> rowOfItem = [
    FontAwesomeIcons.signOutAlt,
    FontAwesomeIcons.user,
  ];

  Future<bool> _onBackPressed(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (_) {
          return AlertDialog(
            title: Text('Exit App?'),
            actions: [
              FlatButton(
                onPressed: () {
                  // Navigator.of(ctx).pop(true);
                  print('Exiting App');
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }

  final List homeScreenList = [
    {
      'title': 'Cardio',
      'url': 'assets/act.png',
      'routeName': MapScreen.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
    },
    {
      'title': 'Cardio Stats',
      'url': 'assets/stats.png',
      'routeName': YourRuns.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
    },
    {
      'title': 'Contacts',
      'url': 'assets/twerkout.png',
      'routeName': ImportantContacts.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 7,
    },
    // {
    //   'title': 'Workouts',
    //   'url': 'assets/twerkout.png',
    //   'routeName': Workouts_Home.routeName,
    //   'description':
    //       'This section is under construction. Check back in later to view some exciting new stuff!',
    //   'heroID': 7,
    // },
    // {
    //   'title': 'Workouts',
    //   'url': 'assets/twerkout.png',
    //   'routeName': Workouts_Plans.routeName,
    //   'description':
    //       'This section is under construction. Check back in later to view some exciting new stuff!',
    //   'heroID': 7,
    // },
    {
      'title': 'Allocation',
      'url': 'assets/alloc.png',
      'routeName': Sports.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 8,
    },
    {
      'title': 'Nutrition',
      'url': 'assets/food.png',
      'routeName': NutritionScreen.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 10,
    },
    {
      'title': 'Activities',
      'url': 'assets/acti.png',
      'routeName': Activity_Screen.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 11,
    },
    {
      'title': 'Admin',
      'url': 'assets/admin.png',
      'routeName': AdminHome.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 9,
    },
    {
      'title': 'Developers',
      'url': 'assets/admin.png',
      'routeName': Developer.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 9,
    },
  ];

  Widget build(BuildContext context) {
    final adminDataProvider = Provider.of<GetAdminDataFromGoogleSheetProvider>(
        context,
        listen: false);
    List<String> adminEmailIds = adminDataProvider.getAdminEmailIds();
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    final MediaQueryData data = MediaQuery.of(context);
    print(data);
    return MediaQuery(
        data: data.copyWith(
          textScaleFactor: 0.8,
        ),
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              'Logout?',
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.025 * _screenHeight),
                            ),
                            actions: <Widget>[
                              OutlinedButton(
                                onPressed: () {
                                  logoutUser();
                                  SystemNavigator.pop();
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.025 * _screenHeight),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.025 * _screenHeight),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 0.025 * _screenHeight),
                      )),
                ),
                ListTile(
                  title: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Developer.routeName,
                        );
                      },
                      child: Text(
                        "Developers",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 0.025 * _screenHeight),
                      )),
                ),
                ListTile(
                  title: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        QuickLinks.routeName,
                      );
                    },
                    child: Text(
                      "Quick Links",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 0.025 * _screenHeight),
                    ),
                  ),
                ),
              ],
            ),
          ),

          appBar: AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.03 * _screenWidth,
                    vertical: 0.008 * _screenHeight),
                child: GestureDetector(
                  onTap: () {
                    print("hey");
                    Navigator.pushNamed(
                      context,
                      Profile.routeName,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.black,
                            width: 0.0025 * _screenHeight)),
                    height: 0.05 * _screenHeight,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(Data_Provider().user_display),
                    ),
                  ),
                ),
              )
            ],
            backgroundColor: Color(0xFFE4D8DC),
            //  centerTitle: true,
            elevation: 0,
            // title: Text(
            //   "FIITGN",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 0.08 * _screenHeight,
            //       fontFamily: 'Gilroy',
            //       fontWeight: FontWeight.bold),
            // ),
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.

            // Display a placeholder widget to visualize the shrinking size.
          ), // Make the initial height of the SliverAppBar larger than normal.
          body: ListView(
            physics: ScrollPhysics(),
            children: [
              Container(
                color: Color(0xFFE4D8DC),
                height: 0.18 * _screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "FIITGN",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 0.085 * _screenHeight,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Welcome, " + Data_Provider().name.toString(),
                      style: TextStyle(
                          fontSize: 0.035 * _screenHeight,
                          fontFamily: 'Gilroy'),
                    ),
                    //  Text(
                    // "What would you like to do today?",
                    //   style: TextStyle(
                    //       fontSize: 0.035 * _screenHeight,
                    //       fontFamily: 'Gilroy'),
                    // ),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (ctx, i) => Padding(
                        padding: EdgeInsets.only(
                          top: 0.0125 * _screenHeight,
                          bottom: 0.0125 * _screenHeight,
                        ),
                        child: homeScreenList[i]['routeName'] !=
                                AdminHome.routeName
                            ? HomeScreenItem(
                                routeName: homeScreenList[i]['routeName'],
                                title: homeScreenList[i]['title'],
                                url: homeScreenList[i]['url'],
                                description: homeScreenList[i]['description'],
                                heroID: homeScreenList[i]['heroID'],
                              )
                            : adminEmailIds
                                    .contains(Data_Provider().email.trim())
                                ? HomeScreenItem(
                                    routeName: homeScreenList[i]['routeName'],
                                    title: homeScreenList[i]['title'],
                                    url: homeScreenList[i]['url'],
                                    description: homeScreenList[i]
                                        ['description'],
                                    heroID: homeScreenList[i]['heroID'],
                                  )
                                : null,
                      ),
                  itemCount: homeScreenList.length),
            ],
          ),

          // child: Column(
          //   children: [
          //     SizedBox(height: MediaQuery.of(context).size.height / 40),
          //     Expanded(
          //       child: Container(
          //         child: ListView.separated(
          //           separatorBuilder: (ctx, i) => SizedBox(
          //             height: MediaQuery.of(context).size.height / 40,
          //           ),
          //           shrinkWrap: true,
          //           physics: ScrollPhysics(),
          //           itemCount: homeScreenList.length,
          //           itemBuilder: (ctx, i) => HomeScreenItem(
          //             routeName: homeScreenList[i]['routeName'],
          //             title: homeScreenList[i]['title'],
          //             url: homeScreenList[i]['url'],
          //             description: homeScreenList[i]['description'],
          //             heroID: homeScreenList[i]['heroID'],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ));
  }
}
