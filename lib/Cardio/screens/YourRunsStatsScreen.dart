import '../../Providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/RunModel.dart';
import 'package:provider/provider.dart';
import '../providers/RunDataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'YourRunsPolyLines.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:flutter_map/flutter_map.dart';

class YourRuns extends StatefulWidget {
  static const routeName = 'YourRunsScreen';

  @override
  _YourRunsState createState() => _YourRunsState();
}

class _YourRunsState extends State<YourRuns> {
  var isInit = true;
  // @override
  // void initState() {
  //   Provider.of<RunDataProvider>(context, listen: false).getRunStatsFromDb();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      print("^^^^^^");
      print(Data_Provider().name);
      print("^^^^^^^");
      await Provider.of<RunDataProvider>(context).getRunStatsFromDb();
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    isInit = false;
  }

  Widget createSmallMap(int index) {
    final runStatsProvider = Provider.of<RunDataProvider>(context);
    final List<RunModel> runStats = runStatsProvider.yourRunsList;
    final double initialLatitude = runStats[index].initialLatitude;
    final double initialLongitude = runStats[index].initialLongitude;
    List<dynamic> listOfCoordinates = runStats[index].listOfLatLng;
    List<latLng.LatLng> listOfPolyLineLatLng = [];

    for (int i = 0; i < listOfCoordinates.length; i++) {
      listOfPolyLineLatLng.add(
        latLng.LatLng(
          listOfCoordinates[i]['latitude'],
          listOfCoordinates[i]['longitude'],
        ),
      );
      // print("Heehahahahahahahah");
    }
    Polyline _polyline = Polyline(
        points: listOfPolyLineLatLng, strokeWidth: 3.5, color: Colors.amber);

    return FlutterMap(
      options: MapOptions(
        center: latLng.LatLng(initialLatitude, initialLongitude),
        minZoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/gauti234/ckgovqsac39zk19o5vytzgreo/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ2F1dGkyMzQiLCJhIjoiY2tnbnA3ZHFvMjNwbzMwdGV1cGVtZWZqciJ9.jO2FxWNXXWh1Q8t_BaNs4g",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiZ2F1dGkyMzQiLCJhIjoiY2tnbnBlaWE2MHgzbDJ4bzFsb2x5ZnRjaCJ9.W3WKN9f1Uc5v4FT5om3-9g',
          },
        ),
        PolylineLayerOptions(polylines: [_polyline]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final runStatsProvider = Provider.of<RunDataProvider>(context);
    final List<RunModel> runStats = runStatsProvider.yourRunsList;
    // runStats.sort((a, b) {
    //   return b.dateOfRun.compareTo(a.dateOfRun);
    // });
    // print("yo yo " + runStats.toString());
    // final temp = runStatsProvider.getRunStatsFromDb();
    return runStats.length == 0
        ? Scaffold(
            appBar: AppBar(
              title: Text('Run Stats'),
              elevation: 10,
            ),
            body: Center(
              child: Text('No Runs Yet! Time to Run!'),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Run Stats'),
              elevation: 10,
            ),
            body: ListView.builder(
              itemBuilder: (ctx, i) {
                String distance = runStats[i].distanceCovered;
                String avgSpeed = runStats[i].avgSpeed;
                // String avgSpeedInKmph =
                // (double.parse(avgSpeed) * 5 / 18).toStringAsFixed(2);
                // print(timeInHrs + " : " + timeInMins + " : " + tim);
                return GestureDetector(
                  onTap: () {
                    //  go to the Show Polylines Screen

                    Navigator.pushNamed(
                        context, YourRunPolyLineScreen.routeName,
                        arguments: i); // passing the index
                  },
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(5),
                    shadowColor: Colors.black,
                    // child: Container(
                    //   height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      children: [
                        ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.calendar,
                            color: Colors.black,
                          ),
                          title: runStats[i].dateOfRun == null
                              ? Text("Problem")
                              : Text(
                                  DateFormat.MMMMEEEEd()
                                      .format(
                                          DateTime.parse(runStats[i].dateOfRun))
                                      .toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          color: Colors.black,
                          child: createSmallMap(i),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'DISTANCE',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(distance),
                                      Text('kilometres')
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    children: [
                                      Text(
                                        'SPEED',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(avgSpeed),
                                      Text('KMPH')
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    children: [
                                      Text(
                                        'DURATION',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(runStats[i].timeOfRunHrs +
                                          ' : ' +
                                          runStats[i].timeOfRunMin),
                                      Text('')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(''),
                          ],
                        ),
                        // ListTile(
                        //   leading: FaIcon(
                        //     FontAwesomeIcons.road,
                        //     color: Colors.black,
                        //   ),
                        //   title: Text("$distance kms",
                        //       style: TextStyle(color: Colors.black)),
                        // ),
                        // ListTile(
                        //   leading: FaIcon(
                        //     FontAwesomeIcons.tachometerAlt,
                        //     color: Colors.black,
                        //   ),
                        //   title: Text("$avgSpeed m/s",
                        //       style: TextStyle(color: Colors.black)),
                        // ),

                        ListTile(
                          trailing: FlatButton(
                            color: Colors.grey[300],
                            height: 10,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, YourRunPolyLineScreen.routeName,
                                  arguments: i); // passing the index
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'See Run',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: runStats.length,
            ),
          );
  }
}
