import 'package:flutter/material.dart';

class Rep_Counter extends StatefulWidget {
  @override
  Rep_CounterState createState() => Rep_CounterState();
}

class Rep_CounterState extends State<Rep_Counter> {
  static int counter = 0;
  // int getCounter() {
  //   print("counter is " + _counter.toString());
  //   return _counter;
  // }

  // void setCounter(){

  // }
  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter = counter - 1;
      } else {
        print("negative not allowed");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _decrementCounter,
            icon: Icon(Icons.arrow_back_ios),
          ),
          Center(
            child: Text(
              '$counter',
              textScaleFactor: 0.8,
              style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 0.025 * _screenHeight),
            ),
          ),
          IconButton(
            onPressed: _incrementCounter,
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
