import './equipments.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import '../data/initialize.dart';
//for rooms
import '../utils/roomchecker.dart';
import '../utils/roomupdater.dart';
import './notify.dart';

//for equipments
import '../utils/getavailability.dart';

class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  String _setTime, _setDate;
  String _hourEntry,
      _minuteEntry,
      _timeEntry,
      _hourExit,
      _minuteExit,
      _timeExit;
  String dateTime;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeControllerEntry = TextEditingController();
  TextEditingController _timeControllerExit = TextEditingController();

  String submitbuttontext = reflag == 1 ? "Book" : "Next";

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMMMMd('en_US').format(selectedDate);
      });
  }

  Future<Null> _selectTimeEntry(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hourEntry = selectedTime.hour.toString();
        _minuteEntry = selectedTime.minute.toString();
        _timeEntry = _hourEntry + ' : ' + _minuteEntry;
        _timeControllerEntry.text = _timeEntry;
        _timeControllerEntry.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  Future<Null> _selectTimeExit(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hourExit = selectedTime.hour.toString();
        _minuteExit = selectedTime.minute.toString();
        _timeExit = _hourExit + ' : ' + _minuteExit;
        _timeControllerExit.text = _timeExit;
        _timeControllerExit.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMMd('en_US').format(DateTime.now());

    _timeControllerEntry.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();

    _timeControllerExit.text = formatDate(
        DateTime(
            2019,
            08,
            1,
            DateTime.now().add(const Duration(minutes: 30)).hour,
            DateTime.now().add(const Duration(minutes: 30)).minute),
        [hh, ':', nn, " ", am]).toString();

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _dateController.dispose();
    _timeControllerEntry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allocation System'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[500],
                fontSize: 20,
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Choose Date',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 10,
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: TextFormField(
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: _dateController,
                        onSaved: (String val) {
                          _setDate = val;
                        },
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            // labelText: 'Time',
                            contentPadding: EdgeInsets.only(top: 0.0)),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Choose Entry Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTimeEntry(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 10,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeControllerEntry,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Choose Exit Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTimeExit(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 10,
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeControllerExit,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          starttime = DateFormat('yyyy-MM-dd').format(selectedDate);
          endtime = DateFormat('yyyy-MM-dd').format(selectedDate);

          //change the input to the required format.
          if (int.parse(_hourEntry) < 10) {
            starttime = starttime + " 0" + _hourEntry;
          } else {
            starttime = starttime + " " + _hourEntry;
          }

          if (int.parse(_minuteEntry) < 10) {
            starttime = starttime + ":0" + _minuteEntry + ":" + "00.000";
          } else {
            starttime = starttime + ":" + _minuteEntry + ":" + "00.000";
          }

          if (int.parse(_hourExit) < 10) {
            endtime = endtime + " 0" + _hourExit;
          } else {
            endtime = endtime + " " + _hourExit;
          }

          if (int.parse(_minuteExit) < 10) {
            endtime = endtime + ":0" + _minuteExit + ":" + "00.000";
          } else {
            endtime = endtime + ":" + _minuteExit + ":" + "00.000";
          }

          print("Exit Time  " + endtime);
          print("Entry Time " + starttime);

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
          submitbuttontext,
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