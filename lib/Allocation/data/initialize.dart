import 'package:cloud_firestore/cloud_firestore.dart';

//Id of the collections in Firestore
String sportequipmentid; //collection of all equipments for a particular sport.
String sportroomid; //collection of all rooms for a particular sport.

//Room or equipments flag, if 1 then came from room else came from equipments
int reflag = 0;

//To store the document id of the room chosen by the user.
String selectedroomid;
String selectedroomname;

//Start and end time from entry.dart
String starttime;
String endtime;

//To store the availability of each equipment for the chosen time slot.
List<int> availability = [];

//List of names of the equipments of the chosen sport.
var equipmentsname = [];
var equipmentsid = [];

int numberofequipments;

//List of the order (input by the user).
List<int> orders = [];

int status = 0;

//List of Text Editing Controllers
var controllers = [];

//List of Counters
var counters = [];

//List of Sliders
var sliders = [];

//Function that initialize the collection id variables based on the sport chosen.
Future<int> getData(String sportid) async {
  CollectionReference sports = FirebaseFirestore.instance.collection('Sports');
  DocumentSnapshot documentSnapshot = await sports.doc(sportid).get();

  if (documentSnapshot.exists) {
    sportequipmentid = await documentSnapshot['sportequipmentid'];
    sportroomid = await documentSnapshot['sportroomid'];
    return 1;
  } else {
    print("Error");
    return 0;
  }
}

//Function that retrives the names of the equipments of the sport chosen.
Future<int> getName(String equipmentid) async {
  equipmentsid = [];
  equipmentsname = [];
  CollectionReference equipments = FirebaseFirestore.instance.collection(sportequipmentid);
  QuerySnapshot querySnapshot = await equipments.get();
  querySnapshot.docs.forEach((doc) {
    var name = doc['name'];
    var id = doc.id;
    equipmentsname.add(name);
    equipmentsid.add(id);
  });

  if (equipmentsname.length != 0) {
    print("Equipment names are recived.");
    print(equipmentsname);
    numberofequipments = equipmentsname.length;
    return 1;
  } else {
    print("Could not get equipment names.");
    return 0;
  }
}
