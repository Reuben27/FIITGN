import '../data/initialize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> updater(String starttime, String endtime) async {
  //update data
  var bookedSlots, numberofslots;
  CollectionReference currentroom = FirebaseFirestore.instance.collection(sportroomid);
  DocumentSnapshot documentSnapshot = await currentroom.doc(selectedroomid).get();
  if (documentSnapshot.exists) {
    bookedSlots = await documentSnapshot['bookedslots'];
    numberofslots = await documentSnapshot['numberofbookedslots'];
    print(bookedSlots);
    print(numberofslots);

    String currentslot = numberofslots.toString();
    bookedSlots[currentslot] = [starttime, endtime];
    numberofslots = numberofslots + 1;

    currentroom
        .doc(selectedroomid)
        .update({
          'bookedslots': bookedSlots,
          'numberofbookedslots': numberofslots,
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
