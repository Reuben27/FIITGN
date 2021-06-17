import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  static const routeName = "CalenderScreen";
  

  const Calender({Key key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  // var today = DateTime.now();
  //var tomorrow = DateTime.now().add(Duration(days: index));
  List<String> timeofDay = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "CHOOSE SLOTS",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontFamily: 'Gilroy'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(DateFormat.MMMMEEEEd().format(DateTime.now()).toString()),
              // Text(DateTime.now().add(Duration(days: index)).toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 50,
                  ),
                  Text(
                    DateFormat.MMMMEEEEd().format(
                      DateTime.now().add(
                        Duration(days: index),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Container(
                child: ListView.builder(
                  itemCount: timeofDay.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      child: Center(
                        child: Text(
                          timeofDay[index] + ":00"
                          ,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 30,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  ),
                  scrollDirection: Axis.horizontal,
                ),
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width,
                //color: Colors.blueGrey,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
