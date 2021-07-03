import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Providers/expansion_panel_model.dart';
// import 'package:flutter_expansion_panel_demo/model/expnasion_panel_model.dart';

class ExpansionPanelDemo extends StatefulWidget {
  static const routeName = '\expansion_panel';
  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("This is a test"),
        ),
        body: Center(child:
        
          Container(height: 100,
            child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    // Do something
                  },
                ),
          ),
        ));
  }
}
