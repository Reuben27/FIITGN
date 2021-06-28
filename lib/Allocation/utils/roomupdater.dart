import '../data/initialize.dart';
import '../../Providers/DataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> updater(String starttime, String endtime) async {
  //update data
  var bookedslots, numberofslots, userinfo;
  CollectionReference currentroom = FirebaseFirestore.instance.collection(sportroomid);
  DocumentSnapshot documentSnapshot = await currentroom.doc(selectedroomid).get();
  if (documentSnapshot.exists) {
    bookedslots = await documentSnapshot['bookedslots'];
    numberofslots = await documentSnapshot['numberofbookedslots'];
    userinfo = await documentSnapshot['userinfo'];
    print(bookedslots);
    print(numberofslots);
    print(userinfo);

    String currentslot = numberofslots.toString();
    bookedslots[currentslot] = [starttime, endtime];
    userinfo[currentslot] = {
      'emailid' : Data_Provider().email,
      'name' : Data_Provider().name,
    };
    numberofslots = numberofslots + 1;

    currentroom
        .doc(selectedroomid)
        .update({
          'bookedslots': bookedslots,
          'numberofbookedslots': numberofslots,
          'userinfo': userinfo,
        })
        .then((value) => {
          print("Data Updated. Room has been booked!"),
        })
        .catchError((error) => {print("Failed to updated data: $error")});
    
    status = 1;
    return 1;
  } else {
    status = 0;
    print("Could not get Document.");
    return 0;
  }
}
