import 'package:flutter/material.dart';

class SessionInfo extends StatefulWidget {
  final exercises;
  final benefits;
  const SessionInfo({ Key key, this.exercises, this.benefits}) : super(key: key);

  @override
  _SessionInfoState createState() => _SessionInfoState();
}

class _SessionInfoState extends State<SessionInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guided Sessions"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(widget.exercises.toString()),
            ),
            SizedBox(height: 10.0),
            Container(
              child: Text(widget.benefits.toString()),
            ),
          ],
        ),
      ),      
    );
  }
}