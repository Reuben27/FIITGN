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
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _decrementCounter,
            icon: Icon(Icons.arrow_back_ios),
          ),
          Center(
            child: Text(
              '$counter',
              style: TextStyle(fontFamily: 'Gilroy', fontSize: MediaQuery.of(context).size.width / 15),
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
