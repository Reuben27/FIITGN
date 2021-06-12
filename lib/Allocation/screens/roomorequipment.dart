import 'package:flutter/material.dart';
import './rooms.dart';
import '../data/initialize.dart';
import './entry.dart';

class RoomOrEquipment extends StatefulWidget {
  @override
  _RoomOrEquipmentState createState() => _RoomOrEquipmentState();
}

class _RoomOrEquipmentState extends State<RoomOrEquipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Allocation System'),
          centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                reflag = 1;
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => Rooms(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                color: Colors.blue[200],
                child: ListTile(
                  title: new Text(
                    'Rooms', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                      ),
                    ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                reflag = 0;
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => Entry(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                color: Colors.blue[200],
                child: ListTile(
                  title: new Text(
                    'Equipments', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold
                      ),
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