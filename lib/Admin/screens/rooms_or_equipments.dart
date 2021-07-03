import '../data/booking_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'equipment_list.dart';
import 'room_list.dart';

class RoomorEquipments extends StatefulWidget {
  @override
  _RoomorEquipmentsState createState() => _RoomorEquipmentsState();
}

class _RoomorEquipmentsState extends State<RoomorEquipments> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "CHOOSE SPORT",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Gilroy'),
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Creates border
                  color: Colors.deepOrange[300]),
              tabs: [
                Tab(
                  child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Center(
                    child: Text(
                      "ROOMS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                )),
                Tab(
                    child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Center(
                    child: Text(
                      "EQUIPMENT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                ))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DisplayRoomData(),
              DisplayEquipmentsData(),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayRoomData extends StatefulWidget {
  @override
  _DisplayRoomDataState createState() => _DisplayRoomDataState();
}

class _DisplayRoomDataState extends State<DisplayRoomData> {
  @override
  Widget build(BuildContext context) {
    CollectionReference sports = FirebaseFirestore.instance.collection('Sports');
    
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

        return new Container(
          child: Container(
          height: MediaQuery.of(context).size.height,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisSpacing: MediaQuery.of(context).size.width / 20,
            ),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return GestureDetector(
                onTap: () async {
                  //go to room_bookings
                  roe = 1;
                  adminsportroomid = document['sportroomid'];
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => RoomList(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  height: MediaQuery.of(context).size.height / 8,
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 49,
                              ),
                              Text(
                                document['sportname'].toString().toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  fontFamily: "Gilroy",
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  5.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)),
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Image.asset(document['description'],
                              fit: BoxFit.contain)),
                    ),
                  ]),
                ),
              );
            }).toList(),
          ),
        ),
      );},
    );
  }
}

class DisplayEquipmentsData extends StatefulWidget {
  @override
  _DisplayEquipmentsDataState createState() => _DisplayEquipmentsDataState();
}

class _DisplayEquipmentsDataState extends State<DisplayEquipmentsData> {
  @override
  Widget build(BuildContext context) {
    CollectionReference sports = FirebaseFirestore.instance.collection('Sports');

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

        return new Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisSpacing: MediaQuery.of(context).size.width / 20,
              ),
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return GestureDetector(
                  onTap: () async {
                    //go to equipment_list
                    roe = 0;
                    adminsportequipmentid = document['sportequipmentid'];
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => EquipmentList(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    height: MediaQuery.of(context).size.height / 8,
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 49,
                                ),
                                Text(
                                  document['sportname']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: "Gilroy",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    5.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                          height: MediaQuery.of(context).size.height / 9,
                          width: MediaQuery.of(context).size.width / 2.5,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 6,
                            child: Image.asset(document['description'],
                                fit: BoxFit.contain)),
                      ),
                    ]),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
