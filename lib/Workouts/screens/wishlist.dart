// import 'package:fiitgn_workouts_1/models/WorkoutModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../models/Workouts_providers.dart';
import '../models/Workout_provider.dart';
import '../models/WorkoutModel.dart';

// class Wishlist extends StatefulWidget {
//   static const routeName = '\FollowerdWorkouts';

//   @override
//   _WishlistState createState() => _WishlistState();
// }

class Wishlist extends StatelessWidget {
  static const routeName = '\FollowerdWorkouts';
  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<Workouts_Provider>(context);
    final List<WorkoutModel> followedWorkouts =
        workoutProvider.followedWorkouts();
    print(followedWorkouts.length);
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar:AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'Your Workouts',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).viewPadding.top) /
                    28,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: followedWorkouts.length == 0
            ? Center(child: Text("none"))
            : ListView.builder(
                itemCount: followedWorkouts.length,
                itemBuilder: (ctx, i) {
                  return ListTile(title: Text(followedWorkouts[i].workoutName));
                },
              ),
      ),
    );
  }
}
