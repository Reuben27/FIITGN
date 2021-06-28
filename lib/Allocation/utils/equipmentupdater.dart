import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/vault/v1.dart';
import '../data/initialize.dart';
import '../../Providers/DataProvider.dart';

Future<void> infogetter() async {
  CollectionReference equipments = FirebaseFirestore.instance.collection(sportequipmentid);

  int length = orders.length;
  for (int i = 0; i < length; i++) {
    if (orders[i] != 0) {
      int availabilityNumber = availability[i] - orders[i];
      var bookedslots, userinfo;
      int numberofbookedslots = 0;
      String docname = equipmentsid[i];

      DocumentSnapshot documentSnapshot = await equipments.doc(docname).get();
      if (documentSnapshot.exists) {
        bookedslots = await documentSnapshot['bookedslots'];
        print(bookedslots);
        userinfo = await documentSnapshot['userinfo'];
        print(userinfo);
        numberofbookedslots = await documentSnapshot['numberofbookedslots'];
      } else {
        print("no data buoid");
      }

      String currentslot = numberofbookedslots.toString();

      bookedslots[currentslot] = {
        'availability': availabilityNumber,
        'orders': orders[i],
        'time': {'0': starttime, '1': endtime},
      };

      userinfo[currentslot] = {
        'emailid' : Data_Provider().email,
        'name' : Data_Provider().name,
      };

      numberofbookedslots += 1;

      int doneornot = await updater(docname, bookedslots, numberofbookedslots, sportequipmentid, userinfo);
      if (doneornot == 1) {
        status = 1;
        print("Data updated");
      } else {
        status = 0;
        print("Data not updated");
      }
    }
  }
}

Future<int> updater(String docname, var bookedslots, int numberofbookedslots, String sportequipmentid, var userinfo) async {
  CollectionReference equipments = FirebaseFirestore.instance.collection(sportequipmentid);

  try {
    await equipments.doc(docname).update({
      'bookedslots': bookedslots,
      'numberofbookedslots': numberofbookedslots,
      'userinfo' : userinfo,
    });
    return 1;
  } catch (e) {
    status = 0;
    print(e);
    return 0;
  }
}
