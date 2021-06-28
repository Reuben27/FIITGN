import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiitgn/Allocation/screens/rooms.dart';
import 'package:fiitgn/Allocation/screens/sports.dart';
import 'package:fiitgn/Allocation/utils/equipmentupdater.dart';
import 'package:flutter/material.dart';
import './orderconfirmation.dart';
import '../data/initialize.dart';
import 'notify.dart';
import 'entry.dart';

// ignore: must_be_immutable
class Equipments extends StatelessWidget {
  // const Equipments({ Key? key }) : super(key: key);
  String next = reflag == 0 ? "Room" : "Equipment";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text(
          'SELECT EQUIPMENT',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
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
                                fontFamily: "Gilroy", color: Colors.black,fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Sports(),
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
                                fontFamily: "Gilroy", color: Colors.black,fontSize: 20),
                          ),
                          onPressed: () {
                            if (reflag == 0) {
                              reflag = 1;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Rooms(),
                                ),
                              );
                            } else {
                              reflag = 0;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Entry(),
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.deepOrange[300],
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 9,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: Flexible(
                              child: Text(
                                document['name'],
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 300,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Flexible(
                              child: Text(
                                "Available: " +
                                    availability[document['availabilityindex']]
                                        .toString(),
                                style: TextStyle(
                                    fontFamily: 'Gilroy', fontSize: 15),
                              ),
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
                              style:
                                  TextStyle(fontFamily: 'Gilroy', fontSize: 25),
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
