import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImportantContacts extends StatefulWidget {
  static const routeName = 'imp_contacts';

  @override
  _ImportantContactsState createState() => _ImportantContactsState();
}

class _ImportantContactsState extends State<ImportantContacts> {
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
            backgroundColor: Color(0xFF93B5C6),
            centerTitle: true,
            title: Text(
              'IMPORTANT CONTACTS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy',
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                title: Text(
                  "Gaurav Sharma",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                subtitle: Text(
                  "Sports Secretary",
                  style: TextStyle(color: Colors.grey[700], fontSize: 24)
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('mailto://gaurav.sharma@iitgn.ac.in');
                        },
                        child: Icon(
                          Icons.email,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('tel://8168901281');
                        },
                        child: Icon(
                          Icons.phone_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                title: Text(
                  "Dinesh Parmer",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                subtitle: Text(
                  "Senior PTI",
                  style: TextStyle(color: Colors.black, fontSize: 25)
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('mailto://dparmar@iitgn.ac.in');
                        },
                        child: Icon(
                          Icons.email,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('tel://9898754279');
                        },
                        child: Icon(
                          Icons.phone_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                title: Text(
                  "Harsh Mehta",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                subtitle: Text(
                  "Sports Management Trainee",
                  style: TextStyle(color: Colors.black, fontSize: 25)
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('mailto://harsh.m@iitgn.ac.in');
                        },
                        child: Icon(
                          Icons.email,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('tel://8160179606');
                        },
                        child: Icon(
                          Icons.phone_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                title: Text(
                  "Payal Vaniya",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                subtitle: Text(
                  "Sports Management Trainee",
                  style: TextStyle(color: Colors.black, fontSize: 25)
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('mailto://payalvaniya@iitgn.ac.in');
                        },
                        child: Icon(
                          Icons.email,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('tel://7802067849');
                        },
                        child: Icon(
                          Icons.phone_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                title: Text(
                  "Bharti Makwana",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                subtitle: Text(
                  "Sports Management Trainee",
                  style: TextStyle(color: Colors.black, fontSize: 25)
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('mailto://makwana.bharti@iitgn.ac.in');
                        },
                        child: Icon(
                          Icons.email,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('tel://6353021576');
                        },
                        child: Icon(
                          Icons.phone_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                title: Text(
                  "Rahul Gupta",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                subtitle: Text(
                  "Sports Management Trainee",
                  style: TextStyle(color: Colors.black, fontSize: 25)
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('mailto://rahul.g@iitgn.ac.in');
                        },
                        child: Icon(
                          Icons.email,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('tel://9723342580');
                        },
                        child: Icon(
                          Icons.phone_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                title: Text(
                  "Ratnesh Singh",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                subtitle: Text(
                  "Assistant PTI",
                  style: TextStyle(color: Colors.black, fontSize: 25)
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('mailto://ratnesh.singh@iitgn.ac.in');
                        },
                        child: Icon(
                          Icons.email,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('tel://9838906287');
                        },
                        child: Icon(
                          Icons.phone_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(top: 6, left: 16, bottom: 6),
                title: Text(
                  "Santhosh Joshi",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                ),
                subtitle: Text(
                  "Assistant PTI",
                  style: TextStyle(color: Colors.black, fontSize: 25)
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('mailto://santhosh.joshi@iitgn.ac.in');
                        },
                        child: Icon(
                          Icons.email,
                          size: 28,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTap: () {
                          launch('tel://7668043117');
                        },
                        child: Icon(
                          Icons.phone_outlined,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}