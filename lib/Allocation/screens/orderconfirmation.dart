import 'package:flutter/material.dart';
import '../data/initialize.dart';
import '../utils/equipmentupdater.dart';
import 'notify.dart';

class OrderConfirmation extends StatelessWidget {
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
            Text(starttime),
            Text(endtime),
            ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                String quantity = orders[index].toString();
                String equipname = equipmentsname[index];
                return ListTile(
                  title: new Text(
                    equipname + '   ' + quantity,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(starttime);
          print(endtime);
          print(orders);
          print(sportequipmentid);
          print(availability);
          print(equipmentsname);
          await infogetter();
          Navigator.push( context,
            MaterialPageRoute(
              builder: (context) => Notify(),
            ),
          );

          print("Data updater");
        },
        tooltip: 'Show me the value!',
        child: Text(
          'Confirm',
        ),
      ),
    );
  }
}
