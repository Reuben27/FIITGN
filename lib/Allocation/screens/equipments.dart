import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './orderconfirmation.dart';
import './entry.dart';
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
            int temp = int.parse(controllers[i].text);
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
    CollectionReference equipments =
        FirebaseFirestore.instance.collection(sportequipmentid);

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

        return new GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2,),
              
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.red[200],
                child: Column(
                  children: [
                    Text(
                      document['name'],
                      // " " +
                      // availability[document['availabilityindex']].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Available: " +
                          availability[document['availabilityindex']]
                              .toString(),
                    ),
                    Container(
                      width: 100,
                      //   margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                      child: TextFormField(
                        controller: controllers[document['availabilityindex']],
                        decoration: const InputDecoration(
                          hintText: 'Enter Quantity',
                        ),
                      ),
                    ),

                    // ListTile(
                    //     trailing: Container(
                    //       width: 100,
                    //       //   margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                    //       child: TextFormField(
                    //         controller: controllers[document['availabilityindex']],
                    //         decoration: const InputDecoration(
                    //           hintText: 'Enter Quantity',
                    //         ),
                    //       ),
                    //     ),
                    //     subtitle: Text("Available: " + availability[document['availabilityindex']].toString(),),
                    //     leading: Text(
                    //       document['name'],
                    //           // " " +
                    //           // availability[document['availabilityindex']].toString(),
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //        fontWeight: FontWeight.bold),
                    //     ),
                    //     // Container(
                    //     //   width: 100,
                    //     //  // margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                    //     //   color: Colors.blue[200],
                    //     //   child: ListTile(
                    //     //     title: new Text(
                    //     //       document['name'] + " " + availability[document['availabilityindex']].toString(),
                    //     //       textAlign: TextAlign.center,
                    //     //       style: TextStyle(
                    //     //         color: Colors.white,
                    //     //         fontWeight: FontWeight.bold
                    //     //       ),
                    //     //     ),
                    //     //   )
                    //     // ),
                    //   ),
                    //   Divider(),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
