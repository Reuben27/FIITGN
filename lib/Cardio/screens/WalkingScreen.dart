import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepCounterScreen extends StatefulWidget {
  static const routeName = 'WalkScreen';

  @override
  _StepCounterScreenState createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  String _numberOfStepsTakenString = '';

  ///Distance will be calculated based on average step length of Male/Female
  int stepsTillNowInt = 258;
  String _distanceInMetresString = '';
  double _numOfStepsDouble;
  double _numOfMetresDouble;
  String caloriesBurned = 'Work in Progress';
  bool isMale = true;
  StreamSubscription<StepCount> _subscription;
  // Finding Steps Till Now
  int stepsRealInt; // actual Number of steps taken in one walk
  @override
  void initState() {
    super.initState();
    setUpPedometer();
  }

  void setUpPedometer() {
    _subscription = Pedometer.stepCountStream.listen(
      _onData,
      onError: _onError,
      onDone: _onDone,
    );
    print("Subscrption Began");
  }

  void _onError(error) {
    print("There is some Error $error");
  }

  void _onDone() {
    _subscription.cancel();
  }

  void _onData(StepCount stepCountValue) async {
    setState(
      () {
        int steps = stepCountValue.steps;
        // print("Steps recieved by stream are $steps");
        // print("Steps till now are $stepsTillNowInt");
        stepsRealInt = steps - stepsTillNowInt;
        _numOfStepsDouble = steps + 0.0 - stepsTillNowInt;
        _numberOfStepsTakenString = "$stepsRealInt";
        getDistance(_numOfStepsDouble);
      },
    );
  }

  void getDistance(double steps) {
    if (isMale) {
      setState(() {
        _numOfMetresDouble = steps * 0.762;
        String roundedNumber = _numOfMetresDouble.toStringAsFixed(2);
        _distanceInMetresString = roundedNumber;
      });
    } else {
      setState(() {
        _numOfMetresDouble = steps * 0.664;
        String roundedNumber = _numOfMetresDouble.toStringAsFixed(2);
        _distanceInMetresString = roundedNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final usefulData = Provider.of<UsefulData>(context);
    return Scaffold(
      appBar: AppBar(
        // leading: FaIcon(FontAwesomeIcons.walking),
        title: Text('Walk'),
      ),
      body: Container(
        alignment: FractionalOffset(0.5, 0.5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: FaIcon(FontAwesomeIcons.circle),
              contentPadding: EdgeInsets.all(30),
              trailing: FaIcon(FontAwesomeIcons.burn),
              title: Text(
                "$_distanceInMetresString meters",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.circle),
              contentPadding: EdgeInsets.all(30),
              trailing: FaIcon(FontAwesomeIcons.walking),
              title: Text(
                "$_numberOfStepsTakenString steps",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                print("Subscription Stopped");
                stepsTillNowInt = stepsRealInt;
                print(stepsRealInt);
                _subscription.cancel();

                Navigator.pop(context);
              },
              child: FittedBox(
                child: Text('Stop Walking'),
              ),
              elevation: 10,
            )
          ],
        ),
      ),
    );
  }
}
