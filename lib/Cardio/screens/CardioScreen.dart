import './RunScreen.dart';
import 'package:flutter/material.dart';
import 'WalkingScreen.dart';

class CardioScreen extends StatelessWidget {
  static const routeName = 'CardioScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //      title: Text('Cardio'),
        //    ),
        body: Column(
      children: <Widget>[
        Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  )
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.asset(
                'assets/newActivity.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 40,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: MediaQuery.of(context).size.width / 13.5,
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              )),
          Positioned(
            left: MediaQuery.of(context).size.width / 25.5,
            bottom: MediaQuery.of(context).size.height / 29.22,
            child: Text(
              'What would you like\nto do today?',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 10.3,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ]), // make everything below this stack horizontally scrollable

        Padding(
          child: ListTile(
            leading: Text('Running'),
            trailing: Icon(Icons.run_circle),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MapScreen.routeName);
            },
          ),
          padding: const EdgeInsets.all(40.0),
          // child: Container(
          //   //  color: Colors.grey,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20), color: Colors.grey),
          //   height: 200,
          //   width: MediaQuery.of(context).size.width,
          //   child: Row(
          //     children: [
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(20),
          //         child: Image.asset(
          //           'newActivity.jpeg',
          //           height: 200,
          //         ),
          //       ),
          //       Text('Running')
          //     ],
          //   ),
          //   // trailing: Icon(Icons.run_circle),
          //   // title: Text(
          //   //   'Running',
          //   // ),
          // ),
        ),

        // Padding(
        //   padding: const EdgeInsets.all(50.0),
        //   child: ListTile(
        //     trailing: Icon(Icons.directions_walk_sharp),
        //     title: Text(
        //       'Walking',
        //     ),
        //     onTap: () {
        //       Navigator.of(context).pushNamed(StepCounterScreen.routeName);
        //     },
        //   ),
        // ),
      ],
    ));
  }
}
