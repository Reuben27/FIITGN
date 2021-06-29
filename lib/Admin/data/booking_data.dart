import 'package:cloud_firestore/cloud_firestore.dart';

var adminequipmentbookedslots = {};
var adminequipmentuserinfo = {};
var adminequipmentbookingcount = 0;

var adminroombookedslots = {};
var adminroomuserinfo = {};
var adminroombookingcount = 0;

var adminsportequipmentid;
var adminsportroomid; 

int roe = 0; //0 if equipment, 1 if room

Future<bool> getEquipmentBookings(String equipmentid, String documentid) async{
  adminequipmentbookedslots = {};
  adminequipmentuserinfo = {};
  adminequipmentbookingcount = 0;
  CollectionReference currentequipment = FirebaseFirestore.instance.collection(equipmentid);
  DocumentSnapshot documentSnapshot = await currentequipment.doc(documentid).get();

  if (documentSnapshot.exists) {
    adminequipmentbookedslots = await documentSnapshot['bookedslots'];
    adminequipmentuserinfo = await documentSnapshot['userinfo'];
    adminequipmentbookingcount = await documentSnapshot['numberofbookedslots'];
    return true;
  } else {
    print('No data got');
    return false;
  }
}

Future<bool> getRoomBookings(String roomid, String documentid) async {
  adminroombookedslots = {};
  adminroomuserinfo = {};
  adminroombookingcount = 0;
  CollectionReference currentroom = FirebaseFirestore.instance.collection(roomid);
  DocumentSnapshot documentSnapshot = await currentroom.doc(documentid).get();

  if (documentSnapshot.exists) {
    adminroombookedslots = await documentSnapshot['bookedslots'];
    adminroomuserinfo = await documentSnapshot['userinfo'];
    adminroombookingcount = await documentSnapshot['numberofbookedslots'];
    return true;
  } else {
    print('No data got');
    return false;
  }
}