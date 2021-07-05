import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

//data
import '../data/initialize.dart';

//home screens
import '../../Screens/HomeScreen.dart';

//for rooms
import '../utils/roomchecker.dart';
import '../utils/roomupdater.dart';
import '../utils/roomavailableslots.dart';

//for equipments
import 'equipmententry.dart';

class RoomEntry extends StatefulWidget {
  const RoomEntry({Key key}) : super(key: key);

  @override
  _RoomEntryState createState() => _RoomEntryState();
}

class _RoomEntryState extends State<RoomEntry> {
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

  int numberofslotschoosen = 0;
  int chosentimeindex = -1;
  int day = 0;
  DateTime chosendate = DateTime.now();
  bool loading = true;

  void createColorList() {
    for (int i = 0; i < 24; i++) {
      colorList.add(Colors.grey[300]);
    }
  }

  Future<void> getData() async {
    await getslots();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    createColorList();
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
            preferredSize: Size(_screenWidth, 0.24 * _screenHeight),
            child: Container(
              height: 0.24 * _screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 0.15 * _screenHeight,
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      maximumDate: DateTime.now().add(Duration(days: 7)),
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(
                          () {
                            chosendate = newDateTime;
                            DateTime from = DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day);
                            DateTime to = DateTime(chosendate.year,
                                chosendate.month, chosendate.day);
                            day = (to.difference(from).inHours / 24).round();
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0125 * _screenHeight),
                  ),
                  Text(
                    "$selectedroomname",
                    style: TextStyle(
                      fontSize: 0.03 * _screenHeight,
                      fontFamily: 'Gilroy'
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: loading ? Center(child: CircularProgressIndicator()) : Container(
          margin: EdgeInsets.only(
            left: 0.02 * _screenWidth,
            right: 0.02 * _screenWidth,
            top: 0.02 * _screenHeight,
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: _screenHeight / _screenWidth,
              crossAxisSpacing: 0.01 * _screenHeight,
              mainAxisSpacing: 0.03 * _screenWidth
            ),
            itemCount: timeofDay.length,
            itemBuilder: (context, timeindex) => GestureDetector(
              onTap: () {
                if (bookedornot[day][timeindex] == 0) {
                  if (numberofslotschoosen == 0) {
                    if (colorList[timeindex] == Colors.grey[300]) {
                      print("Hey");
                      setState(() {
                        print(colorList[timeindex]);
                        colorList[timeindex] = Colors.green;
                        chosentimeindex = timeindex;
                        print(colorList);
                      });
                      numberofslotschoosen += 1;
                    }
                  } else {
                    if (colorList[timeindex] == Colors.grey[300]) {
                      setState(() {
                        colorList[chosentimeindex] = Colors.grey[300];
                        colorList[timeindex] = Colors.green;
                        chosentimeindex = timeindex;
                        print(colorList);
                      });
                    } else {
                      setState(() {
                        colorList[timeindex] = Colors.grey[300];
                        chosentimeindex = -1;
                      });
                      numberofslotschoosen -= 1;
                    }
                  }
                } else {
                  print('Room already booked');
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          Text(
                            "Slot not available!",
                            style: TextStyle(fontFamily: "Gilroy"),
                          )
                        ],
                      ),
                    ),
                  );
                }
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
                  color: bookedornot[day][timeindex] == 0
                      ? colorList[timeindex]
                      : Colors.red,
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange[300],
          onPressed: () async {
            print(chosentimeindex);
            //edge case
            if (chosentimeindex == 23) {
              starttime = DateFormat('yyyy-MM-dd').format(chosendate).trim();
              endtime = DateFormat('yyyy-MM-dd').format(chosendate).trim();
              starttime = starttime + " " + timeofDay[chosentimeindex] + ":00:00.000";
              endtime = endtime + " " + timeofDay[0] + ":00:00.000";
              starttime = starttime.trim();
              endtime = endtime.trim();
              print(starttime);
              print(endtime);
            } else {
              starttime = DateFormat('yyyy-MM-dd').format(chosendate).trim();
              endtime = DateFormat('yyyy-MM-dd').format(chosendate).trim();
              starttime = starttime + " " + timeofDay[chosentimeindex] + ":00:00.000";
              endtime = endtime + " " + timeofDay[chosentimeindex + 1] + ":00:00.000";
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
                // go to room updater
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
                        style: TextStyle(fontFamily: "Gilroy",fontSize: 0.025 * _screenHeight),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.green[300],
                      ),
                    ],
                  ),
                  content: Container(
                   height: 0.15 * _screenHeight,
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
                               fontSize: 0.025 * _screenHeight),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
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
                            'Book Equipment',
                            style: TextStyle(
                                fontFamily: "Gilroy",
                                color: Colors.black,
                               fontSize: 0.025 * _screenHeight),
                          ),
                          onPressed: () {
                            reflag = 0;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EquipmentEntry(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                )
              );
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
