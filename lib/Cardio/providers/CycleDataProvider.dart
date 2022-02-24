// import 'package:provider/provider.dart';
import '../../Providers/DataProvider.dart';
import 'package:flutter/material.dart';
// import './RunModel.dart';
import 'CycleModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CycleDataProvider with ChangeNotifier {
  // String _uid;   
  // String _token;

  List<CycleModel> _yourCycleList = [
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
    print("Cycle Data Provider -->" + _uid);
    final url =
        'https://fiitgn-6aee7-default-rtdb.firebaseio.com/CycleData.json?orderBy="uid"&equalTo="$_uid"';
    try {
      print("enetered the try block");
      final response = await http.get(Uri.parse(url));
      print("t1");
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print("t2");
      final List<CycleModel> loadedList = [];
      print("t3");
      print(extractedData);
      // print(extractedData['-MMvLcgO2K3wHZkueZcV']['listOfLatLng'].runtimeType);
      extractedData.forEach((statId, statVal) {
        loadedList.add(
          new CycleModel(
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
        print("t4");
        // print(loadedList[0].avgSpeed);
        // print(loadedList[0].databaseID);
        print(loadedList[0].dateOfRun);
        // print(loadedList[0].distanceCovered);
        // print(loadedList[0].initialLatitude);
        // print(loadedList[0].initialLongitude);

        _yourCycleList = loadedList;
        _yourCycleList.sort((a, b) {
          return b.dateOfRun.compareTo(a.dateOfRun);
        });
        notifyListeners();
      });
      print("Loaded List is ready");
      print(json.decode(response.body));
    } catch (e) {
      throw (e);
    }
  }

  List<CycleModel> get yourCycleList {
    return [..._yourCycleList];
  }

  Future<void> addNewCycleData(
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
    String _uid = Data_Provider().uid;
    print("The Uid Is " + _uid);
    final url = 'https://fiitgn-6aee7-default-rtdb.firebaseio.com/CycleData.json';
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
        _yourCycleList.insert(
          0,
          CycleModel(
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
