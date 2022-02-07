// import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../providers/CycleDataProvider.dart';
// import '../../Screens/HomeScreen.dart';
// import 'PolylineShow.dart';
// // import "package:latlong/latlong.dart" as latLng;

// class ShowCycleResultsScreen extends StatefulWidget {
//   static const routeName = '\showCycleResultsScreen';

//   @override
//   _ShowCycleResultsScreenState createState() => _ShowCycleResultsScreenState();
// }

// class _ShowCycleResultsScreenState extends State<ShowCycleResultsScreen> {
//   final primaryColorThisScreen = Color(0XFF6D3FFF);

//   final accentColorThisScreen = Color(0XFF233C63);

//   @override
//   Widget build(BuildContext context) {
//     final runStatsProvider = Provider.of<CycleDataProvider>(context);
//     final routeArgs = ModalRoute.of(context).settings.arguments as Map;
//     List<Map<String, double>> listOfLatLng = routeArgs['listOfLatLng'];

//     var _isLoading = false;
//     // for storing list of Lat Longs in the database
//     // List<latLng.LatLng> listOfPolyLineLatLng = [];

//     // for (int i = 0; i < listOfLatLng.length; i++) {
//     //   listOfPolyLineLatLng.add(
//     //     latLng.LatLng(
//     //       listOfLatLng[i]['latitude'],
//     //       listOfLatLng[i]['longitude'],
//     //     ),
//     //   );

//     double initialLat = routeArgs['initialLat'];
//     double initialLong = routeArgs['initialLong'];
//     Map<String, dynamic> toPassToPolyLine = {
//       'initialLat': initialLat,
//       'initialLong': initialLong,
//       'listOfLatLng': listOfLatLng,
//     };
//     double distance = routeArgs['distance'];
//     String distanceString = distance.toStringAsFixed(2); // distance in kms
//     // final percent = distance * 10;
//     DateTime initialTime = routeArgs['initialTime'];
//     final String startTime = DateFormat.Hm().format(initialTime);
//     final String dateOfRun = initialTime.toIso8601String();
//     DateTime finalTime = routeArgs['finalTime'];
//     final timeOfRun = finalTime.difference(initialTime);
//     String time = timeOfRun.toString();
//     List<String> timeList = time.split(':');
//     String timeMin = timeList[1];
//     String timeHrs = timeList[0];
//     String a = timeList[2]; // for conversiom
//     double b = double.parse(a); // for conversion
//     String timeSec = b.toStringAsFixed(2);
//     // print(timeSec);
//     double allTimeInSec = double.parse(timeSec) +
//         double.parse(timeMin) * 60 +
//         double.parse(timeHrs) * 3600;
//     double avgSpeed = (distance * 1000) / allTimeInSec;
//     String avgSpeedString = avgSpeed.toStringAsFixed(2);

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         titleSpacing: 10,
//         title: Text(
//           'Cycling Results',
//         ),
//       ),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(25, 30, 25, 25),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         width: 70,
//                         height: 70,
//                         padding: EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Theme.of(context).primaryColor.withAlpha(50),
//                         ),
//                         child: Image.asset(
//                           'assets/iitgnlogo-emblem.png',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 30),
//                       ),
//                       Text(
//                         "$distanceString kms",
//                         style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontSize: 80,
//                           // fontFamily: 'Bebas',
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 15),
//                       ),
//                       Container(
//                         padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           children: <Widget>[
//                             // Row(
//                             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //   children: <Widget>[
//                             //     Text(
//                             //       '0 kms'.toUpperCase(),
//                             //       style: TextStyle(
//                             //         color: Colors.grey,
//                             //       ),
//                             //     ),
//                             //     Text(
//                             //       '10 kms'.toUpperCase(),
//                             //       style: TextStyle(
//                             //         color: Colors.grey,
//                             //       ),
//                             //     ),
//                             //   ],
//                             // ),
//                             // LinearPercentIndicator(
//                             //   lineHeight: 8.0,
//                             //   percent: percent,
//                             //   linearStrokeCap: LinearStrokeCap.roundAll,
//                             //   backgroundColor:
//                             //       Theme.of(context).accentColor.withAlpha(30),
//                             //   progressColor: Theme.of(context).primaryColor,
//                             // ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 30),
//                             ),
//                             Text(
//                               'Time of Cycling'.toUpperCase(),
//                               style: TextStyle(
//                                 color: Theme.of(context).accentColor,
//                                 // fontFamily: 'Bebas',
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               '$timeMin min(s)',
//                               style: TextStyle(
//                                 color: Theme.of(context).accentColor,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Divider(
//                         height: 25,
//                         color: Colors.grey[300],
//                       ),
//                       Container(
//                         child: Row(
//                           children: <Widget>[
//                             Expanded(
//                               flex: 2,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     'AVG SPEED',
//                                     style: TextStyle(
//                                       color: Theme.of(context).primaryColor,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   RichText(
//                                     text: TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text: '$avgSpeedString',
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             color:
//                                                 Theme.of(context).accentColor,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: ' m/s',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   Text(
//                                     'CALORIES',
//                                     style: TextStyle(
//                                       color: Theme.of(context).primaryColor,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   RichText(
//                                     text: TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text: 'Upcoming Feature!',
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             color:
//                                                 Theme.of(context).accentColor,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: '',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Divider(
//                         height: 25,
//                         color: Colors.grey[300],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10),
//                       ),
//                       RaisedButton(
//                         onPressed: () {
//                           Navigator.pushNamed(
//                             context,
//                             PolyLineScreen.routeName,
//                             arguments: toPassToPolyLine,
//                           );
//                         },
//                         elevation: 10,
//                         color: Theme.of(context).primaryColor,
//                         child: Text('See Track'),
//                       ),
//                       RaisedButton(
//                         onPressed: () {
//                           // Add function to add code to database

//                           setState(() {
//                             _isLoading = true;
//                           });
//                           runStatsProvider
//                               .addNewCycleData(
//                             dateOfRun,
//                             avgSpeedString,
//                             distanceString,
//                             startTime,
//                             timeHrs,
//                             timeMin,
//                             timeSec,
//                             listOfLatLng,
//                             initialLat,
//                             initialLong,
//                           )
//                               .catchError((error) {
//                             print(error);
//                             return showDialog<Null>(
//                               context: context,
//                               builder: (ctx) => AlertDialog(
//                                 title: Text('An error occured'),
//                                 content: Text('Something went wrong'),
//                                 actions: [
//                                   FlatButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('Okay'))
//                                 ],
//                               ),
//                             );
//                           }).then(
//                             (_) {
//                               setState(() {
//                                 _isLoading = false;
//                               });
//                               Navigator.pushReplacementNamed(
//                                   context, HomeScreen.routeName);
//                             },
//                           );
//                         },
//                         elevation: 10,
//                         color: Theme.of(context).primaryColor,
//                         child: Text('Save Progress'),
//                       ),
//                       RaisedButton(
//                         onPressed: () {
//                           Navigator.pushReplacementNamed(
//                               context, HomeScreen.routeName);
//                         },
//                         elevation: 10,
//                         color: Theme.of(context).primaryColor,
//                         child: Text('Exit Without Saving'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
