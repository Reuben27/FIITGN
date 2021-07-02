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
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top - kToolbarHeight - 50,
            width: MediaQuery.of(context).size.width,
          ),
        ));
  }
}
