import './sessioninfo.dart';
import 'package:flutter/material.dart';
import '../data/guidedsessions.dart';

class Sessions extends StatefulWidget {
  static const routeName = "Sessions";

  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  List<GuidedSessions> items = List<GuidedSessions>.empty();

  @override
  void initState() {
    super.initState();
    getGuidedSessions().then((items) {
      setState(() {
        this.items = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guided Sessions"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.run_circle),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => SessionInfo(exercises: items[index].exercises, benefits: items[index].benefits,),
                      ),
                    ),
                  },
                  child: Container(
                    child: Text(" ${items[index].theme}"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}