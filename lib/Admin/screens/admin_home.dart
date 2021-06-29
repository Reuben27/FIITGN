import 'package:fiitgn/Admin/screens/rooms_or_equipments.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '\admin_home';
  const AdminHome({ Key key }) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text(
          'ADMIN SECTION',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Gilroy'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: (){
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder : (context) => RoomorEquipments(),
                  ),
                );                
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)
                  ),
                ),
                child: Text('Bookings',
                  style: TextStyle(fontFamily: "Gilroy", fontSize: 35),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: (){
                //Whatever you wanna do               
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)
                  ),
                ),
                child: Text('User Statistics',
                  style: TextStyle(fontFamily: "Gilroy", fontSize: 35),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),      
    );
  }
}