import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../data/initialize.dart';

List<List<int>> bookedornot = [];
List<String> timeofDay = [
  "00",
  "01",
  "02",
  "03",
  "04",
  "05",
  "06",
  "07",
  "08",
  "09",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23"
];

int numberofdaysinadvance = 2;

Future<void> getslots() async {
  CollectionReference currentroom = FirebaseFirestore.instance.collection(sportroomid);
  DocumentSnapshot documentSnapshot = await currentroom.doc(selectedroomid).get();
  var bookedslots, numberofslots;
  bookedornot = [];

  for(int i = 0; i < numberofdaysinadvance; i++){
    bookedornot.add(List.filled(24, 0));
  }

  print(bookedornot);

  if (documentSnapshot.exists) {
    bookedslots = await documentSnapshot['bookedslots'];
    numberofslots = await documentSnapshot['numberofbookedslots'];
    for(int i = 0; i < numberofdaysinadvance; i++){
      for(int j = 0; j < 24; j++){
        int flag = 0;
        if(j < 6 || (j > 10 && j < 18) || j > 22){
          flag = 1;
        }
        else{
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: i))).trim();
          today = today + " " + timeofDay[j] + ":00:00.000";
          //print("today" + today);
          for(int k = 0; k < numberofslots; k++){
            //print(bookedslots[k.toString()][0]);         
            if(bookedslots[k.toString()][0] == today){
              flag = 1;
              break;
            }
          }
        }
        bookedornot[i][j] = flag;
      }
    }

    print(bookedornot);

  } else{
    print('no data');
  }
}