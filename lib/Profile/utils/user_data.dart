import 'package:cloud_firestore/cloud_firestore.dart';

double height;
double weight;
int total_runs;
int shared_runs;
double bmi;

Future<List> getUserData(String uid) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot = await users.doc(uid).get();

  if (documentSnapshot.exists) {
    height = await documentSnapshot['height'];
    weight = await documentSnapshot['weight'];
    shared_runs = await documentSnapshot['shared_runs'];
    total_runs = await documentSnapshot['total_runs'];
    bmi = weight / ((height*height)/10000);
    return [height, weight, bmi, total_runs, shared_runs];
  } else {
    print("Error");
    return [0.0, 0.0 , 0.0, 0 , 0];
  }
}

Future<void> editHeight(double height, String uid) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot = await users.doc(uid).get();
  double w = 0.0;
  int shared_runs = 0;
  int total_runs = 0;

  if (documentSnapshot.exists) {
    w = await documentSnapshot['weight'];
    shared_runs = await documentSnapshot['shared_runs'];
    total_runs = await documentSnapshot['total_runs'];
  } 

  try {
    await users.doc(uid).set({
      'height': height,
      'weight': w,
      'total_runs' : total_runs,
      'shared_runs' : shared_runs,
    });
  } on Exception catch (e) {
    print('Error');
  }
}

Future<void> editWeight(double weight, String uid) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot = await users.doc(uid).get();
  double h = 0.0;
  int shared_runs = 0;
  int total_runs = 0;

  if (documentSnapshot.exists) {
    h = await documentSnapshot['height'];
    shared_runs = await documentSnapshot['shared_runs'];
    total_runs = await documentSnapshot['total_runs'];
  } 
  
  try {
    await users.doc(uid).set({
      'weight': weight,
      'height': h,
      'total_runs' : total_runs,
      'shared_runs' : shared_runs,
    });
  } on Exception catch (e) {
    print('Error');
  }
}


Future<void> editRuns(int s, int t, String uid) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot documentSnapshot = await users.doc(uid).get();
  double h = 0.0;
  double w = 0.0;
  int shared_runs = 0;
  int total_runs = 0;

  if (documentSnapshot.exists) {
    h = await documentSnapshot['height'];
    w = await documentSnapshot['weight'];
    shared_runs = await documentSnapshot['shared_runs'];
    total_runs = await documentSnapshot['total_runs'];
    shared_runs += s;
    total_runs += t;
  } 
  
  try {
    await users.doc(uid).set({
      'weight': weight,
      'height': h,
      'total_runs' : total_runs,
      'shared_runs' : shared_runs,
    });
  } on Exception catch (e) {
    print('Error');
  }
}