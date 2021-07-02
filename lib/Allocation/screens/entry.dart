import 'package:fiitgn/Allocation/screens/rooms.dart';
import 'package:fiitgn/Allocation/screens/sports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import '../data/initialize.dart';

//for rooms
import '../utils/roomchecker.dart';
import '../utils/roomupdater.dart';

//for equipments
import '../utils/getavailability.dart';
import './equipments.dart';

class Entry extends StatefulWidget {
  const Entry({Key key}) : super(key: key);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  String next = reflag == 0 ? "Room" : "Equipment";
  List<String> timeofDay = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23"
  ];
  List<Color> colorList = [];
  Map<int, List<Color>> colorMap = {};

  int numberofslotschoosen = 0;
  int chosendayindex = -1;
  int chosentimeindex = -1;

  void createColorMap() {
    //create colorList
    for (int i = 0; i < 24; i++) {
      colorList.add(Colors.grey[300]);
    }

    for (int i = 0; i < 7; i++) {
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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange[300],
          title: Text(
            "CHOOSE SLOT",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size(_screenWidth, 0.22 * _screenHeight),
            child: Column(
              children: [
                Container(
                  height: 0.15 * _screenHeight,
                  child: CupertinoDatePicker(
                    minimumDate: DateTime.now(),
                    maximumDate: DateTime.now().add(Duration(days: 7)),
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDateTime) {
                      // Do something
                    },
                  ),
                ),
                Container(
                  height: 0.07 * _screenHeight,
                  child: Center(
                    child: Container(
                      height: 0.05 * _screenHeight,
                      width: 0.3 * _screenWidth,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Okay",
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 0.025 * _screenHeight,
                                  color: Colors.black),
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // OLD BODY IS HERE TO SEARCH FOR RELEVANT CODE
        // body: ListView.separated(
        //   separatorBuilder: (context, dayindex) => Divider(),
        //   itemCount: 7,
        //   itemBuilder: (context, dayindex) => Container(
        //     margin: EdgeInsets.only(
        //         right: 10,
        //         left: 10,
        //         top: MediaQuery.of(context).size.height / 40,
        //         bottom: MediaQuery.of(context).size.height / 40),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               DateFormat.MMMMEEEEd()
        //                   .format(
        //                     DateTime.now().add(
        //                       Duration(days: dayindex),
        //                     ),
        //                   )
        //                   .toUpperCase(),
        //               style: TextStyle(
        //                 fontFamily: 'Gilroy',
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 30,
        //               ),
        //             ),
        //             Row(
        //               children: [
        //                 Text(
        //                   "Swipe",
        //                   style: TextStyle(
        //                     fontStyle: FontStyle.italic,
        //                     fontFamily: 'Gilroy',
        //                   ),
        //                 ),
        //                 Icon(
        //                   Icons.arrow_forward_ios,
        //                   color: Colors.deepOrange[300],
        //                 ),
        //               ],
        //             )
        //           ],
        //         ),
        //         SizedBox(
        //           height: MediaQuery.of(context).size.height / 80,
        //         ),
        //         Container(
        //           child: ListView.separated(
        //             separatorBuilder: (context, timeindex) => SizedBox(
        //               width: MediaQuery.of(context).size.width / 20,
        //             ),
        //             itemCount: timeofDay.length,
        //             itemBuilder: (context, timeindex) => Padding(
        //               padding: const EdgeInsets.all(2.0),
        //               child: GestureDetector(
        //                 onTap: () {
        //                   if (numberofslotschoosen == 0) {
        //                     if (colorMap[dayindex][timeindex] ==
        //                         Colors.grey[300]) {
        //                       print(dayindex);
        //                       print("Hey");
        //                       setState(() {
        //                         print(dayindex);
        //                         print(colorMap[dayindex][timeindex]);
        //                         colorMap[dayindex][timeindex] = Colors.green;
        //                         chosendayindex = dayindex;
        //                         chosentimeindex = timeindex;
        //                         print(colorMap);
        //                       });
        //                       numberofslotschoosen += 1;
        //                     }
        //                   } else {
        //                     if (colorMap[dayindex][timeindex] ==
        //                         Colors.grey[300]) {
        //                       print("Cannot chose more than one time slot");
        //                     } else {
        //                       setState(() {
        //                         colorMap[dayindex][timeindex] =
        //                             Colors.grey[300];
        //                         chosendayindex = -1;
        //                         chosentimeindex = -1;
        //                       });
        //                       numberofslotschoosen -= 1;
        //                     }
        //                   }
        //                 },
        //                 child: Container(
        //                   child: Center(
        //                     child: Text(
        //                       timeofDay[timeindex] + ":00",
        //                       style: TextStyle(
        //                         fontFamily: 'Gilroy',
        //                         fontSize: 30,
        //                       ),
        //                     ),
        //                   ),
        //                   decoration: BoxDecoration(
        //                     boxShadow: [
        //                       BoxShadow(
        //                         color: Colors.green[300],
        //                         offset: Offset(
        //                           2.0, // Move to right 10  horizontally
        //                           2.0, // Move to bottom 10 Vertically
        //                         ),
        //                       )
        //                     ],
        //                     //   border: Border.all(color: Colors.green[300],width: 3),
        //                     color: colorMap[dayindex][timeindex],
        //                     borderRadius: BorderRadius.all(
        //                       Radius.circular(15),
        //                     ),
        //                   ),
        //                   width: MediaQuery.of(context).size.width / 3.5,
        //                 ),
        //               ),
        //             ),
        //             scrollDirection: Axis.horizontal,
        //           ),
        //           height: MediaQuery.of(context).size.height / 10,
        //           width: MediaQuery.of(context).size.width,
        //           //color: Colors.blueGrey,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: Container(margin: EdgeInsets.only(left: 0.02 * _screenWidth,right: 0.02 * _screenWidth,top: 0.02*_screenHeight, ),
                  child: GridView.builder(  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: _screenHeight/_screenWidth,
              crossAxisSpacing: 0.01*_screenHeight,
              mainAxisSpacing: 0.03 * _screenWidth
              //  mainAxisSpacing: MediaQuery.of(context).size.width / 30,
            ),
                   
                    itemCount: timeofDay.length,
                    itemBuilder: (context, timeindex) =>  GestureDetector(
                        onTap: () {
                          // if (numberofslotschoosen == 0) {
                          //   if (colorMap[dayindex][timeindex] ==
                          //       Colors.grey[300]) {
                          //     print(dayindex);
                          //     print("Hey");
                          //     setState(() {
                          //       print(dayindex);
                          //       print(colorMap[dayindex][timeindex]);
                          //       colorMap[dayindex][timeindex] = Colors.green;
                          //       chosendayindex = dayindex;
                          //       chosentimeindex = timeindex;
                          //       print(colorMap);
                          //     });
                          //     numberofslotschoosen += 1;
                          //   }
                          // } else {
                          //   if (colorMap[dayindex][timeindex] ==
                          //       Colors.grey[300]) {
                          //     print("Cannot chose more than one time slot");
                          //   } else {
                          //     setState(() {
                          //       colorMap[dayindex][timeindex] =
                          //           Colors.grey[300];
                          //       chosendayindex = -1;
                          //       chosentimeindex = -1;
                          //     });
                          //     numberofslotschoosen -= 1;
                          //   }
                          // }
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              timeofDay[timeindex] + ":00",
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.045 * _screenHeight,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                            
                            
                            //   border: Border.all(color: Colors.green[300],width: 3),
                           // color: colorMap[dayindex][timeindex],
                           color:Colors.grey[300],
                           
                            
                          ),
                       
                        ),
                      ),
                    
               
                  ),
                
                  //color: Colors.blueGrey,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange[300],
          onPressed: () async {
            print(chosendayindex);
            print(chosentimeindex);
            //edge case
            if (chosentimeindex == 23) {
              DateTime starting =
                  DateTime.now().add(Duration(days: chosendayindex));
              DateTime ending =
                  DateTime.now().add(Duration(days: (chosendayindex + 1)));
              starttime = DateFormat('yyyy-MM-dd').format(starting).trim();
              endtime = DateFormat('yyyy-MM-dd').format(ending).trim();
              starttime =
                  starttime + " " + timeofDay[chosentimeindex] + ":00:00.000";
              endtime = endtime + " " + timeofDay[0] + ":00:00.000";
              starttime = starttime.trim();
              endtime = endtime.trim();
              print(starttime);
              print(endtime);
            } else {
              DateTime starting =
                  DateTime.now().add(Duration(days: chosendayindex));
              DateTime ending =
                  DateTime.now().add(Duration(days: chosendayindex));
              starttime = DateFormat('yyyy-MM-dd').format(starting).trim();
              endtime = DateFormat('yyyy-MM-dd').format(ending).trim();
              starttime =
                  starttime + " " + timeofDay[chosentimeindex] + ":00:00.000";
              endtime =
                  endtime + " " + timeofDay[chosentimeindex + 1] + ":00:00.000";
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
              return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          Text(
                            "Booking Successful",
                            style: TextStyle(fontFamily: "Gilroy"),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.green[300],
                          ),
                        ],
                      ),
                      content: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        child: Column(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.deepOrange[300]),
                              ),
                              child: Text(
                                "Home",
                                style: TextStyle(
                                    fontFamily: "Gilroy",
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Sports(),
                                  ),
                                );
                              },
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.deepOrange[300],
                                ),
                              ),
                              child: Text(
                                'Book ' + next,
                                style: TextStyle(
                                    fontFamily: "Gilroy",
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              onPressed: () {
                                if (reflag == 0) {
                                  reflag = 1;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Rooms(),
                                    ),
                                  );
                                } else {
                                  reflag = 0;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Entry(),
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      )));

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Notify(),
              //   ),
              // );
            } else {
              print(sportequipmentid);
              int go = await getName(sportequipmentid);
              if (go == 1) {
                //int makecontroller = await makeTextControllers();
                int makecounter = await makeCounters();
                //go to getavailability.
                availability = await checkavailability(starttime, endtime);
                print(availability);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Equipments(),
                  ),
                );
              }
            }
          },
          tooltip: 'Show me the value!',
          child: Icon(
            reflag == 0 ? Icons.arrow_forward : Icons.save,
          ),
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

//Function to make the list of counters for the equiments.dart
Future<int> makeCounters() async {
  counters = [];

  print(numberofequipments);
  for (var i = 0; i < numberofequipments; i++) {
    counters.add(0);
  }

  return 1;
}
