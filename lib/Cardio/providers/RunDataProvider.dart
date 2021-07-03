// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './RunModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Providers/DataProvider.dart';

class RunDataProvider with ChangeNotifier {
  // String _uid;
  // String _token;

  List<RunModel> _yourRunsList = [
    // RunModel(
    //   uid: 'gautam.pv@iitgn.ac.in',
    //   dateOfRun: 'Thu, Oct 22, 2020',
    //   avgSpeed: '8',
    //   distanceCovered: '2.8',
    //   startTime: '17:36',
    //   timeOfRunHrs: '00',
    //   timeOfRunMin: '24',
    //   timeOfRunSec: '23',
    //   listOfLatLng: [
    //     {'latitude': 2, 'longitude': 3}
    //   ],
    //   intialLatitude: 2,
    //   initialLongitude: 3,
    // ),
    // RunModel(
    //   uid: 'gautam.pv@iitgn.ac.in',
    //   dateOfRun: 'Thu, Oct 22, 2020',
    //   avgSpeed: '6.8',
    //   distanceCovered: '3.8',
    //   startTime: '18:33',
    //   timeOfRunHrs: '00',
    //   timeOfRunMin: '29',
    //   timeOfRunSec: '33',
    //   listOfLatLng: [
    //     {'latitude': 2, 'longitude': 3}
    //   ],
    //   initialLongitude: 3,
    //   intialLatitude: 2,
    // ),
  ];

//  var x =  _yourRunsList[0];

  // void setToken(String token) {
  //   _token = token;
  // }

  // void setUid(String userUid) {
  //   _uid = userUid;
  //   // print('uid has been set');
  //   notifyListeners();
  //   // print("uid is $_uid");
  // }

  Future<void> getRunStatsFromDb() async {
    String _uid = Data_Provider().uid;
    // print("Run Data Provider uid --> " + _uid);
    final url =
        'https://fiitgn-6aee7-default-rtdb.firebaseio.com/RunData.json?orderBy="uid"&equalTo="$_uid"';
    try {
      // print("entered the try block");
      final response = await http.get(Uri.parse(url));
      // print("t1");
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print("t2");
      final List<RunModel> loadedList = [];
      // print("t3");
      // print(extractedData);
      // print(extractedData['-MMvLcgO2K3wHZkueZcV']['listOfLatLng'].runtimeType);
      extractedData.forEach(
        (statId, statVal) {
          // print("t4");
          loadedList.add(
            new RunModel(
              databaseID: statId,
              uid: statVal['uid'],
              dateOfRun: statVal['dateOfRun'],
              avgSpeed: statVal['avgSpeed'],
              distanceCovered: statVal['distanceCovered'],
              startTime: statVal['startTime'],
              timeOfRunSec: statVal['timeOfRunSec'],
              timeOfRunMin: statVal['timeOfRunMin'],
              timeOfRunHrs: statVal['timeOfRunHrs'],
              listOfLatLng: statVal['listOfLatLng'],
              initialLongitude: statVal['initialLongitude'],
              initialLatitude: statVal['initialLatitude'],
            ),
          );
          // print("t5");
          _yourRunsList = loadedList;
          _yourRunsList.sort((a, b) {
            return b.dateOfRun.compareTo(a.dateOfRun);
          });
          notifyListeners();
        },
      );
      print("Run Loaded List is ready");
      // print(json.decode(response.body));
    } catch (e) {
      print("Error --> " + e.toString());
      throw (e);
    }
  }

  List<RunModel> get yourRunsList {
    return [..._yourRunsList];
  }

  Future<void> addNewRunData(
    // uid through the Data Provider
    String dateOfRun,
    String avgSpeed,
    String distanceCovered,
    String startTime,
    String timeOfRunHrs,
    String timeOfRunMin,
    String timeOfRunSec,
    List<Map<String, double>> listOfLatLng,
    double initialLatitude,
    double initialLongitude,
  ) {
    // print("The Uid Is " + _uid);
    String _uid = Data_Provider().uid;
    // print("Run Data Provider fetching uid --> " + _uid);
    final url = 'https://fiitgn-6aee7-default-rtdb.firebaseio.com/RunData.json';
    return http
        .post(
      Uri.parse(url),
      body: json.encode(
        {
          'uid': _uid,
          'dateOfRun': dateOfRun,
          'avgSpeed': avgSpeed,
          'distanceCovered': distanceCovered,
          'startTime': startTime,
          'timeOfRunSec': timeOfRunSec,
          'timeOfRunMin': timeOfRunMin,
          'timeOfRunHrs': timeOfRunHrs,
          'listOfLatLng': listOfLatLng,
          'initialLatitude': initialLatitude,
          'initialLongitude': initialLongitude
        },
      ),
    )
        .then(
      (response) {
        var databaseId = json.decode(response.body)['name'];
        _yourRunsList.insert(
          0,
          RunModel(
            databaseID: databaseId,
            uid: _uid,
            dateOfRun: dateOfRun,
            avgSpeed: avgSpeed,
            distanceCovered: distanceCovered,
            startTime: startTime,
            timeOfRunSec: timeOfRunSec,
            timeOfRunMin: timeOfRunMin,
            timeOfRunHrs: timeOfRunHrs,
            listOfLatLng: listOfLatLng,
            initialLatitude: initialLatitude,
            initialLongitude: initialLongitude,
          ),
        );
        notifyListeners();
      },
    ).catchError((error) {
      print(error);
      throw error;
    });
  }
}
