import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

//data
import '../data/initialize.dart';

//for equipments
import '../utils/getavailability.dart';
import './equipments.dart';

class EquipmentEntry extends StatefulWidget {
  const EquipmentEntry({Key key}) : super(key: key);

  @override
  _EquipmentEntryState createState() => _EquipmentEntryState();
}

class _EquipmentEntryState extends State<EquipmentEntry> {
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
  DateTime chosendate = DateTime.now();

  void createColorMap() {
    //create colorList
    for (int i = 0; i < 24; i++) {
      colorList.add(Colors.grey[300]);
    }
  }

  @override
  void initState() {
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
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Color(0xFF93B5C6),
          title: Text(
            "CHOOSE SLOT (EQUIPMENTS)",
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
                  height: 0.22 * _screenHeight,
                  child: Center(
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      maximumDate: DateTime.now().add(Duration(days: 7)),
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        chosendate = newDateTime;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
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
                //  mainAxisSpacing: MediaQuery.of(context).size.width / 30,
                ),
            itemCount: timeofDay.length,
            itemBuilder: (context, timeindex) => GestureDetector(
              onTap: () {
                if (numberofslotschoosen == 0) {
                  if (colorList[timeindex] == Colors.grey[300]) {
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
                  color: colorList[timeindex],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF93B5C6),
          onPressed: () async {
            print(chosentimeindex);

            //edge case
            if (chosentimeindex == 23) {
              starttime = DateFormat('yyyy-MM-dd').format(chosendate).trim();
              endtime = DateFormat('yyyy-MM-dd').format(chosendate).trim();
              starttime =
                  starttime + " " + timeofDay[chosentimeindex] + ":00:00.000";
              endtime = endtime + " " + timeofDay[0] + ":00:00.000";
              starttime = starttime.trim();
              endtime = endtime.trim();
              print(starttime);
              print(endtime);
            } else {
              starttime = DateFormat('yyyy-MM-dd').format(chosendate).trim();
              endtime = DateFormat('yyyy-MM-dd').format(chosendate).trim();
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
            if (reflag == 0) {
              print(sportequipmentid);
              int go = await getName(sportequipmentid);
              if (go == 1) {
                int makecounter = await makeCounters();
                print(makecounter);

                //go to getavailability.
                availability = await checkavailability(starttime, endtime);
                print(availability);

                // int makesliders = await makeSliders();
                // print(makesliders);
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

//Function to make the list of value of sliders for the equiments.dart
Future<int> makeSliders() async {
  sliders = [];

  for (var i = 0; i < numberofequipments; i++) {
    sliders.add(0.0);
  }

  return 1;
}
