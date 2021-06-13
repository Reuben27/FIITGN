import './rooms.dart';
import '../data/initialize.dart';
import 'package:flutter/material.dart';
import './sports.dart';
import 'entry.dart';

// ignore: must_be_immutable
class Notify extends StatelessWidget {
  String message = status == 1 ? "Booking successful" : "Booking unsuccessful";
  //if 1 then came from room so display equipment booking
  String next = reflag == 0 ? "Rooms" : "Equipments";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allocation System'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Text(
              message,
              style: TextStyle(
                color: Colors.black, 
                fontSize: 15,
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => Sports(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                color: Colors.blue[200],
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                if(reflag == 0){
                  reflag = 1;
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => Rooms(),
                    ),
                  );
                } else{
                  reflag = 0;
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => Entry(),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                color: Colors.blue[200],
                child: Text(
                  'Book ' + next + ' as well!',
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
