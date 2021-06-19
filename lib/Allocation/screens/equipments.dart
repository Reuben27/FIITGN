import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './orderconfirmation.dart';
import '../data/initialize.dart';

class Equipments extends StatefulWidget {
  _EquipmentsState createState() => _EquipmentsState();
}

class _EquipmentsState extends State<Equipments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allocation System'),
        centerTitle: true,
      ),
      body: Center(
        child: DisplayData(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          orders = [];
          //make the orders list
          for (var i = 0; i < numberofequipments; i++) {
            int temp = counters[i];
            orders.add(temp);
          }
          print(orders);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderConfirmation(),
            ),
          );
        },
        tooltip: 'Show me the value!',
        child: Text(
          'Next',
        ),
      ),
    );
  }
}

class DisplayData extends StatefulWidget {
  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {

  void incrementCounter(int i){
    setState(() {
      if(counters[i] < availability[i]){
        counters[i] = counters[i] + 1;
      } else {
        print("max reached");
      }
      
    });
  }

  void decrementCounter(int i){
    setState(() {
      if(counters[i] > 0){
        counters[i] = counters[i] - 1;
      } else {
        print("negative not allowed");
      }      
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (var i = 0; i < numberofequipments; i++) {
      controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference equipments = FirebaseFirestore.instance.collection(sportequipmentid);

    return StreamBuilder<QuerySnapshot>(
      stream: equipments.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(
                    document['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(
                    "Available: " + availability[document['availabilityindex']].toString(),
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width/2,
                //   child: TextFormField(
                //     controller: controllers[document['availabilityindex']],
                //     decoration: const InputDecoration(
                //       hintText: 'Enter Quantity',
                //     ),
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: ListTile(
                    leading: IconButton(
                      onPressed: (){
                        decrementCounter(document['availabilityindex']);
                      },
                      icon: Icon(Icons.remove),
                    ),
                    title: Center(
                      child: Text(
                        counters[document['availabilityindex']].toString(),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        incrementCounter(document['availabilityindex']);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
