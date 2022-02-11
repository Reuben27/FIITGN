import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchScreen extends StatefulWidget {
  static const routeName = 'stopwatch';
  // const StopWatchScreen({ Key? key }) : super(key: key);

  @override
  _StopWatchScreenState createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  final isHours = true;
  @override
  void dispose() {
    stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<int>(
            stream: stopWatchTimer.rawTime,
            initialData: stopWatchTimer.rawTime.value,
            builder: (context, snapshot) {
              final value = snapshot.data;
              final displayTime = StopWatchTimer.getDisplayTime(value,
                  hours: isHours, milliSecond: false);
              return Text(
                displayTime,
                style: TextStyle(fontSize: 40),
              );
            },
          ),
          CustomButton(
            color: Colors.green,
            label: 'Start',
            onPressed: () {
              stopWatchTimer.onExecute.add(StopWatchExecute.start);
            },
          ),
          CustomButton(
            color: Colors.red,
            label: 'Stop',
            onPressed: () {
              stopWatchTimer.onExecute.add(StopWatchExecute.stop);
            },
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final String label;
  final Function onPressed;
  CustomButton({this.color, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      child: Text(label),
    );
  }
}
