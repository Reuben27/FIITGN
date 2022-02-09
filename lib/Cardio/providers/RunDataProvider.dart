// import 'package:provider/provider.dart';
import 'package:fiitgn/Cardio/screens/Community_Stats.dart';
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

  List<RunModel> _community_runs_list = [];
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

  Future<void> getCommunityStatsFromDb() async {
    String _uid = Data_Provider().uid;
    // print("Run Data Provider uid --> " + _uid);
    final url = 'https://fiitgn-6aee7-default-rtdb.firebaseio.com/RunData.json';
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
          List<double> altitude_list = [];

          List r_altList = statVal['altitude_list'];
          if (r_altList == null) {
            print("NULLLL");
          } else {
            r_altList.forEach((element) {
              altitude_list.add(element);
            });
            print("Altitude list is not null");
            print(altitude_list);
          }
          List<double> pace_list = [];
          List r_pace_list = statVal['pace_list'];
          if (r_pace_list == null) {
          } else {
            r_pace_list.forEach((element) {
              pace_list.add(element);
            });
          }

          String activity_name = Data_Provider().name + " run";
          String r_activity_name = statVal['activity_name'];
          if (r_activity_name != null) {
            activity_name = r_activity_name;
          }
          String is_private = "true";
          String r_is_private = statVal['is_private'];
          if (r_is_private != null) {
            is_private = r_is_private;
          }
          String user_name = Data_Provider().name;
          String r_user_name = statVal['user_name'];
          if(r_user_name != null){
            user_name = r_user_name;
          }
          // print(altitude_list);
          // print("GAMMMA");
          loadedList.add(
            new RunModel(
              user_name: user_name,
              activity_name: activity_name,
              is_private: is_private,
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
              altitude_list: altitude_list,
              pace_list: pace_list,
            ),
          );
          _community_runs_list = [];
          loadedList.forEach((element) {
            if (element.is_private == 'false') {
              _community_runs_list.add(element);
            }
          });
          _community_runs_list.sort((a, b) {
            return b.dateOfRun.compareTo(a.dateOfRun);
          });
          notifyListeners();
        },
      );
      print("Community Run Loaded List is ready");
      // print(json.decode(response.body));
    } catch (e) {
      print(" Community Error --> " + e.toString());
      throw (e);
    }
  }

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
          List<double> altitude_list = [];

          List r_altList = statVal['altitude_list'];
          if (r_altList == null) {
            print("NULLLL");
          } else {
            r_altList.forEach((element) {
              altitude_list.add(element);
            });
            print("Altitude list is not null");
            print(altitude_list);
          }
          List<double> pace_list = [];
          List r_pace_list = statVal['pace_list'];
          if (r_pace_list == null) {
          } else {
            r_pace_list.forEach((element) {
              pace_list.add(element);
            });
          }

          String activity_name = Data_Provider().name + " run";
          String r_activity_name = statVal['activity_name'];
          if (r_activity_name != null) {
            activity_name = r_activity_name;
          }
          String is_private = "false";
          String r_is_private = statVal['is_private'];
          if (r_is_private != null) {
            is_private = r_is_private;
          }

          String user_name = Data_Provider().name;
          String r_user_name = statVal['user_name'];
          if(r_user_name != null){
            user_name = r_user_name;
          }
          // print(altitude_list);
          // print("GAMMMA");
          loadedList.add(
            new RunModel(
              user_name: user_name,
              activity_name: activity_name,
              is_private: is_private,
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
              altitude_list: altitude_list,
              pace_list: pace_list,
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

  List<RunModel> get communityRuns {
    return [..._community_runs_list];
  }

  Future<void> addNewRunData(
    // uid through the Data Provider
    String user_name,
    String activity_name,
    String is_private,
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
    List<double> pace_list,
    List<double> altitude_list,
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
          'user_name':user_name,
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
          'initialLongitude': initialLongitude,
          'pace_list': pace_list,
          'altitude_list': altitude_list,
          'activity_name': activity_name,
          'is_private': is_private,
        },
      ),
    )
        .then(
      (response) {
        var databaseId = json.decode(response.body)['name'];
        _yourRunsList.insert(
          0,
          RunModel(
            user_name: user_name,
            activity_name: activity_name,
            is_private: is_private,
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
            altitude_list: altitude_list,
            pace_list: pace_list,
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
