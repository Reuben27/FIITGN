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

////////////WORKOUTS
import '../Workouts/screens/workouts-home.dart';
import '../Workouts/models/Admin_db_model.dart';
import '../Workouts/models/Exercise_db_model.dart';
import '../Workouts/models/Workout_provider.dart';

///////////// GUIDED SESSIONS
import '../Guided-Sessions/screens/sessions.dart';

///////// NUTRITION
import '../Nutrition/screens/nutritionScreen.dart';

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
    print("Uids and tokens are set");

    /// initializing admin and exercise dbs
    final exerciseDataProvider =
        Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
            listen: false);
    final adminDataProvider = Provider.of<GetAdminDataFromGoogleSheetProvider>(
        context,
        listen: false);
    await exerciseDataProvider.getListOfExercises();
    print("b");
    await adminDataProvider.getListOfAdmins();
    //// END of initialization
    await workoutDataProvider.showAllWorkouts();
    print("all workouts Loaded");
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
      'title': 'Start Running',
      'url': 'assets/10765.png',
      'routeName': MapScreen.routeName,
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
    {
      'title': 'Your Activities',
      'url': 'assets/statLady.png',
      'routeName': StatsScreen.routeName,
      'description':
          'Your running statistics can be seen here. Keep a watch and aim to reach higher and higher everyday.',
      'heroID': 4,
    },
    // {
    //   'title': 'Running Buddy',
    //   'url': 'assets/6517.png',
    //   'routeName': '',
    //   'description':
    //       'This section is under construction. Check back in later to view some exciting new stuff!',
    //   'heroID': 5,
    // },
    // // {
    // //   'title': 'Know Your Diet',
    // //   'url': 'assets/6569.png',
    // //   'routeName': '',
    // //   'description':
    // //       'This section is under construction. Check back in later to view some exciting new stuff!',
    // //   'heroID': 6,
    // // },
    // {
    //   'title': 'Calendarrr',
    //   'url': 'assets/6569.png',
    //   'routeName': CalendarScreen.routeName,
    //   'description':
    //       'This section is under construction. Check back in later to view some exciting new stuff!',
    //   'heroID': 6,
    // },
    {
      'title': 'Workout',
      'url': 'assets/4805.png',
      'routeName': Workouts_Home.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 7,
    },
    {
      'title': 'Allocation',
      'url': 'assets/statLady.png',
      'routeName': Sports.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 8,
    },
    {
      'title': 'Guided Sessions',
      'url': 'assets/6569.png',
      'routeName': Sessions.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 9,
    },
    {
      'title': 'Nutrition',
      'url': 'assets/6569.png',
      'routeName': NutritionScreen.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 10,
    },
  ];

  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context);
    print(deviceSize);
    return Scaffold(
      // backgroundColor: Colors.white,
      // body: WillPopScope(
      //   onWillPop: () => _onBackPressed(context),
      //   child: SafeArea(
      //     child: Column(
      //       // padding: const EdgeInsets.symmetric(
      //       //   vertical: 20,
      //       // ),
      //       children: <Widget>[
      //         // Padding(
      //         //   padding: const EdgeInsets.only(left: 20.0, right: 120.0),
      //         Stack(
      //           children: [
      //             Container(
      //               decoration: BoxDecoration(
      //                 gradient: LinearGradient(
      //                   begin: Alignment.topCenter,
      //                   end: Alignment.bottomCenter,
      //                   colors: [Colors.teal[300], Colors.white],
      //                 ),
      //               ),
      //               // color: Colors.green[200],

      //               height: MediaQuery.of(context).size.height * 0.30,
      //               width: MediaQuery.of(context).size.width,
      //               //       child: Image.asset(
      //               //       'assets/homePage.jpg',
      //               //     fit: BoxFit.cover,
      //             ),
      //             //   ),
      //             Positioned(
      //               left: MediaQuery.of(context).size.width / 20,
      //               top: MediaQuery.of(context).size.height / 26,
      //               child: Text(
      //                 'Hello.',
      //                 style: TextStyle(
      //                   fontFamily: 'Raleway',
      //                   fontSize: deviceSize.size.width / 6.5,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               left: MediaQuery.of(context).size.width / 19,
      //               top: MediaQuery.of(context).size.height / 8,
      //               child: Text(
      //                 'Welcome to FIITGN.',
      //                 style: TextStyle(
      //                   fontFamily: 'Raleway',
      //                   fontSize: deviceSize.size.width / 16,
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               left: MediaQuery.of(context).size.width / 25,
      //               top: MediaQuery.of(context).size.height / 6,
      //               child: Container(
      //                 child: IconButton(
      //                   icon: Icon(FontAwesomeIcons.signOutAlt),
      //                   onPressed: () {
      //                     showDialog(
      //                       context: context,
      //                       builder: (ctx) => AlertDialog(
      //                         title: Text('Do you want to Logout?'),
      //                         actions: <Widget>[
      //                           FlatButton(
      //                             onPressed: () {
      //                               logoutUser();
      //                               SystemNavigator.pop();
      //                             },
      //                             child: Text('Yes'),
      //                           ),
      //                           FlatButton(
      //                             onPressed: () {
      //                               Navigator.of(ctx).pop(true);
      //                             },
      //                             child: Text('No'),
      //                           )
      //                         ],
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),

      // Expanded(
      //   child: Container(
      //     child: GridView.builder(
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2,
      //           mainAxisSpacing:
      //               MediaQuery.of(context).size.height / 80),
      //       shrinkWrap: true,
      //       physics: ScrollPhysics(),
      //       itemCount: homeScreenList.length,
      //       itemBuilder: (ctx, i) => HomeScreenItem(
      //         routeName: homeScreenList[i]['routeName'],
      //         title: homeScreenList[i]['title'],
      //         url: homeScreenList[i]['url'],
      //         description: homeScreenList[i]['description'],
      //         heroID: homeScreenList[i]['heroID'],
      //       ),
      //     ),
      //   ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // OGHOMEPLSKEEP
      body: Stack(
        children: [
          Image.asset(
            'assets/iitgnCamp.jpg',
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 25),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.height / 20),
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.height / 20),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 40,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 5,
                          child: Image.asset(
                            "assets/iitgnlogo-emblem.png",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                          child: Text(
                            "FIITGN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width / 7,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
                          child: Text(
                            "THE COMPLETE FITNESS APP",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 18,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing:
                                          MediaQuery.of(context).size.height /
                                              80),
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: homeScreenList.length,
                              itemBuilder: (ctx, i) => HomeScreenItem(
                                routeName: homeScreenList[i]['routeName'],
                                title: homeScreenList[i]['title'],
                                url: homeScreenList[i]['url'],
                                description: homeScreenList[i]['description'],
                                heroID: homeScreenList[i]['heroID'],
                              ),
                            ),
                          ),
                        ),

                        // SignInButtonBuilder(
                        //   text: 'Login with IITGN ID',
                        //   icon: Icons.email,
                        //   // onPressed: () async {
                        //   //   await SignInClass(context: context).signIn();

                        //     // if (outCome == false) {
                        //     //   // _showSnackBar();
                        //     // }
                        //   //},
                        //   backgroundColor: Color(0xFF3F7B70),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
