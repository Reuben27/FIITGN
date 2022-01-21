import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickLinks extends StatefulWidget {
  static const routeName = '\QuickLinks';
  const QuickLinks({Key key}) : super(key: key);

  @override
  _QuickLinksState createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinks> {
  openBrowserURL({String url, bool inApp = false}) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Text(
          'Quick Links',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Gilroy'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                final url = 'https://forms.gle/yYyhxgojSYhcxWij7';
                openBrowserURL(url: url, inApp: false);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  'Suggestions/Feedback',
                  style: TextStyle(fontFamily: "Gilroy", fontSize: 35),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                final url = 'https://forms.gle/oi7XDmGK8VWaHvPZ9';
                openBrowserURL(url: url, inApp: false);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  'Report a bug',
                  style: TextStyle(fontFamily: "Gilroy", fontSize: 35),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                final url = 'https://forms.gle/yi3r8PP7VNo1XvrR7';
                openBrowserURL(url: url, inApp: false);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  'Want to collaborate?',
                  style: TextStyle(fontFamily: "Gilroy", fontSize: 35),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// https://forms.gle/yYyhxgojSYhcxWij7
// https://forms.gle/oi7XDmGK8VWaHvPZ9
// https://forms.gle/yi3r8PP7VNo1XvrR7