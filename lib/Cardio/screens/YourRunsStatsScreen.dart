import 'package:fiitgn/Cardio/screens/Additional_Stats.dart';
import '../../Providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/RunModel.dart';
import 'package:provider/provider.dart';
import '../providers/RunDataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'YourRunsPolyLines.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:flutter_map/flutter_map.dart';

class YourRuns extends StatefulWidget {
  static const routeName = 'YourRunsScreen';

  @override
  _YourRunsState createState() => _YourRunsState();
}

class _YourRunsState extends State<YourRuns> {
  var isInit = true;
  bool isLoading = true;

  @override
  void didChangeDependencies() async {
    if (isInit) {
      print("^^^^^^");
      print(Data_Provider().name);
      print("^^^^^^^");
      await Provider.of<RunDataProvider>(context).getRunStatsFromDb();
      // isLoading = false;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    isInit = false;
    setState(() {
      isLoading = false;
    });
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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    final runStatsProvider = Provider.of<RunDataProvider>(context);
    final List<RunModel> runStats = runStatsProvider.yourRunsList;
    // runStats.sort((a, b) {
    //   return b.dateOfRun.compareTo(a.dateOfRun);
    // });
    // print("yo yo " + runStats.toString());
    // final temp = runStatsProvider.getRunStatsFromDb();
    return runStats.length == 0
        ? Scaffold(
            appBar: AppBar( iconTheme: IconThemeData(
              color: Colors.black,
            ),
              // centerTitle: true,
              backgroundColor: Color(0xFF93B5C6),
              title: Text(
                'YOUR ACTIVITIES',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 0.04 * _screenHeight,
                    fontFamily: 'Gilroy'),
              ),
            ),
            body: isLoading == false
                ? Center(
                    child: Text('No Runs Yet! Time to Run!'),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
          )
        : MediaQuery(
            data: data.copyWith(
              textScaleFactor: 0.8,
            ),
            child: Scaffold(
              appBar: AppBar(
                // centerTitle: true,
                backgroundColor: Color(0xFF93B5C6),
                title: Text(
                  'YOUR ACTIVITIES',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 0.04 * _screenHeight,
                      fontFamily: 'Gilroy'),
                ),
              ),
              body: ListView.separated(
                separatorBuilder: (ctx, i) => Divider(),
                itemBuilder: (ctx, i) {
                  String distance = runStats[i].distanceCovered;
                  // String avgSpeed = runStats[i].avgSpeed;
                  // IMP THAT NOW IN runStats[i] av pace is stored in the name of avgSpeed
                  String av_pace = runStats[i].avgSpeed;
                  if (runStats[i].avgSpeed.contains(':') == false) {
                    double av_pace_double = double.parse(runStats[i].avgSpeed);
                    // Changing the form of av pace
                    av_pace = (av_pace_double.floor()).toStringAsFixed(0) +
                        ":" +
                        ((av_pace_double - av_pace_double.floor()) * 60)
                            .toStringAsFixed(0);
                  }

                  // String avgSpeedInKmph =
                  // (double.parse(avgSpeed) * 5 / 18).toStringAsFixed(2);
                  // print(timeInHrs + " : " + timeInMins + " : " + tim);
                  return InkWell(
                    onTap: () {
                      print(runStats[i].altitude_list);
                      List<double> altitude_list = runStats[i].altitude_list;
                      List<double> pace_list = runStats[i].pace_list;
                      Map<String, dynamic> pass = {};
                      pass['altitude_list'] = altitude_list;
                      pass['pace_list'] = pace_list;
                      pass['distance'] = distance;
                      double max_elevation = 0.0;
                      for (double elevation in altitude_list) {
                        if (elevation > max_elevation) {
                          max_elevation = elevation;
                        }
                      }
                      pass['index'] = i;
                      pass['max_elevation'] = max_elevation.toStringAsFixed(1);
                      pass['average_pace'] = av_pace;
                      pass['time'] = runStats[i].timeOfRunHrs +
                          ':' +
                          runStats[i].timeOfRunMin +
                          ':' +
                          runStats[i].timeOfRunSec;
                          pass['use_case'] = 'personal';

                      Navigator.pushNamed(context, Additional_stats.routeName,
                          arguments: pass);
                      // Navigator.pushNamed(
                      //     context, YourRunPolyLineScreen.routeName,
                      //     arguments: i);
                    },

                    // padding: EdgeInsets.only(
                    //   top: 0.0125 * _screenHeight,
                    //   bottom: 0.0125 * _screenHeight,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 0.1 * _screenHeight,
                          decoration: BoxDecoration(
                            color: Color(0xFFEFEFEF),
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(0.02 * _screenHeight),
                            //   topRight: Radius.circular(0.02 * _screenHeight),
                            // ),
                          ),

                          //   right: 0.02 * _screenWidth,
                          // ),
                          //   height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,
                          child: runStats[i].dateOfRun == null
                              ? Center(child: Text("Problem"))
                              : Container(
                                  margin: EdgeInsets.only(
                                    left: 0.025 * _screenWidth,
                                  ),
                                  child: Row(
                                    children: [
                                      // CircleAvatar(
                                      //   backgroundImage: NetworkImage(
                                      //       Data_Provider().user_display),
                                      // ),
                                      SizedBox(
                                        width: 0.0125 * _screenWidth,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            runStats[i].user_name,
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              fontSize: 0.04 * _screenHeight,
                                              // color: Colors.white,
                                              // fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            runStats[i].activity_name +
                                                " on " +
                                                DateFormat.yMd()
                                                    .add_jm()
                                                    .format(DateTime.parse(
                                                        runStats[i].dateOfRun))
                                                    .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 0.02 * _screenHeight,
                                                // color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(
                          //   left: 0.02 * _screenWidth,
                          //   right: 0.02 * _screenWidth,
                          // ),
                          height: 0.3 * _screenHeight,
                          width: _screenWidth,
                          child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, YourRunPolyLineScreen.routeName,
                                    arguments: i);
                              },
                              child: createSmallMap(i)),
                        ),
                        Container(
                          // margin: EdgeInsets.only(
                          //   left: 0.02 * _screenWidth,
                          //   right: 0.02 * _screenWidth,
                          // ),
                          decoration: BoxDecoration(
                            color: Color(0xFFEFEFEF),
                            // borderRadius: BorderRadius.only(
                            //   bottomLeft: Radius.circular(0.02 * _screenHeight),
                            //   bottomRight:
                            //       Radius.circular(0.02 * _screenHeight),
                            // ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 0.1 * _screenHeight,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: Text(
                                              runStats[i].timeOfRunHrs +
                                                  ' : ' +
                                                  runStats[i].timeOfRunMin +
                                                  ' : ' +
                                                  runStats[i].timeOfRunSec,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize:
                                                      0.045 * _screenHeight,
                                                  // color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'DURATION',
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
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              distance,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize:
                                                      0.045 * _screenHeight,
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
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              av_pace,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize:
                                                      0.045 * _screenHeight,
                                                  // color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'Mins/Km',
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
                                  ],
                                ),
                              ),
                              // Container(
                              //   height: 0.08 * _screenHeight,
                              //   child: Center(
                              //     child: Container(
                              //         width: 0.4 * _screenWidth,
                              //         height: 0.05 * _screenHeight,
                              //         child: OutlinedButton(
                              //           onPressed: () {
                              //             print("MUMYYYY");
                              //             print(runStats[i].altitude_list);
                              //             List<double> altitude_list =
                              //                 runStats[i].altitude_list;
                              //             List<double> pace_list =
                              //                 runStats[i].pace_list;
                              //             Map<String, dynamic> pass = {};
                              //             pass['altitude_list'] = altitude_list;
                              //             pass['pace_list'] = pace_list;
                              //             pass['distance'] = distance;
                              //             double max_elevation = 0.0;
                              //             for (double elevation
                              //                 in altitude_list) {
                              //               if (elevation > max_elevation) {
                              //                 max_elevation = elevation;
                              //               }
                              //             }
                              //             pass['max_elevation'] =
                              //                 max_elevation.toStringAsFixed(1);
                              //             pass['average_pace'] = av_pace;
                              //             pass['time'] =
                              //                 runStats[i].timeOfRunHrs +
                              //                     ' : ' +
                              //                     runStats[i].timeOfRunMin +
                              //                     ' : ' +
                              //                     runStats[i].timeOfRunSec;

                              //             Navigator.pushNamed(context,
                              //                 Additional_stats.routeName,
                              //                 arguments: pass);
                              //           },
                              //           child: Text(
                              //             'EXPAND',
                              //             style: TextStyle(
                              //                 fontSize: 0.04 * _screenHeight,
                              //                 fontFamily: 'Gilroy',
                              //                 color: Colors.black,
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //         )),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: runStats.length,
              ),
            ),
          );
  }
}
