import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/booking_data.dart';
import 'package:flutter/material.dart';

import 'room_bookings.dart';

class RoomList extends StatelessWidget {
  const RoomList({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text(
          'ROOMS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Gilroy'),
        ),
        centerTitle: true,
      ),
      body: RoomListData(),
    );
  }
}


class RoomListData extends StatefulWidget {
  const RoomListData({ Key key }) : super(key: key);

  @override
  _RoomListDataState createState() => _RoomListDataState();
}

class _RoomListDataState extends State<RoomListData> {
  @override
  Widget build(BuildContext context) {
    CollectionReference rooms =  FirebaseFirestore.instance.collection(adminsportroomid);
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

        return Container(
          child: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return GestureDetector(
                onTap: () async {
                  bool next = await getRoomBookings(adminsportroomid, document.id);
                  if(next){
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => RoomBookings()));
                  } 
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.all(Radius.circular(20)
                      ),
                    ),
                    child: ListTile(
                      title: new Text(document['roomname'],
                        style: TextStyle(fontFamily: "Gilroy", fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}