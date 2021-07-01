import 'package:flutter/material.dart';

class Set_Counter extends StatefulWidget {
  @override
  Set_CounterState createState() => Set_CounterState();
}

class Set_CounterState extends State<Set_Counter> {
  static int counter = 0;
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
