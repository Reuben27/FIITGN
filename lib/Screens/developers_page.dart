import 'package:flutter/material.dart';

class Developer extends StatelessWidget {
  static const routeName = '\DeveloperPage';
  const Developer({Key key}) : super(key: key);

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
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'DEVELOPERS',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
                top: 0.01 * _screenHeight,
                bottom: 0.01 * _screenHeight,
              ),
              height: 0.2 * _screenHeight,
              width: _screenWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(
                    0.03 * _screenHeight,
                  ),
                ),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: 0.18 * _screenHeight,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(0.03 * _screenHeight),
                          child: Image.asset(
                            'assets/gottam.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0.025 * _screenWidth,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GAUTAM VASHISHTHA",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 0.03 * _screenHeight),
                          ),
                          Text(
                            "gautam.pv@iitgn.ac.in",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.03 * _screenHeight),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
                top: 0.01 * _screenHeight,
                bottom: 0.01 * _screenHeight,
              ),
              height: 0.2 * _screenHeight,
              width: _screenWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(
                    0.03 * _screenHeight,
                  ),
                ),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: 0.18 * _screenHeight,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(0.03 * _screenHeight),
                          child: Image.asset(
                            'assets/rooben.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0.025 * _screenWidth,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "REUBEN DEVANESAN",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 0.03 * _screenHeight),
                          ),
                          Text(
                            "reuben.sd@iitgn.ac.in",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.03 * _screenHeight),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
                top: 0.01 * _screenHeight,
                bottom: 0.01 * _screenHeight,
              ),
              height: 0.2 * _screenHeight,
              width: _screenWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(
                    0.03 * _screenHeight,
                  ),
                ),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: 0.18 * _screenHeight,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(0.03 * _screenHeight),
                          child: Image.asset(
                            'assets/aditya.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0.025 * _screenWidth,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ADITYA SHEKHAR",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 0.03 * _screenHeight),
                          ),
                          Text(
                            "aditya.ss@iitgn.ac.in",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.03 * _screenHeight),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
                top: 0.01 * _screenHeight,
                bottom: 0.01 * _screenHeight,
              ),
              height: 0.2 * _screenHeight,
              width: _screenWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(
                    0.03 * _screenHeight,
                  ),
                ),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: 0.18 * _screenHeight,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(0.03 * _screenHeight),
                          child: Image.asset(
                            'assets/reesab.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0.025 * _screenWidth,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "RISHABH GUPTA",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 0.03 * _screenHeight),
                          ),
                          Text(
                            "rishabh.g@iitgn.ac.in",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.03 * _screenHeight),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
                top: 0.01 * _screenHeight,
                bottom: 0.01 * _screenHeight,
              ),
              height: 0.2 * _screenHeight,
              width: _screenWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(
                    0.03 * _screenHeight,
                  ),
                ),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        height: 0.18 * _screenHeight,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(0.03 * _screenHeight),
                          child: Image.asset(
                            'assets/geddam.jpeg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0.025 * _screenWidth,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ABHIRAM GEDDAM",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 0.03 * _screenHeight),
                          ),
                          Text(
                            "gsv.abhiram@iitgn.ac.in",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 0.03 * _screenHeight),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
