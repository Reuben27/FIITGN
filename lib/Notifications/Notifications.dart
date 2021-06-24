import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import './LocalNotifications.dart';
import '../main.dart';
import 'utils/addNotification.dart';
import 'utils/removeNotification.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Notifications extends StatefulWidget {
  static const routeName = '\Notifications';

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String dateTime;
  String _hourEntry, _minuteEntry, _timeEntry;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initializeSetting(context);
    tz.initializeTimeZones();
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message.data != null) {
        final routeName = message.data["route"];
        print(routeName);
        // Navigator.of(context).pushNamed(routeName);
      }
    });

    //When Open.
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.title);
        print(message.notification.body);
      }
      LocalNotificationService.display(message);
    });

    //When in bg but not killed
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeName = message.data["route"];
      print(routeName);
      // Navigator.of(context).pushNamed(routeName);
    });
  }

  Future<Null> _selectTime(BuildContext context) async {
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
        _timeController.text = _timeEntry;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
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
                  'Choose Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
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
                      controller: _timeController,
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
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () async {
                print("Daily Notification 1");
                print(selectedTime.hour);
                print(selectedTime.minute);
                notiAdd(token, selectedTime.hour, selectedTime.minute, 5);
                showAlertDialog(context, selectedTime);
              },
              child: Text(
                'Daily Notification 1',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () async {
                print("Daily Notification 2");
                print(selectedTime.hour);
                print(selectedTime.minute);
                notiAdd(token, selectedTime.hour, selectedTime.minute, 6);
                showAlertDialog(context, selectedTime);
              },
              child: Text(
                'Daily Notification 2',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () async {
                notiRemove(token, 5);
              },
              child: Text(
                'Remove Notification',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, TimeOfDay selectedTime) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text(
          "Your Notification is set for ${selectedTime.hour} : ${selectedTime.minute}"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
