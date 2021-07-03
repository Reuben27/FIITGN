import '../data/booking_data.dart';
import 'package:flutter/material.dart';

class RoomBookings extends StatelessWidget {
  const RoomBookings({ Key key }) : super(key: key);

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
      body: RoomBookingsData(),
    );
  }
}

class RoomBookingsData extends StatefulWidget {
  const RoomBookingsData({ Key key }) : super(key: key);

  @override
  _RoomBookingsDataState createState() => _RoomBookingsDataState();
}

class _RoomBookingsDataState extends State<RoomBookingsData> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: adminroombookingcount,
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
                  Text('Name: ${adminroomuserinfo[(adminroombookingcount - index - 1).toString()]['name']}',
                    style: TextStyle(fontFamily: "Gilroy", fontSize: 18),
                    textAlign: TextAlign.center,),
                  Text('Email: ${adminroomuserinfo[(adminroombookingcount - index - 1).toString()]['emailid']}',
                    style: TextStyle(fontFamily: "Gilroy", fontSize: 18),
                    textAlign: TextAlign.center,),
                  Text('Start Time: ${adminroombookedslots[(adminroombookingcount - index - 1).toString()][0]}',
                    style: TextStyle(fontFamily: "Gilroy", fontSize: 18),
                    textAlign: TextAlign.center,),
                  Text('End Time: ${adminroombookedslots[(adminroombookingcount - index - 1).toString()][1]}',
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