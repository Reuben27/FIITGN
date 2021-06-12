import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/RunDataProvider.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:flutter_map/flutter_map.dart';
import '../providers/RunModel.dart';

class YourRunPolyLineScreen extends StatefulWidget {
  static const routeName = 'YourRunPolyLineScreen';
  @override
  _YourRunPolyLineScreenState createState() => _YourRunPolyLineScreenState();
}

class _YourRunPolyLineScreenState extends State<YourRunPolyLineScreen> {
  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context).settings.arguments as int;
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
    return Scaffold(
      body: FlutterMap(
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
      ),
    );
  }
}
