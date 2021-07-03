import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/booking_data.dart';
import 'package:flutter/material.dart';

import 'equipment_bookings.dart';

class EquipmentList extends StatelessWidget {
  const EquipmentList({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text(
          'EQUIPMENTS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Gilroy'),
        ),
        centerTitle: true,
      ),
      body: EquipmentListData(),
    );
  }
}


class EquipmentListData extends StatefulWidget {
  const EquipmentListData({ Key key }) : super(key: key);

  @override
  _EquipmentListDataState createState() => _EquipmentListDataState();
}

class _EquipmentListDataState extends State<EquipmentListData> {
  @override
  Widget build(BuildContext context) {
    CollectionReference equipment =  FirebaseFirestore.instance.collection(adminsportequipmentid);
    return StreamBuilder<QuerySnapshot>(
      stream: equipment.snapshots(),
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
                  bool next = await getEquipmentBookings(adminsportequipmentid, document.id);
                  if(next){
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => EquipmentBookings()));
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
                      title: new Text(document['name'],
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