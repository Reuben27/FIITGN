import 'package:flutter/material.dart';

class CreatePlan extends StatefulWidget {
  const CreatePlan({Key key}) : super(key: key);
  static const routeName = 'createPlan';

  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(

            ///save plan copy paste code from save workout, same way i guess
            ///
            ///
            ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'CREATE PLAN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: PageView.builder(
          itemCount: 4,
          itemBuilder: (ctx, i) => Container(
            height: _screenHeight,
            child: Column(children: [
              Container(child: Text("Week #01")),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (ctx, i) => Container(
                          child: Row(
                            children: [
                              Text("Day 1"),
                              InkWell(
                                onTap:
                                    () {}, ////send to create workout and then bring back
                                child: Text("Create"),
                              ),
                              InkWell(
                                onTap:
                                    () {}, ////send to explore workout to choose and get back
                                child: Text("Explore"),
                              ),
                              InkWell(
                                child: Text("Rest"),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
