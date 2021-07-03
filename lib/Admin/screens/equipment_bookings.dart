import '../data/booking_data.dart';
import 'package:flutter/material.dart';

class EquipmentBookings extends StatelessWidget {
  const EquipmentBookings({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text(
          'BOOKINGS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Gilroy'),
        ),
        centerTitle: true,
      ),
      body: EquipmentBookingsData(),
    );
  }
}

class EquipmentBookingsData extends StatefulWidget {
  const EquipmentBookingsData({ Key key }) : super(key: key);

  @override
  _EquipmentBookingsDataState createState() => _EquipmentBookingsDataState();
}

class _EquipmentBookingsDataState extends State<EquipmentBookingsData> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: adminequipmentbookingcount,
      itemBuilder: (context, index) => Container(
        child: Column(
          children: [
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)
                ),
              ),
              child: Column(
                children: [
                  Text('Name: ${adminequipmentuserinfo[(adminequipmentbookingcount - index - 1).toString()]['name']}',
                    style: TextStyle(fontFamily: "Gilroy", fontSize: 18),
                    textAlign: TextAlign.center,),
                  Text('Email: ${adminequipmentuserinfo[(adminequipmentbookingcount - index - 1).toString()]['emailid']}',
                    style: TextStyle(fontFamily: "Gilroy", fontSize: 18),
                    textAlign: TextAlign.center,),
                  Text('Orders: ${adminequipmentbookedslots[(adminequipmentbookingcount - index - 1).toString()]['orders']}',
                    style: TextStyle(fontFamily: "Gilroy", fontSize: 18),
                    textAlign: TextAlign.center,),
                  Text('Start Time: ${adminequipmentbookedslots[(adminequipmentbookingcount - index - 1).toString()]['time']['0']}',
                    style: TextStyle(fontFamily: "Gilroy", fontSize: 18),
                    textAlign: TextAlign.center,),
                  Text('End Time: ${adminequipmentbookedslots[(adminequipmentbookingcount - index - 1).toString()]['time']['1']}',
                    style: TextStyle(fontFamily: "Gilroy", fontSize: 18),
                    textAlign: TextAlign.center,),
                ],
              ),
            ),
            SizedBox(height: 5.0),
          ],
        )
      ),
    );
  }
}