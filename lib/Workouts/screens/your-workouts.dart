import 'package:flutter/material.dart';
import './ongoing_workouts.dart';
import './wishlist.dart';
import './created_by_user.dart';

class Your_Workouts extends StatefulWidget {
  static const routeName = '\Your_Workouts';
  @override
  _Your_WorkoutsState createState() => _Your_WorkoutsState();
}

class _Your_WorkoutsState extends State<Your_Workouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Ongoing_Workouts.routeName);
              },
              child: Text(
                'Ongoing Workouts',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Wishlist.routeName);
                // Navigator.pushNamed(context, CWScreen1.routeName);
              },
              child: Text(
                'Wishlist',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Created_by_user.routeName);
              },
              child: Text(
                'Created by you',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                // Navigator.pushNamed(context, CWScreen1.routeName);
              },
              child: Text(
                'History',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
