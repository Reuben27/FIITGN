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
    return ListTile(
      leading: IconButton(
        onPressed: _decrementCounter,
        icon: Icon(Icons.remove),
      ),
      title: Center(child: Text('$counter')),
      trailing: IconButton(
        onPressed: _incrementCounter,
        icon: Icon(Icons.add),
      ),
    );
  }
}
