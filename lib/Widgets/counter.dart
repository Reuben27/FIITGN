import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  int getCounter() {
    print("counter is " + _counter.toString());
    return _counter;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: _decrementCounter,
        icon: Icon(Icons.remove),
      ),
      title: Center(child: Text('$_counter')),
      trailing: IconButton(
        onPressed: _incrementCounter,
        icon: Icon(Icons.add),
      ),
    );
  }
}
