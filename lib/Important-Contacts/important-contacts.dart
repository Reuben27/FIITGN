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
                  "sharma.gaurav@iitgn.ac.in",
                  style: TextStyle(color: Colors.black, fontSize: 25)
                ),
                trailing: Padding(
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
              ),
            ],
          )),
    );
  }
}