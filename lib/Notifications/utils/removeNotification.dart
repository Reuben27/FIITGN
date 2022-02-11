import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> notiRemove(String tokenid, String workoutName) async {
  CollectionReference notify =
      FirebaseFirestore.instance.collection("Notifications");
  // print(tokenid);
  DocumentSnapshot documentSnapshot = await notify.doc(tokenid).get();
  var timemap = {};
  var tokenID;
  var numberofnoti;
  if (documentSnapshot.exists) {
    timemap = await documentSnapshot['TimeMap'];
    tokenID = await documentSnapshot['TokenID'];
    // print(timemap);
    numberofnoti = await documentSnapshot['numberofnoti'];
    var flag = 0;
    for (var i = 1; i <= numberofnoti; i++) {
      if (timemap[i.toString()]['workoutName'] == workoutName) {
        flag = 1;
        continue;
      }
      if (flag == 1) {
        timemap[(i - 1).toString()] = timemap[(i).toString()];
      }
    }
    timemap.remove(numberofnoti.toString());
    numberofnoti -= 1;
    await notify.doc(tokenid).update(
        {'TimeMap': timemap, 'numberofnoti': numberofnoti, 'TokenID': tokenID});
    // print(timemap);
  } else {
    // print("There is some error.");
  }
}
