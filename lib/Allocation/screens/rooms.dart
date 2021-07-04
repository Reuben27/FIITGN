import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/initialize.dart';
import 'roomentry.dart';

class Rooms extends StatefulWidget {
  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
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
          backgroundColor: Colors.deepOrange[300],
          title: Text(
            'SPORT',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
          centerTitle: true,
        ),
        body: DisplayData(),
      ),
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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    CollectionReference rooms = FirebaseFirestore.instance.collection(sportroomid);

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

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return GestureDetector(
              onTap: () {
                selectedroomid = document.id;
                selectedroomname = document['roomname'];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomEntry(),
                  ),
                );
              },
              child: Padding(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          document['roomname'],
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 0.04 * _screenHeight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
