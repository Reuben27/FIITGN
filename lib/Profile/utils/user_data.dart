import 'package:cloud_firestore/cloud_firestore.dart';

double height;
double weight;
double bmi;

Future<List> getUserData(String uid) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot = await users.doc(uid).get();

  if (documentSnapshot.exists) {
    height = await documentSnapshot['height'];
    weight = await documentSnapshot['weight'];
    bmi = weight / ((height*height)/10000);
    return [height, weight, bmi];
  } else {
    print("Error");
    return [0.0, 0.0 , 0.0];
  }
}

Future<void> editHeight(double height, String uid) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot = await users.doc(uid).get();
  double w = 0.0;

  if (documentSnapshot.exists) {
    w = await documentSnapshot['weight'];
  } 

  try {
    await users.doc(uid).set({
      'height': height,
      'weight': w,
    });
  } on Exception catch (e) {
    print('Error');
  }
}

Future<void> editWeight(double weight, String uid) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot = await users.doc(uid).get();
  double h = 0.0;

  if (documentSnapshot.exists) {
    h = await documentSnapshot['height'];
  } 
  
  try {
    await users.doc(uid).set({
      'weight': weight,
      'height': h,
    });
  } on Exception catch (e) {
    print('Error');
  }
}