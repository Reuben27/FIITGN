import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/initialize.dart';
//for rooms
import '../utils/roomchecker.dart';
import '../utils/roomupdater.dart';
import './notify.dart';

//for equipments
import '../utils/getavailability.dart';
import './equipments.dart';

class Entry extends StatefulWidget {
  const Entry({Key key}) : super(key: key);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  List<String> timeofDay = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];
  List<Color> colorList = [];
  Map<int, List<Color>> colorMap = {};

  int numberofslotschoosen = 0;
  int chosendayindex = -1;
  int chosentimeindex = -1;

  void createColorMap(){
    //create colorList
    for(int i = 0; i < 24; i++){
      colorList.add(Colors.grey[300]);
    }

    for(int i = 0; i < 7; i++){     
     List<Color> temp = [...colorList];
     // ignore: unnecessary_cast
     colorMap[i] = temp as List<Color>; //required cast
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    createColorMap();
    super.initState();
  }
 
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
          itemBuilder: (context, dayindex) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 50,
                  ),
                  Text(
                    DateFormat.MMMMEEEEd().format(
                      DateTime.now().add(
                        Duration(days: dayindex),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              Container(
                child: ListView.builder(
                  itemCount: timeofDay.length,
                  itemBuilder: (context, timeindex) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: (){
                        if(numberofslotschoosen == 0){
                          if (colorMap[dayindex][timeindex] == Colors.grey[300]) {
                            print(dayindex);
                            print("Hey");
                            setState(() {
                              print(dayindex);
                              print(colorMap[dayindex][timeindex]);
                              colorMap[dayindex][timeindex] = Colors.green;
                              chosendayindex = dayindex;
                              chosentimeindex = timeindex;
                              print(colorMap);
                            });  
                            numberofslotschoosen += 1;                        
                          }
                        } else {
                          if (colorMap[dayindex][timeindex] == Colors.grey[300]) {
                            print("Cannot chose more than one time slot");                       
                          } else {
                            setState(() {
                              colorMap[dayindex][timeindex] = Colors.grey[300];
                              chosendayindex = -1;
                              chosentimeindex = -1;
                            });  
                            numberofslotschoosen -= 1;  
                          }
                        }
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            timeofDay[timeindex] + ":00"
                            ,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 30,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: colorMap[dayindex][timeindex],
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 3,
                      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(chosendayindex);
          print(chosentimeindex);
          //edge case
          if(chosentimeindex == 23){
            DateTime starting = DateTime.now().add(Duration(days: chosendayindex));
            DateTime ending = DateTime.now().add(Duration(days: (chosendayindex+1)));
            starttime = DateFormat('yyyy-MM-dd').format(starting).trim();
            endtime = DateFormat('yyyy-MM-dd').format(ending).trim();
            starttime = starttime + " " + timeofDay[chosentimeindex] + ":00:00.000";
            endtime = endtime + " " + timeofDay[0] + ":00:00.000";
            starttime = starttime.trim();
            endtime = endtime.trim();
            print(starttime);
            print(endtime);

          } else{
            DateTime starting = DateTime.now().add(Duration(days: chosendayindex));
            DateTime ending = DateTime.now().add(Duration(days: chosendayindex));
            starttime = DateFormat('yyyy-MM-dd').format(starting).trim();
            endtime = DateFormat('yyyy-MM-dd').format(ending).trim();
            starttime = starttime + " " + timeofDay[chosentimeindex] + ":00:00.000";
            endtime = endtime + " " + timeofDay[chosentimeindex+1] + ":00:00.000";
            starttime = starttime.trim();
            endtime = endtime.trim();
            print(starttime);
            print(endtime);
          }
          

          print(reflag);

          if (reflag == 1) {
            print(selectedroomid);
            //go to roomchecker
            int bookornot = await checker(starttime, endtime);
            if (bookornot == 1) {
              // go to room updater.
              int updatedornot = await updater(starttime, endtime);

              if (updatedornot == 1) {
                print("Room has been booked.");                
              }
            }

            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => Notify(),
              ),
            );
          } else {
            print(sportequipmentid);
            int go = await getName(sportequipmentid);
            if (go == 1)
            {
              int makecontroller = await makeTextControllers();
              //go to getavailability.
              availability = await checkavailability(starttime, endtime);
              print(availability);
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => Equipments(),
                ),
              );
            }
          }
        },
        tooltip: 'Show me the value!',
        child: Text(
          'Next',
        ),
      ),
    );
  }
}

//Function to make the list of text editing controllers for the equiments.dart
Future<int> makeTextControllers() async {
  controllers = [];

  print(numberofequipments);
  for (var i = 0; i < numberofequipments; i++) {
    controllers.add(TextEditingController());
    print("Hey 3");
  }

  return 1;
}