import 'package:flutter/material.dart';

class Additional_stats_screen extends StatelessWidget {
  List<int> timePerKmcomponent(int time) {
    // double hours = (time + 0.0) % 3600;
    // time = time - hours * 3600;
    int mins = (time) % 60;
    time = time - mins * 60;
    int secs = time;
    // assert hours>=0 && mins>=0 && secs>=0;
    List<int> ret = [mins, secs];
    return ret;
  }

  // const Additional_stats_screen({ Key? key }) : super(key: key);
  static const routeName = '\additional_stats_screen';
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    List<int> time_per_km = routeArgs['time_per_km'];
    List<double> speed_per_km = routeArgs['speed_per_km'];
    return Scaffold(
        appBar: AppBar(
          title: Text('Additional Stats'),
        ),
        body: time_per_km.length == 0
            ? Center(
                child: Text('Distance covered to less to generate stats'),
              )
            : ListView.builder(
                itemCount: time_per_km.length,
                itemBuilder: (ctx, i) {
                  List<int> time_comps = timePerKmcomponent(time_per_km[i]);
                  print('Km :' + (i + 1).toString());
                  print('Av speed- ' + (speed_per_km[i].toString()));
                  print('Av time-' +
                      time_comps[0].toString() +
                      'mins' +
                      time_comps[1].toString() +
                      'secs');
                  return Row(
                    children: [
                      Text('Km ' + (i + 1).toString()),
                      Text('Av speed-' + speed_per_km[i].toString()),
                      Text('Av time-' +
                          time_comps[0].toString() +
                          ':' +
                          time_comps[1].toString())
                    ],
                  );
                }));
  }
}
