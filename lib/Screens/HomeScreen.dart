import 'package:fiitgn/Cardio/screens/YourRunsStatsScreen.dart';
import 'package:fiitgn/Guided-Sessions/data/guidedsessions.dart';
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

//// GUIDED SESSIONS
import '../Guided-Sessions/screens/sessions.dart';

//// NUTRITION
import '../Nutrition/screens/nutritionScreen.dart';

//// ACTIVITIES
import '../Sports-Activities/screens/activity_screens.dart';

//// ADMIN
import 'package:fiitgn/Admin/screens/admin_home.dart';

//// Temp Expansion Panel
import './expansion_list.dart';

import '../Screens/stopwatch.dart';

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

    final prefs = await SharedPreferences.getInstance();
    print('got instance');
    String uid = prefs.getString('uid');
    String email = prefs.getString('email');
    String name = prefs.getString('name');
    String userDisplay = prefs.getString('userDisplay');
    data_provider.setUid(uid);
    data_provider.setEmailId(email);
    data_provider.setDisplay(userDisplay);
    data_provider.setName(name);
    print(Data_Provider().name);
    print(Data_Provider().email);
    print("Uids and tokens are set");
    // await workoutDataProvider.showAllWorkouts();
    // initializing admin and exercise dbs
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);
    final adminDataProvider = Provider.of<GetAdminDataFromGoogleSheetProvider>(
        context,
        listen: false);
    // print("a");
    // await exerciseDataProvider.getListOfExercises();
    // print("b");
    // await adminDataProvider.getListOfAdmins();
    //// END of initialization
    // print("all workouts Loaded");
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
    // {
    //   'title': 'Expansion Panel',
    //   'url': 'assets/roonn.png',
    //   'routeName': ExpansionPanelDemo.routeName,
    //   'description': 'EXPANSION',
    //   'heroID': 1,
    // },
    {
      'title': 'Activities',
      'url': 'assets/roonn.png',
      'routeName': MapScreen.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
    },
    {
      'title': 'Activity Results',
      'url': 'assets/roonn.png',
      'routeName': YourRuns.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
    },
    // {
    //   'title': 'Start Cycling',
    //   'url': 'assets/11241.png',
    //   'routeName': CycleScreen.routeName,
    //   'description':
    //       'Cycling can be accessed from here. Get out there and get those legs working!',
    //   'heroID': 2,
    // },
    // {
    //   'title': 'Workout',
    //   'url': 'assets/4805.png',
    //   'routeName': WorkoutHomeScreen.routeName,
    //   'description':
    //       'Had a quick warmup or a gruelling cardio session? Whichever it is, record it here and keep a tab on all those calories you are burning!',
    //   'heroID': 3,
    // },
    // {
    //   'title': 'Your Activities',
    //   'url': 'assets/statLady.png',
    //   'routeName': StatsScreen.routeName,
    //   'description':
    //       'Your running statistics can be seen here. Keep a watch and aim to reach higher and higher everyday.',
    //   'heroID': 4,
    // },
    // // // {
    // //   'title': 'Know Your Diet',
    // //   'url': 'assets/6569.png',
    // //   'routeName': '',
    // //   'description':
    // //       'This section is under construction. Check back in later to view some exciting new stuff!',
    // //   'heroID': 6,
    // // },
    {
      'title': 'Workouts',
      'url': 'assets/twerkout.png',
      'routeName': Workouts_Home.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 7,
    },
    {
      'title': 'Allocation',
      'url': 'assets/alloc.png',
      'routeName': Sports.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 8,
    },
    {
      'title': 'Admin',
      'url': 'assets/alloc.png',
      'routeName': AdminHome.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 9,
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
  ];

  Widget build(BuildContext context) {
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
              Container(
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.signOutAlt),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Do you want to Logout?'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              logoutUser();
                              SystemNavigator.pop();
                            },
                            child: Text('Yes'),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                            },
                            child: Text('No'),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(100.0),
        //   child: AppBar(
        //     actions: [

        //     ],
        //     backgroundColor: Color(0xFFD1D9D9),
        //     elevation: 0,
        //     title: Text(
        //       'FIITGN',

        //     centerTitle: true,
        //   ),
        // ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.03 * _screenWidth,
                      vertical: 0.008 * _screenHeight),
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
                )
              ],
              backgroundColor: Color(0xFFD1D9D9),
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
              floating: true,
              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: Container(
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
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 0.25 * _screenHeight,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (ctx, i) => Padding(
                        padding: EdgeInsets.only(
                          top: 0.0125 * _screenHeight,
                          bottom: 0.0125 * _screenHeight,
                        ),
                        child: HomeScreenItem(
                          routeName: homeScreenList[i]['routeName'],
                          title: homeScreenList[i]['title'],
                          url: homeScreenList[i]['url'],
                          description: homeScreenList[i]['description'],
                          heroID: homeScreenList[i]['heroID'],
                        ),
                      ),
                  childCount: homeScreenList.length),
            )
          ],
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
        ),
      ),
    );
  }
}
