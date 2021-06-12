import 'dart:io';
import 'package:googleapis/calendar/v3.dart';
import 'package:http/io_client.dart';
import 'package:http/src/base_request.dart';
import 'package:http/src/response.dart';
import 'package:connectivity/connectivity.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import '../Screens/GAuth.dart';

class CalendarSchedule {
  //------------------------------------CALENDAR EVENTS--------------------------------------------//
  // var events;
  Future reloadEvents() async {
    print("code came in the function reload events");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      // final GoogleSignIn googleSignInObject = SignInClass.googleSignIn;
      // FirebaseUser fireBaseUser;
      try {
        final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
        final authHeaders = SignInClass.authHeaders;
        print(authHeaders);

        final httpClient = GoogleHttpClient(authHeaders);
        print(httpClient);
        print("rishabh");
        await createEventAndReminders(httpClient);
        //  // googleSignInObject.signInSilently().then((value) async {
        //   if (googleSignInObject == null) {
        //     print("null check");
        //   }
        //   final authHeaders = SignInClass.authHeaders;
        //   print(authHeaders);

        //   final httpClient = GoogleHttpClient(authHeaders);
        //   print(httpClient);
        //   print("rishabh");
        //   await createEventAndReminders(httpClient);
        // });
      } catch (e) {
        print(e);
      }
    }
  }

  Future createAndGetCalendarEvents(GoogleHttpClient httpClient) async {
    print("aditya");
    var eventsData =
        await calendar.CalendarApi(httpClient).events.list('primary');
    // await calendar.CalendarApi(httpClient).events
    calendar.Event event = calendar.Event();
    eventsData.items.forEach((element) {
      print(element.recurringEventId);
    });
    // print(eventsData.toString());
    print("Checking if the code works");
  }

  Future createEventAndReminders(GoogleHttpClient httpClient) async {
    print("aditya");
    var calendarEvent = calendar.CalendarApi(httpClient).events;
    await calendar.CalendarApi(httpClient)
        .calendarList
        .get("primary")
        .then((value) {
      print(value.accessRole);
      print("3333333333333333333333333333333333");
    });
    // print("Aditya2");
    Event event = Event();
    event.summary = "workout Name"; // this would have the title
    // print("Aditya3");
    event.description = "Six packs ban jaaenge";
    // print("Aditya4");
    EventDateTime start = new EventDateTime();
    // print("Aditya5");
    start.dateTime = DateTime.parse("2021-05-18 23:20:00.000");
    start.timeZone = "GMT+05:30";
    event.start = start;
    // print("Aditya6");

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+05:30";
    end.dateTime = DateTime.parse("2021-05-22 23:25:00.000"); // change this
    event.end = end;
    event.endTimeUnspecified = true;
    print("Aditya2");

    // setting the reminder
    EventReminder reminder = EventReminder();
    print("Aditya3");
    reminder.method = 'popup';
    print("Aditya4");
    reminder.minutes = 1; // 1 minute before the event
    print("Aditya5");
    if (reminder == null) {
      print("null reminder");
    }

    // event.reminders.useDefault = true;
    print("Aditya6");
    event.recurrence = ["RRULE:FREQ=DAILY"];
    print("Aditya7");
    event.recurringEventId = "1234";
    print("Aditya8");
    String calendarId = "primary";
    // calendar.CalendarList.get();
    try {
      await calendarEvent.insert(event, calendarId).then((value) {
        print("Event Status -> " + value.status);
        if (value.status == "confirmed") {
          print('Event added to Google Calendar');
        } else {
          print("Unable to add event to Google Calendar");
        }
      });

      // await calendar.events
      //     .insert(event, calendarId,
      //         conferenceDataVersion: hasConferenceSupport ? 1 : 0,
      //         sendUpdates: shouldNotifyAttendees ? "all" : "none")
      //     .then((value) {
      //   print("Event Status: ${value.status}");
      //   if (value.status == "confirmed") {
      //     print('Event added to Google Calendar');
      //   } else {
      //     print("Unable to add event to Google Calendar");
      //   }
      // });
    } catch (e) {
      print('Error creating event $e');
    }
  }

  Future getEventsOnline(httpClient) async {
    var eventData =
        await calendar.CalendarApi(httpClient).events.list('primary');
    List<calendar.Event> tempEvents = [];
    tempEvents.addAll(eventData.items);
    makeListWithoutRepetitionEvent(tempEvents);
  }

  void makeListWithoutRepetitionEvent(List<calendar.Event> tempEvents) {
    List<calendar.Event> withoutRepeat = [];

    tempEvents.forEach((calendar.Event event) {
      bool notHave = true;
      withoutRepeat.forEach((calendar.Event _event) {
        if (_event.id == event.id) {
          notHave = false;
        }
      });
      if (notHave &&
          event != null &&
          event.start != null &&
          event.start.dateTime != null &&
          event.start.dateTime.year == DateTime.now().year &&
          event.start.dateTime.month == DateTime.now().month &&
          event.start.dateTime.day == DateTime.now().day) {
        withoutRepeat.add(event);
      }
    });

    // for (int i = 1; i < 8; i++) {
    //   events[i] = [];
    // }

    withoutRepeat.forEach((calendar.Event event) {
      if (event != null) {
        // events[DateTime.now().weekday].add(Event(
        //     startTime: (event.start != null && event.start.dateTime != null)
        //         ? event.start.dateTime.toLocal()
        //         : DateTime(2021, 1, 1, 1),
        //     endTime: (event.end != null && event.end.dateTime != null)
        //         ? event.end.dateTime.toLocal()
        //         : DateTime(2021, 1, 1, 2),
        //     name: (event.description != null) ? event.description : "",
        //     host: (event.creator != null && event.creator.displayName != null)
        //         ? event.creator.displayName
        //         : "",
        //     link: (event.htmlLink != null)
        //         ? event.htmlLink
        //         : "" //TODO: Have to check how to obtain link from calendar.event object
        //     ));
      }
    });
  }
}

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}
