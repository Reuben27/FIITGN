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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: Scaffold(
        appBar: AppBar(
           backgroundColor: Color(0xFF93B5C6),
          title: Text(
            'QUICK LINKS',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
          //centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 0.01 * _screenHeight,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        final url = 'https://forms.gle/yYyhxgojSYhcxWij7';
                        openBrowserURL(url: url, inApp: false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF93B5C6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.02 * _screenHeight),
                            topRight: Radius.circular(0.02 * _screenHeight),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth,
                        ),
                        //   height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset('assets/suggest.png',
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = 'https://forms.gle/yYyhxgojSYhcxWij7';
                        openBrowserURL(url: url, inApp: false);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFC9CCD5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.02 * _screenHeight),
                            bottomRight: Radius.circular(0.02 * _screenHeight),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 0.0125 * _screenHeight,
                              bottom: 0.0125 * _screenHeight,
                            ),
                            child: Text(
                              'Feedback',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.07 * _screenHeight,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.01 * _screenHeight,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        final url = 'https://forms.gle/oi7XDmGK8VWaHvPZ9';
                        openBrowserURL(url: url, inApp: false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF93B5C6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.02 * _screenHeight),
                            topRight: Radius.circular(0.02 * _screenHeight),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth,
                        ),
                        //   height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset('assets/report.png',
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = 'https://forms.gle/oi7XDmGK8VWaHvPZ9';
                        openBrowserURL(url: url, inApp: false);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFC9CCD5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.02 * _screenHeight),
                            bottomRight: Radius.circular(0.02 * _screenHeight),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 0.0125 * _screenHeight,
                              bottom: 0.0125 * _screenHeight,
                            ),
                            child: Text(
                              'Report a Bug',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.07 * _screenHeight,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.01 * _screenHeight,
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        final url = 'https://forms.gle/yi3r8PP7VNo1XvrR7';
                        openBrowserURL(url: url, inApp: false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF93B5C6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.02 * _screenHeight),
                            topRight: Radius.circular(0.02 * _screenHeight),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth,
                        ),
                        //   height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset('assets/suggest.png',
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final url = 'https://forms.gle/yi3r8PP7VNo1XvrR7';
                        openBrowserURL(url: url, inApp: false);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                          left: 0.03 * _screenWidth,
                          right: 0.03 * _screenWidth,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFC9CCD5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.02 * _screenHeight),
                            bottomRight: Radius.circular(0.02 * _screenHeight),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 0.0125 * _screenHeight,
                              bottom: 0.0125 * _screenHeight,
                            ),
                            child: Text(
                              'Collaborate',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.07 * _screenHeight,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.01 * _screenHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// https://forms.gle/yYyhxgojSYhcxWij7
// https://forms.gle/oi7XDmGK8VWaHvPZ9
// https://forms.gle/yi3r8PP7VNo1XvrR7