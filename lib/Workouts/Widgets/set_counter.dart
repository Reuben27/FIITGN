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
