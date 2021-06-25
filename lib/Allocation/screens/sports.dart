import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/initialize.dart';
import 'entry.dart';
import 'rooms.dart';

class Sports extends StatefulWidget {
  static const routeName = "SportsScreen";

  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
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
          // body: DisplayData(),
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
  // const DisplayRoomData({ Key? key }) : super(key: key);

  @override
  _DisplayRoomDataState createState() => _DisplayRoomDataState();
}

class _DisplayRoomDataState extends State<DisplayRoomData> {
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
                  String tempsportid = document['sportid'];
                  int flag = await getData(tempsportid);
                  if (flag == 1) {
                    print(sportequipmentid);
                    print(sportroomid);
                    reflag = 1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Rooms(),
                      ),
                    );
                  } else {
                    print("Error");
                  }
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
                                color: Colors.deepOrange[300],
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
        )
 
            //Text('Rooms'),

            //  Text('Equipments'),
            );
      },
    );
    // return Container(

    // );
  }
}

class DisplayEquipmentsData extends StatefulWidget {
  // const DisplayEquipmentsData({ Key? key }) : super(key: key);

  @override
  _DisplayEquipmentsDataState createState() => _DisplayEquipmentsDataState();
}

class _DisplayEquipmentsDataState extends State<DisplayEquipmentsData> {
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
                    String tempsportid = document['sportid'];
                    int flag = await getData(tempsportid);
                    if (flag == 1) {
                      print(sportequipmentid);
                      print(sportroomid);
                      reflag = 0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Entry(),
                        ),
                      );
                    } else {
                      print("Error");
                    }
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
                                  color: Colors.deepOrange[300],
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
                            child: Image.asset('assets/ico.png',
                                fit: BoxFit.contain)),
                      ),
                    ]),
                  ),
                );
              }).toList(),
            ),
          ),

          //Text('Rooms'),

          //  Text('Equipments'),
        );
      },
    );
  }
}
