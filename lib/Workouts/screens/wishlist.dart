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
    print(followedWorkouts);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Workouts'),
      ),
      body: followedWorkouts.length == 0
          ? Center(child: Text("none"))
          : ListView.builder(
              itemCount: followedWorkouts.length,
              itemBuilder: (ctx, i) {
                return ListTile(title: Text(followedWorkouts[i].workoutName));
              },
            ),
    );
  }
}
