import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiitgn/Screens/HomeScreen.dart';
import './rooms.dart';
import './sports.dart';
import '../utils/equipmentupdater.dart';
import 'package:flutter/material.dart';
import '../data/initialize.dart';
import 'equipmententry.dart';

// ignore: must_be_immutable
class Equipments extends StatelessWidget {
  // const Equipments({ Key? key }) : super(key: key);
  String next = reflag == 0 ? "Room" : "Equipment";
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
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(_screenWidth, 0.08 * _screenHeight),
            child: Container(
              height: 0.08 * _screenHeight,
              width: _screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                        fontSize: 0.03 * _screenHeight,
                        //      color: Colors.white,
                        fontFamily: 'Gilroy'),
                  ),
                  Text(
                    "Time Slot",
                    style: TextStyle(
                        fontSize: 0.03 * _screenHeight,
                        //      color: Colors.white,
                        fontFamily: 'Gilroy'),
                  )
                ],
              ),
            ),
          ),
          backgroundColor: Colors.deepOrange[300],
          title: Text(
            'SELECT EQUIPMENT',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: DisplayData(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            orders = [];
            //make the orders list
            for (var i = 0; i < numberofequipments; i++) {
              int temp = counters[i];
              orders.add(temp);
            }
            print(orders);
            await infogetter();
            return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        Text(
                          "Booking Successful",
                          style: TextStyle(fontFamily: "Gilroy"),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green[300],
                        ),
                      ],
                    ),
                    content: Container(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Column(
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.deepOrange[300]),
                            ),
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  fontFamily: "Gilroy",
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.deepOrange[300],
                              ),
                            ),
                            child: Text(
                              'Book ' + next,
                              style: TextStyle(
                                  fontFamily: "Gilroy",
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20),
                            ),
                            onPressed: () {
                              if (reflag == 0) {
                                reflag = 1;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Rooms(),
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    )));

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Notify(),
            //   ),
            // );
          },
          tooltip: 'Show me the value!',
          child: Icon(
            Icons.check_sharp,
            color: Colors.deepOrange[300],
          ),
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }
}

class DisplayData extends StatefulWidget {
  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  void incrementCounter(int i) {
    setState(() {
      if (counters[i] < availability[i]) {
        counters[i] = counters[i] + 1;
      } else {
        print("max reached");
      }
    });
  }

  void decrementCounter(int i) {
    setState(() {
      if (counters[i] > 0) {
        counters[i] = counters[i] - 1;
      } else {
        print("negative not allowed");
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (var i = 0; i < numberofequipments; i++) {
      controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    CollectionReference equipments =
        FirebaseFirestore.instance.collection(sportequipmentid);

    return StreamBuilder<QuerySnapshot>(
      stream: equipments.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Padding(
              padding: EdgeInsets.only(
                top: 0.00625 * _screenHeight,
                bottom: 0.00625 * _screenHeight,
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
              ),
              child: Container(
                width: _screenWidth,
                decoration: BoxDecoration(
                  color: Colors.deepOrange[300],
                  borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 0.025 * _screenHeight,
                    bottom: 0.025 * _screenHeight,
                    left: 0.03 * _screenWidth,
                    right: 0.03 * _screenWidth,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document['name'],
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 0.04 * _screenHeight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Available: " +
                                availability[document['availabilityindex']]
                                    .toString(),
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 0.025 * _screenHeight,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              decrementCounter(document['availabilityindex']);
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          Center(
                            child: Text(
                              counters[document['availabilityindex']]
                                  .toString(),
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 0.025 * _screenHeight,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              incrementCounter(document['availabilityindex']);
                            },
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
