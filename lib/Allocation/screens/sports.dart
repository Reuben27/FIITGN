import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/cloudbuild/v1.dart';
import '../data/initialize.dart';
import 'entry.dart';
import 'rooms.dart';

class Sports extends StatefulWidget {
  static const routeName = "SportsScreen";

  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  // final MediaQueryData data = MediaQuery.of(context);
  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: DefaultTabController(
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
                  fontSize: 0.04 * _screenHeight,
                  fontFamily: 'Gilroy'),
            ),
            bottom: TabBar(
              indicatorWeight: 0.002 * _screenHeight,
              tabs: [
                Tab(
                  child: Text(
                    "Rooms",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 0.035 * _screenHeight,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
                Tab(
                  child: Text(
                    "Equipment",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 0.035 * _screenHeight,
                        color: Colors.black,
                        fontFamily: 'Gilroy'),
                  ),
                ),
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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
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
          //   margin: EdgeInsets.only(top: 0.0125 * _screenHeight),
          height: _screenHeight,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              //  mainAxisSpacing: MediaQuery.of(context).size.width / 30,
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
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: 0.0125 * _screenHeight,
                        top: 0.0125 * _screenHeight,
                        left: 0.0125 * _screenWidth,
                        right: 0.00625 * _screenWidth),
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius:
                            BorderRadius.circular(0.025 * _screenHeight)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 0.11 * _screenHeight,
                            child: Image.asset(document['description'],
                                fit: BoxFit.contain),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.00625 * _screenHeight),
                            child: Text(
                              document['sportname'].toString().toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 0.045 * _screenHeight,
                                fontFamily: "Gilroy",
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              );
            }).toList(),
          ),
        );

        //Text('Rooms'),

        //  Text('Equipments'),
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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
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
                childAspectRatio: 1,
                //  mainAxisSpacing: MediaQuery.of(context).size.width / 20,
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
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 0.0125 * _screenHeight,
                          top: 0.0125 * _screenHeight,
                          left: 0.0125 * _screenWidth,
                          right: 0.00625 * _screenWidth),
                      decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius:
                              BorderRadius.circular(0.025 * _screenHeight)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 0.11 * _screenHeight,
                              child: Image.asset(document['description'],
                                  fit: BoxFit.contain),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.00625 * _screenHeight),
                              child: Text(
                                document['sportname'].toString().toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 0.045 * _screenHeight,
                                  fontFamily: "Gilroy",
                                ),
                              ),
                            ),
                          ]),
                    ),
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
