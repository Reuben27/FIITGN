import '../Providers/DataProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Workouts/models/Admin_db_model.dart';
import '../Workouts/models/Exercise_db_model.dart';
import '../Workouts/models/Workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'GAuth.dart';
import 'HomeScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      
      bool isUserSignedIn;
      if(anonymous == true){
        isUserSignedIn = true;
      } else {
        isUserSignedIn = await googleSignIn.isSignedIn();
      }

      // final prefs = await SharedPreferences.getInstance();
      // final signedInStatus = prefs.getBool('signedInStatus');
      if (isUserSignedIn == null || isUserSignedIn == false) {
        Navigator.of(context).pushReplacementNamed(SignInGoogle.routeName);
      } else if (isUserSignedIn == true) {
        // print("CODE HAS COME HERE");
        final data_provider = Provider.of<Data_Provider>(context, listen: false);
        final prefs = await SharedPreferences.getInstance();
        // print('got instance');
        String uid = prefs.getString('uid');
        String email = prefs.getString('email');
        String name = prefs.getString('name');
        String userDisplay = prefs.getString('userDisplay');
        data_provider.setUid(uid);
        data_provider.setEmailId(email);
        data_provider.setDisplay(userDisplay);
        data_provider.setName(name);
        // print(Data_Provider().name);
        // print(Data_Provider().email);
        // print("Uids and tokens are set");
        final workoutDataProvider =
            Provider.of<Workouts_Provider>(context, listen: false);
        final exerciseDataProvider =
            Provider.of<GetExerciseDataFromGoogleSheetProvider>(context,
                listen: false);
        final adminDataProvider =
            Provider.of<GetAdminDataFromGoogleSheetProvider>(context,
                listen: false);
        // await workoutDataProvider.showAllWorkouts();
        // await workoutDataProvider.getWorkoutLogFromDB();
        // await exerciseDataProvider.getListOfExercises();
        await adminDataProvider.getListOfAdmins();
        // await Provider.of<RunDataProvider>(context, listen: false)
        //     .getRunStatsFromDb();
        //// END of initialization
        // await workoutDataProvider.showAllWorkouts();
        // await getNutritionData();
        // await getActivityData();
        // print("all data Loaded");
        // print("Home Screen Inside init has succesfully run");
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
    // Timer(Duration(seconds: 3), () async {
    //   final GoogleSignIn googleSignIn = GoogleSignIn();
    //   bool isUserSignedIn = await googleSignIn.isSignedIn();
    //   // final prefs = await SharedPreferences.getInstance();
    //   // final signedInStatus = prefs.getBool('signedInStatus');
    //   if (isUserSignedIn == null || isUserSignedIn == false) {
    //     Navigator.of(context).pushReplacementNamed(SignInGoogle.routeName);
    //   } else if (isUserSignedIn == true) {
    //     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    //   }
    // }
    // );
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    print(_screenRatio);
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 0.8),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   height: 0.2 * _screenHeight,
              //   child: Image.asset(
              //     "assets/iitgnlogo-emblem.png",
              //     fit: BoxFit.contain,
              //   ),
              // ),
              Container(
                height: 0.2 * _screenHeight,
                child: Image.asset(
                  "assets/icon.png",
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 0.03 * _screenHeight),
                child: Text(
                  "FIITGN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 0.1 * _screenHeight,
                      color: Colors.black,
                      fontFamily: 'Gilroy'),
                ),
              ),
              TypewriterAnimatedTextKit(
                onTap: () {
                  // print("Tap Event");
                },
                text: [
                  'loading fitness.',
                ],
                textStyle: TextStyle(
                    fontSize: 0.025 * _screenHeight,
                    color: Colors.grey[800],
                    fontFamily: 'Gilroy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
