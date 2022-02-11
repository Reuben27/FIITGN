import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> notiAdd(
    String tokenid, int hour, int minute, String workoutName) async {
  CollectionReference notify =
      FirebaseFirestore.instance.collection("Notifications");
  DocumentSnapshot documentSnapshot = await notify.doc(tokenid).get();
  var timemap = {};
  var tokenID;
  var numberofnoti;
  if (documentSnapshot.exists) {
    timemap = await documentSnapshot['TimeMap'];
    tokenID = await documentSnapshot['TokenID'];
    // print(timemap);
    numberofnoti = await documentSnapshot['numberofnoti'];
    numberofnoti += 1;
    timemap[numberofnoti.toString()] = {
      'time': {'hour': hour, 'minute': minute},
      'workoutName': workoutName,
    };
    await notify.doc(tokenid).update(
        {'TimeMap': timemap, 'numberofnoti': numberofnoti, 'TokenID': tokenID});
    // print("Updated");
  } else {
    notify.doc(tokenid).set({
      'TokenID': tokenid,
      'TimeMap': {
        '1': {
          'time': {
            'hour': hour,
            'minute': minute,
          },
          'workoutName': workoutName,
        },
      },
      'numberofnoti': 1,
    });
    // print("New doc added");
  }
}
