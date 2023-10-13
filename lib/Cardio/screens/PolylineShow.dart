import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

class PolyLineScreen extends StatefulWidget {
  static const routeName = '\polyLineScreen';
  @override
  _PolyLineScreenState createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    double initialLat = routeArgs['initialLat'];
    double initialLong = routeArgs['initialLong'];
    List<dynamic> listOfLatLng = routeArgs['listOfLatLng'];
    //  list of Latngs for Polylines
    List<latLng.LatLng> listOfPolyLineLatLng = [];

    for (int i = 0; i < listOfLatLng.length; i++) {
      listOfPolyLineLatLng.add(latLng.LatLng(
          listOfLatLng[i]['latitude'], listOfLatLng[i]['longitude']));
    }
    Polyline _polyline = Polyline(
        points: listOfPolyLineLatLng, strokeWidth: 3.5, color: Colors.amber);

    // LatLng initialLatLng = LatLng(initialLat, initialLong);
    print(initialLong);
    return Scaffold(
      appBar: AppBar(
        title: Text(' Show Polylines '),
      ),
      body: FlutterMap(
        options: MapOptions(
          // center: LatLng(initialLat,initialLong),
          center: latLng.LatLng(initialLat, initialLong),
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
