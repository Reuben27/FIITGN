import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/initialize.dart';
import './entry.dart';

class Rooms extends StatefulWidget {
  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: Text('Allocation System'),
      //     centerTitle: true,
      // ),
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
    CollectionReference rooms =  FirebaseFirestore.instance.collection(sportroomid);

    return StreamBuilder<QuerySnapshot>(
      stream: rooms.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return new SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: 45,
              ),
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Squash",
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: "Gilroy",
                            ),
                          ),
                          Text(
                            "Select a room",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Gilroy",
                            ),
                          )
                        ]),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 6,
                        child:
                            Image.asset('assets/ico.png', fit: BoxFit.contain)),
                  ],
                ),
              ),
              Container(
                  child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return GestureDetector(
                    onTap: () {
                      selectedroomid = document.id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Entry(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          title: new Text(
                            document['roomname'],
                            style:
                                TextStyle(fontFamily: "Gilroy", fontSize: 23),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ))
            ]));
      },
    );
  }
}
