import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
  String token;

  @override
  void initState() {
    getToken();
    initializeSetting();
    tz.initializeTimeZones();
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
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
                print("New 2 Minute");
                print(selectedTime.hour);
                print(selectedTime.minute);
                notiupdate(token, selectedTime.hour, selectedTime.minute, 5);
                await showNewTwoMinute(selectedTime.hour, selectedTime.minute);
                showAlertDialog(context, selectedTime);
              },
              child: Text(
                'New 2 Minute',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () async {
                print("New Daily");
                print(selectedTime.hour);
                print(selectedTime.minute);
                notiupdate(token, selectedTime.hour, selectedTime.minute, 5);
                await showNewDaily(selectedTime.hour, selectedTime.minute);
                showAlertDialog(context, selectedTime);
              },
              child: Text(
                'New Daily',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () async {
                print("Old Daily");
                print(selectedTime.hour);
                print(selectedTime.minute);
                notiupdate(token, selectedTime.hour,
                    selectedTime.minute, 5);
                await showOldDaily(selectedTime.hour, selectedTime.minute);
                showAlertDialog(context, selectedTime);
              },
              child: Text(
                'Old Daily',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Center(
            heightFactor: 2,
            child: RaisedButton(
              onPressed: () {
                print("Showing Pending Notifications");
                _checkPendingNotificationRequests();
              },
              child: Text(
                'Pending Notifications',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showNewTwoMinute(hours, minute) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your new channel id',
        'your new channel name',
        'your new channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // ignore: deprecated_member_use
    await notificationsPlugin.zonedSchedule(
        0,
        'New Two Minute',
        "Hurray",
        // time,
        _nextInstance(hours, minute),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstance(hours, minute) {
    var how = DateTime.now();
    var scheduledTime = DateTime(how.year, how.month, how.day, hours, minute);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(minutes: 2));
    }
    return scheduledDate;
  }

  Future<void> showNewDaily(hours, minute) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your new channel id',
        'your new channel name',
        'your new channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // ignore: deprecated_member_use
    await notificationsPlugin.zonedSchedule(
        1,
        'New Daily',
        "Hurray",
        // time,
        _nextInstance2(hours, minute),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstance2(hours, minute) {
    var how = DateTime.now();
    var scheduledTime = DateTime(how.year, how.month, how.day, hours, minute);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> showOldDaily(hours, minute) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your new channel id',
        'your new channel name',
        'your new channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    var time = new Time(hours, minute, 0);
    // ignore: deprecated_member_use
    await notificationsPlugin.showDailyAtTime(
      2,
      'Old Daily',
      "Hurray",
      time,
      // _nextInstance(hours, minute),
      platformChannelSpecifics,
    );
  }

  Future<void> _checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await notificationsPlugin.pendingNotificationRequests();
    print(pendingNotificationRequests);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
            Text('${pendingNotificationRequests.length} pending notification '
                'requests'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  getToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  void notiupdate(String tokenid, int hour, int minute, int workoutid) async {
    CollectionReference notify =
        FirebaseFirestore.instance.collection("Notifications");
    DocumentSnapshot documentSnapshot = await notify.doc(tokenid).get();
    var timemap = {};
    var numberofnoti;
    if (documentSnapshot.exists) {
      timemap = await documentSnapshot['TimeMap'];
      print(timemap);
      numberofnoti = await documentSnapshot['numberofnoti'];
      numberofnoti += 1;
      timemap[numberofnoti.toString()] = {
        'time': {'hour': hour, 'minute': minute},
        'workoutid': workoutid,
      };
      await notify.doc(tokenid).update({
        'TimeMap': timemap,
        'numberofnoti': numberofnoti,
      });
      print("Updated");
    } else {
      notify.doc(tokenid).set({
        'TimeMap': {
          '1': {
            'time': {
              'hour': hour,
              'minute': minute,
            },
            'workoutid': workoutid,
          },
        },
        'numberofnoti': 1,
      });
      print("New doc added");
    }
  }
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

void initializeSetting() async {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await notificationsPlugin.initialize(initializationSettings);
}
