import '../providers/RunModel.dart';
import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/RunDataProvider.dart';
import '../../Screens/HomeScreen.dart';
import 'PolylineShow.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;
// import "package:latlong/latlong.dart" as latLng;

class ShowResultsScreen extends StatefulWidget {
  static const routeName = '\showResultsScreen';

  @override
  _ShowResultsScreenState createState() => _ShowResultsScreenState();
}

class _ShowResultsScreenState extends State<ShowResultsScreen> {
  final primaryColorThisScreen = Color(0XFF6D3FFF);

  final accentColorThisScreen = Color(0XFF233C63);

  Widget createSmallMap(Map args) {
    final double initialLatitude = args['initialLat'];
    final double initialLongitude = args['initialLong'];
    List<dynamic> listOfCoordinates = args['listOfLatLng'];
    // final runStatsProvider = Provider.of<RunDataProvider>(context);
    // final List<RunModel> runStats = runStatsProvider.yourRunsList;
    // final double initialLatitude = runStats[index].initialLatitude;
    // final double initialLongitude = runStats[index].initialLongitude;
    // List<dynamic> listOfCoordinates = runStats[index].listOfLatLng;
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
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    List<Map<String, double>> listOfLatLng = routeArgs['listOfLatLng'];
    String duration_minutes = routeArgs['duration_minutes'];
    String duration_hours = routeArgs['duration_hours'];
    String duration_seconds = routeArgs['duration_seconds'];

    var _isLoading = false;
    // for storing list of Lat Longs in the database
    // List<latLng.LatLng> listOfPolyLineLatLng = [];

    // for (int i = 0; i < listOfLatLng.length; i++) {
    //   listOfPolyLineLatLng.add(
    //     latLng.LatLng(
    //       listOfLatLng[i]['latitude'],
    //       listOfLatLng[i]['longitude'],
    //     ),
    //   );

    double initialLat = routeArgs['initialLat'];
    double initialLong = routeArgs['initialLong'];
    Map<String, dynamic> toPassToPolyLine = {
      'initialLat': initialLat,
      'initialLong': initialLong,
      'listOfLatLng': listOfLatLng,
    };
    double distance = routeArgs['distance'];
    String distanceString = distance.toStringAsFixed(2); // distance in kms
    // final percent = distance * 10;
    DateTime initialTime = routeArgs['initialTime'];
    final String startTime = DateFormat.Hm().format(initialTime);
    final String dateOfRun = initialTime.toIso8601String();
    DateTime finalTime = routeArgs['finalTime'];

    // print(timeSec);
    double allTimeInSec = double.parse(duration_seconds) +
        double.parse(duration_minutes) * 60 +
        double.parse(duration_hours) * 3600;
    double avgSpeed = (distance * 1000) / allTimeInSec;
    String avgSpeedString = avgSpeed.toStringAsFixed(2);
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    print(_screenHeight);
    print(_screenRatio);
    final MediaQueryData data = MediaQuery.of(context);

    return MediaQuery(
      data: data.copyWith(textScaleFactor: 0.8),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[100],
          centerTitle: true,
          title: Text(
            'SUMMARY',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 0.66 * _screenHeight,
                      color: Colors.black,
                      child: createSmallMap(routeArgs),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.05 * _screenHeight),
                            topRight: Radius.circular(0.05 * _screenHeight),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 0.12 * _screenHeight,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      duration_hours +
                                          ":" +
                                          duration_minutes +
                                          ":" +
                                          duration_seconds,
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.07 * _screenHeight,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        'DURATION',
                                        style: TextStyle(
                                            fontSize: 0.018 * _screenHeight,
                                            //      color: Colors.white,
                                            fontFamily: 'Gilroy'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(height: 0.01 * _screenHeight),
                            Container(
                              height: 0.12 * _screenHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "$distanceString",
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize:
                                                      0.07 * _screenHeight,
                                                  // color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'KILOMETRES',
                                              style: TextStyle(
                                                  fontSize:
                                                      0.018 * _screenHeight,
                                                  //      color: Colors.white,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(),
                                  Container(
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              avgSpeedString,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize:
                                                      0.07 * _screenHeight,
                                                  // color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'MPS',
                                              style: TextStyle(
                                                  fontSize:
                                                      0.018 * _screenHeight,
                                                  //      color: Colors.white,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(height: 0.01 * _screenHeight),
                            Container(height: 0.08 * _screenHeight,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Add function to add code to database
                                        _isLoading = true;
                                        runStatsProvider
                                            .addNewRunData(
                                          dateOfRun,
                                          avgSpeedString,
                                          distanceString,
                                          startTime,
                                          duration_hours,
                                          duration_minutes,
                                          duration_seconds,
                                          listOfLatLng,
                                          initialLat,
                                          initialLong,
                                        )
                                            .catchError((error) {
                                          print(error);
                                          return showDialog<Null>(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text('An error occured'),
                                              content: Text('Something went wrong'),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Okay'))
                                              ],
                                            ),
                                          );
                                        }).then(
                                          (_) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Navigator.pushReplacementNamed(
                                                context, HomeScreen.routeName);
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green[300],
                                          borderRadius: BorderRadius.circular(
                                              0.02 * _screenHeight),
                                        ),
                                        alignment: Alignment.center,
                                        width: 0.45 * _screenWidth,
                                        height: 0.05 * _screenHeight,
                                        child: Text(
                                          'SAVE',
                                          style: TextStyle(
                                              fontSize: 0.04 * _screenHeight,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, HomeScreen.routeName);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red[300],
                                          borderRadius: BorderRadius.circular(
                                              0.02 * _screenHeight),
                                        ),
                                        alignment: Alignment.center,
                                        width: 0.45 * _screenWidth,
                                        height: 0.05 * _screenHeight,
                                        child: Text(
                                          'DON\'T SAVE',
                                          style: TextStyle(
                                              fontSize: 0.04 * _screenHeight,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
//  Text(
//                      "$distanceString kms",timeMin,avgSpeedString
