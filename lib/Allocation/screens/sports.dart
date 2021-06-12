import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './roomorequipment.dart';
import '../data/initialize.dart';

class Sports extends StatefulWidget {
  static const routeName = "SportsScreen";

  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DisplayData(),
    );
  }
}

class DisplayData extends StatefulWidget {
  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    CollectionReference sports =
        FirebaseFirestore.instance.collection('Sports');

    return StreamBuilder<QuerySnapshot>(
      stream: sports.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return new Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hi Abhiram",
                    style: TextStyle(
                      fontSize: 37,
                      fontFamily: "Gro",
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "What would you play today?",
                    style: TextStyle(
                      fontSize: 37,
                      fontFamily: "Gro",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 6,

                    //   borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/statLady.png',
                      //  height: MediaQuery.of(context).size.height / 4.87,
                      // width: MediaQuery.of(context).size.width / 2.28,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 22,
                    width: MediaQuery.of(context).size.width / 1.5,
                    // decoration: BoxDecoration(
                    //     color: Color(0xFFFFFF).withOpacity(0.5),
                    //     borderRadius: BorderRadius.all(Radius.circular(30))),

                    child: Center(
                      child: Text('Select your Sport',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Gilroy",
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  // physics: NeverScrollableScrollPhysics(),

                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return GestureDetector(
                        onTap: () async {
                          String tempsportid = document['sportid'];
                          int flag = await getData(tempsportid);
                          if (flag == 1) {
                            print(sportequipmentid);
                            print(sportroomid);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RoomOrEquipment(),
                              ),
                            );
                          } else {
                            print("Error");
                          }
                        },
                        child: Container(
                          child: Column(children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 6,
                                child: Image.asset('assets/ico.png',
                                    fit: BoxFit.contain)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              document['sportname'],
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Gilroy",
                              ),
                            ),
                          ]),
                          width: MediaQuery.of(context).size.width / 3,
                        ));
                  }).toList(),
                )),
          ))
        ]);
      },
    );
  }
}
