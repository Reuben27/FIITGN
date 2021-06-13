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
  List<GuidedSessions> upcoming = List<GuidedSessions>.empty();
  List<GuidedSessions> ongoing = List<GuidedSessions>.empty();
  List<GuidedSessions> completed = List<GuidedSessions>.empty();

  @override
  void initState() {
    super.initState();
    getGuidedSessions().then((items) {
      setState(() {
        this.items = items;
        this.upcoming = upcomingSessions(items);
        this.ongoing = ongoingSessions(items);
        this.completed = completedSessions(items);
      });
    });      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guided Sessions"),
      ),
      body: Column(
        children: <Widget>[
          Text('Ongoing Sessions'),
          Expanded(
            child: ListView.builder(
              itemCount: ongoing.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.run_circle),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) => SessionInfo(exercises: ongoing[index].exercises, benefits: ongoing[index].benefits,),
                            ),
                          ),
                        },
                        child: Container(
                          child: Text(" ${ongoing[index].theme}"),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Text('Upcoming Sessions'),
          Expanded(
            child: ListView.builder(
              itemCount: upcoming.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.run_circle),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) => SessionInfo(exercises: upcoming[index].exercises, benefits: upcoming[index].benefits,),
                            ),
                          ),
                        },
                        child: Container(
                          child: Text(" ${upcoming[index].theme}"),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Text('Completed Sessions'),
          Expanded(
            child: ListView.builder(
              itemCount: completed.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.run_circle),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) => SessionInfo(exercises: completed[index].exercises, benefits: completed[index].benefits,),
                            ),
                          ),
                        },
                        child: Container(
                          child: Text(" ${completed[index].theme}"),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}