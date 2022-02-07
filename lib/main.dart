import 'package:fiitgn/QuickLinks/QuickLinks.dart';
import 'package:fiitgn/Screens/developers_page.dart';
import 'package:fiitgn/Workouts/screens/create_plan.dart';
import 'package:fiitgn/Workouts/screens/explore_plans.dart';
import 'package:fiitgn/Workouts/screens/explore_plans_display.dart';
import 'package:fiitgn/Workouts/screens/plans_created_by_user.dart';
import 'package:fiitgn/Workouts/screens/plans_wishlist.dart';
import 'package:fiitgn/Workouts/screens/weekly_plan_display.dart';
import 'package:fiitgn/Workouts/screens/weekly_plan_display_fromexplore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

////ADMIN SECTION
import 'Admin/screens/admin_home.dart';

//// CARDIO SECTION
import 'Calendar-Schedule/calendar_try_screen.dart';
import 'package:flutter/material.dart';
import 'Cardio/screens/CardioScreen.dart';
import 'Cardio/screens/WalkingScreen.dart';
import 'Cardio/screens/RunScreen.dart';
import 'Cardio/screens/ShowRunResults.dart';
import 'Cardio/screens/YourRunsStatsScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Cardio/screens/PolylineShow.dart';
import 'Cardio/screens/YourRunsPolyLines.dart';
import 'Cardio/providers/RunDataProvider.dart';
import 'package:provider/provider.dart';
import './Screens/GAuth.dart';
import 'Screens/StatsScreen.dart';
import 'Cardio/screens/CycleScreen.dart';
import 'Cardio/screens/ShowCycleResults.dart';
import 'Cardio/screens/yourCycleStatsScreen.dart';
import 'Cardio/providers/CycleDataProvider.dart';
import './Screens/SplashScreen.dart';
import 'Cardio/screens/NewRunScreen.dart';
import 'Cardio/screens/Additional_Stats.dart';

//// PROFILE
import 'Profile/screens/profile_page.dart';

import 'Workouts/screens/explore_workouts_plan_plan.dart';
import 'Workouts/screens/historyScreen1.dart';
import 'Workouts/screens/historyScreen2.dart';
import 'Workouts/screens/historyScreen3.dart';
import 'Workouts/screens/plan_plan_create_create_workout.dart';
import 'Workouts/screens/plans_following_now.dart';
import 'Workouts/screens/weekly_workout_details.dart';
import 'Workouts/screens/workout_plans_home.dart';
//// WORKOUTS SECTION
import 'Workouts/screens/workouts-home.dart';
import 'Workouts/screens/your-workouts.dart';
import 'Workouts/screens/ongoing_workouts.dart';
import 'Workouts/screens/wishlist.dart';
import 'Workouts/models/Workout_provider.dart';
// import 'Workouts/screens/create_workouts2.dart';
import 'Workouts/screens/create_workouts1.dart';
import './Providers/DataProvider.dart';
import 'Workouts/models/Admin_db_model.dart';
import 'Workouts/models/Exercise_db_model.dart';
import 'Workouts/screens/explore_workouts.dart';
import 'Workouts/screens/exercises_in_workout.dart';
import 'Workouts/screens/created_by_user.dart';
import 'Workouts/screens/workout_logging.dart';
import 'Notifications/Notifications.dart';
import 'Workouts/screens/workouts_history.dart';
import 'Workouts/screens/workout_history_details.dart';

//// Allocation
import 'Allocation/screens/sports.dart';

//// Guided Sessions
import 'Guided-Sessions/screens/sessions.dart';

//// Quick Links
import 'QuickLinks/QuickLinks.dart';

//// Nutrition
import 'Nutrition/screens/nutritionScreen.dart';
import 'Sports-Activities/screens/activity_screens.dart';

//// TEMP expansion panel
import './Screens/expansion_list.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.notification.title);
  print(message.notification.body);
  print(message.data.toString());
}

String token;
getToken() async {
  token = await FirebaseMessaging.instance.getToken();
  Data_Provider().setNotifToken(token);
  print(token);
}

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Method needed to initialize firebase application.
  await Firebase.initializeApp();
  getToken();
  // When killed
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(SignInGoogle().isSignedIn);
    return MultiProvider(
      providers: [
        //// CARDIO
        ChangeNotifierProvider.value(
          value: RunDataProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CycleDataProvider(),
        ),
        //// WORKOUTS
        ChangeNotifierProvider.value(
          value: Workouts_Provider(),
        ),
        ChangeNotifierProvider.value(
          value: Data_Provider(),
        ),
        ChangeNotifierProvider.value(
          value: GetAdminDataFromGoogleSheetProvider(),
        ),
        ChangeNotifierProvider.value(
          value: GetExerciseDataFromGoogleSheetProvider(),
        )
      ],
      child: MaterialApp(
        title: 'FIITGN',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFF05454),
          accentColor: Color(0xFF414141),
          backgroundColor: Color(0xFFF0F0F0),
          //fontFamily: 'Poppins'),
        ),
        // home: StoreReturnProvider().class_userInput_isSet
        // ? SignInFIITGN()
        // : DetailsScreen(),

        home: SplashScreen(),

        routes: {
          //// Cardio Section
          CardioScreen.routeName: (ctx) => CardioScreen(),
          StepCounterScreen.routeName: (ctx) => StepCounterScreen(),
          MapScreen.routeName: (_) => MapScreen(),
          ShowResultsScreen.routeName: (_) => ShowResultsScreen(),
          YourRuns.routeName: (_) => YourRuns(),
          HomeScreen.routeName: (_) => HomeScreen(),
          PolyLineScreen.routeName: (_) => PolyLineScreen(),
          YourRunPolyLineScreen.routeName: (_) => YourRunPolyLineScreen(),
          SignInGoogle.routeName: (_) => SignInGoogle(),
          StatsScreen.routeName: (_) => StatsScreen(),
          CycleScreen.routeName: (_) => CycleScreen(),
          // ShowCycleResultsScreen.routeName: (_) => ShowCycleResultsScreen(),
          YourCycleStats.routeName: (_) => YourCycleStats(),
          CalendarScreen.routeName: (_) => CalendarScreen(),
          // NewRunScreen.routeName: (_) => NewRunScreen(),
          Additional_stats_screen.routeName: (_) => Additional_stats_screen(),

          //// WOKROUTS SECTION
          Workouts_Home.routeName: (_) => Workouts_Home(),
          Workouts_Plans.routeName: (_) => Workouts_Plans(),
          Your_Workouts.routeName: (_) => Your_Workouts(),
          Ongoing_Workouts.routeName: (_) => Ongoing_Workouts(),
          Wishlist.routeName: (_) => Wishlist(),
          WorkoutHistoryScreen.routeName: (_) => WorkoutHistoryScreen(),
          Create_Workout2.routeName: (_) => Create_Workout2(),
          Explore_Workouts.routeName: (_) => Explore_Workouts(),
          Exercises_in_Workout.routeName: (_) => Exercises_in_Workout(),
          Created_by_user.routeName: (_) => Created_by_user(),
          Workout_Logging.routeName: (_) => Workout_Logging(),
          Notifications.routeName: (_) => Notifications(),
          Workout_History_Details.routeName: (_) => Workout_History_Details(),
          // PLANS Section
          Explore_Plans.routeName: (_) => Explore_Plans(),
          Following_now_Plans.routeName: (_) => Following_now_Plans(),
          Plans_createdByUser.routeName: (_) => Plans_createdByUser(),
          Wishlist_Plans.routeName: (_) => Wishlist_Plans(),
          WeeklyPlanDisplay.routeName: (_) => WeeklyPlanDisplay(),
          WeeklyPlanDisplayFromExplore.routeName: (_) =>
              WeeklyPlanDisplayFromExplore(),
          CreatePlan.routeName: (_) => CreatePlan(),
          Create_Workout_for_Plan.routeName: (_) => Create_Workout_for_Plan(),
          Explore_Workouts_For_Plan.routeName: (_) =>
              Explore_Workouts_For_Plan(),
          ExplorePlanDisplay.routeName: (_) => ExplorePlanDisplay(),
          WeeklyWorkoutDetails.routeName: (_) => WeeklyWorkoutDetails(),
          WorkoutsHistory1.routeName: (_) => WorkoutsHistory1(),
          WorkoutHistory2.routeName: (_) => WorkoutHistory2(),
          WorkoutsHistory3.routeName: (_) => WorkoutsHistory3(),
          ///// Admin Section
          AdminHome.routeName: (_) => AdminHome(),

          //// Allocation Section
          Sports.routeName: (_) => Sports(),

          //// Guided Sessions
          Sessions.routeName: (_) => Sessions(),

          ///// Nutrition
          NutritionScreen.routeName: (_) => NutritionScreen(),

          //// Activities
          Activity_Screen.routeName: (_) => Activity_Screen(),

          //// Stopwatch
          //// StopWatchScreen.routeName: (_) => StopWatchScreen(),

          //// Temp Expansion list
          ExpansionPanelDemo.routeName: (_) => ExpansionPanelDemo(),

          //// Splash Screen
          SplashScreen.routeName: (_) => SplashScreen(),
          Developer.routeName: (_) => Developer(),

          //// Profile
          Profile.routeName: (_) => Profile(),

          QuickLinks.routeName: (_) => QuickLinks()
        },
      ),
    );
  }
}
