import '../data/initialize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int micros = 1;

Future<int> checker(String starttime, String endtime) async {
  var start = DateTime.parse(starttime);
  //Adding microseconds to prevent isAfter from not working as intended
  start = start.add(new Duration(microseconds: micros));
  //print(start);
  var end = DateTime.parse(endtime);
  //Adding microseconds to prevent isAfter from not working as intended
  end = end.add(new Duration(microseconds: micros));
  micros += 1;

  var bookedSlots, numberofslots;
  CollectionReference currentroom = FirebaseFirestore.instance.collection(sportroomid);
  DocumentSnapshot documentSnapshot = await currentroom.doc(selectedroomid).get();
  if (documentSnapshot.exists) {
    bookedSlots = await documentSnapshot['bookedslots'];
    numberofslots = await documentSnapshot['numberofbookedslots'];
    print(bookedSlots);
    print(numberofslots);

    int flagRoom = -1;
    for (var j = 0; j < numberofslots; j++) {
      if (((start.isAfter(DateTime.parse(bookedSlots[j.toString()][0]))) &&
              start.isBefore(DateTime.parse(bookedSlots[j.toString()][1]))) ||
          ((end.isAfter(DateTime.parse(bookedSlots[j.toString()][0]))) &&
              end.isBefore(DateTime.parse(bookedSlots[j.toString()][1]))) ||
          (((start.isAfter(DateTime.parse(bookedSlots[j.toString()][0]))) &&
                  start.isBefore(end)) &&
              end.isBefore(DateTime.parse(bookedSlots[j.toString()][1])))) {
        flagRoom = j;
        break;
      } else {
        continue;
      }
    }

    if (flagRoom == -1) {
      status = 1;
      return 1;
    } else {
      status = 0;
      print("Cannot be booked");
      return 0;
    }
  } else {
    status = 0;
    print('Document does not exist on the database');
    return 0;
  }
}
