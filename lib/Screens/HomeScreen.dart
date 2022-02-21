import 'package:fiitgn/Cardio/screens/Community_Stats.dart';
import 'package:fiitgn/Cardio/screens/YourRunsStatsScreen.dart';
import 'package:fiitgn/Important-Contacts/important-contacts.dart';
import 'package:fiitgn/QuickLinks/QuickLinks.dart';
import 'package:fiitgn/Screens/developers_page.dart';

import '../Allocation/screens/sports.dart';
import '../Providers/DataProvider.dart';
import '../Cardio/screens/RunScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Widgets/HomeScreenItem.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'GAuth.dart';

//// WORKOUTS
import '../Workouts/models/Admin_db_model.dart';
import '../Workouts/models/Workout_provider.dart';

//// NUTRITION
import '../Nutrition/screens/nutritionScreen.dart';

//// ACTIVITIES
import '../Sports-Activities/screens/activity_screens.dart';

//// ADMIN
import 'package:fiitgn/Admin/screens/admin_home.dart';

//// PROFILE
import '../Profile/screens/profile_page.dart';
import '../QuickLinks/QuickLinks.dart';
import '../Profile/utils/user_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  static const routeName = '\HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int shared_runs = 0;
  int total_runs = 0;

  insideInIt() async {
    final data_provider = Provider.of<Data_Provider>(context, listen: false);
    final workoutDataProvider =
        Provider.of<Workouts_Provider>(context, listen: false);
    print("Home Screen Inside init has succesfully run");
    // TO IMPROVISE SECURITY TOKEN WILL BE SET LATER
  }

  initialize() async {
    List temp = await getUserData(Data_Provider().uid);
    setState(() {
      total_runs = temp[3];
      shared_runs = temp[4];
    });
    print(shared_runs);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((e) async {
      await insideInIt();
      await initialize();
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
              ElevatedButton(
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
      'title': 'Allocation',
      'url': 'assets/alloc.png',
      'routeName': Sports.routeName,
      'description':
          'This section is under construction. Check back in later to view some exciting new stuff!',
      'heroID': 8,
    },
    {
      'title': 'Cardio',
      'url': 'assets/act.png',
      'routeName': MapScreen.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
    },
    {
      'title': 'statistics',
      'url': 'assets/stats.png',
      'routeName': YourRuns.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
    },
    {
      'title': 'IITGN runners',
      'url': 'assets/stats.png',
      'routeName': CommunityRuns.routeName,
      'description':
          'Running can be accessed from here. Get out there and get those legs working!',
      'heroID': 1,
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
                  padding: EdgeInsets.only(
                    left: 0.04 * _screenWidth,
                    top: 0.05 * _screenHeight,
                    bottom: 0.01 * _screenHeight,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF93B5C6),
                  ),
                  child: Text(
                    'Fitness \nSimplified!',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,
                      fontSize: 0.04 * _screenHeight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  color: Color(0xFFC9CCD5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 0.025 * _screenHeight,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 0.075 * _screenHeight,
                        width: 0.075 * _screenHeight,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.black,
                              width: 0.0025 * _screenHeight),
                          image: DecorationImage(
                            image: NetworkImage(Data_Provider().user_display),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          Data_Provider().name,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 0.03 * _screenHeight,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 0.035 * _screenHeight,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 0.04 * _screenWidth,
                          ),
                          Icon(FontAwesomeIcons.running),
                          SizedBox(
                            width: 0.015 * _screenWidth,
                          ),
                          Text(
                            '$total_runs' + ' runs recorded.',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 0.022 * _screenHeight,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 0.04 * _screenWidth,
                          ),
                          Icon(Icons.cloud_upload_outlined),
                          SizedBox(
                            width: 0.015 * _screenWidth,
                          ),
                          Text(
                            '$shared_runs' + ' runs shared with community!',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 0.022 * _screenHeight,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0.025 * _screenHeight,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.people),
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
                            fontSize: 0.03 * _screenHeight),
                      )),
                ),
                ListTile(
                  leading: Icon(Icons.bolt),
                  title: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        QuickLinks.routeName,
                      );
                    },
                    child: Text(
                      "Feedbacks/Bugs",
                      style: TextStyle(
                          fontFamily: 'Gilroy', fontSize: 0.03 * _screenHeight),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ImportantContacts.routeName,
                      );
                    },
                    child: Text(
                      "Contacts",
                      style: TextStyle(
                          fontFamily: 'Gilroy', fontSize: 0.03 * _screenHeight),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
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
                            fontSize: 0.03 * _screenHeight),
                      )),
                ),
                // SizedBox(height: 0.3 * _screenHeight),
              ],
            ),
          ),

          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
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
            elevation: 0,
          ),
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
