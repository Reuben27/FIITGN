import 'package:fiitgn/Providers/DataProvider.dart';
import 'package:flutter/material.dart';

import '../utils/user_data.dart';

class Profile extends StatefulWidget {
  static const routeName = '\ProfilePage';
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static double height = 0;
  static double weight = 0;
  static double bmi = weight / (height * height / 10000);
  TextEditingController heightedit = TextEditingController();
  TextEditingController weightedit = TextEditingController();

  void initialize() async {
    List temp = await getUserData(Data_Provider().uid);
    height = temp[0];
    weight = temp[1];
    bmi = temp[2];
  }

  @override
  void initState() {
    initialize();
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
          backgroundColor: Color(0xFF93B5C6),
          title: Text(
            'PROFILE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 0.04 * _screenHeight,
              fontFamily: 'Gilroy',
            ),
          ),
         // centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 0.025 * _screenHeight,
                bottom: 0.025 * _screenHeight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 0.1 * _screenHeight,
                    width: 0.1 * _screenHeight,
                    // padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.black, width: 0.0025 * _screenHeight),
                      image: DecorationImage(
                        image: NetworkImage(Data_Provider().user_display),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        Data_Provider().name.toString(),
                        style: TextStyle(
                          fontSize: 0.04 * _screenHeight,
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 0.00625 * _screenHeight,
                bottom: 0.0125 * _screenHeight,
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
              ),
              child: Container(
                width: _screenWidth,
                decoration: BoxDecoration(
                  color: Color(0xFFC9CCD5),
                  borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                ),
                // margin: EdgeInsets.only(top:10,bottom:10,left: 10, right: 15),

                child: Padding(
                  padding: EdgeInsets.only(
                    top: 0.025 * _screenHeight,
                    bottom: 0.025 * _screenHeight,
                    left: 0.03 * _screenWidth,
                    right: 0.03 * _screenWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Height: ' + height.toString() + ' cm',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 0.04 * _screenHeight,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Height (in cm)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextFormField(
                                        controller: heightedit,
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.person),
                                          hintText: '177',
                                          labelText: 'Height',
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          String h = heightedit.text.trim();
                                          double newheight = double.parse(h);
                                          print(newheight);
                                          await editHeight(
                                              newheight, Data_Provider().uid);
                                          setState(() {
                                            height = newheight;
                                            bmi = weight /
                                                (height * height / 10000);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text('Done'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Weight: ' + weight.toString() + ' kg',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 0.04 * _screenHeight,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Weight (in kg)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextFormField(
                                        controller: weightedit,
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.person),
                                          hintText: '64',
                                          labelText: 'Weight',
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          String w = weightedit.text.trim();
                                          double newweight = double.parse(w);
                                          print(newweight);
                                          await editWeight(
                                              newweight, Data_Provider().uid);
                                          setState(() {
                                            weight = newweight;
                                            bmi = weight /
                                                (height * height / 10000);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text('Done'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0.00625 * _screenHeight,
                bottom: 0.00625 * _screenHeight,
                left: 0.03 * _screenWidth,
                right: 0.03 * _screenWidth,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.02 * _screenHeight),
                color: Color(0xFF93B5C6),
              ),
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(
                  top: 0.0125 * _screenHeight,
                  bottom: 0.0125 * _screenHeight,
                  left: 0.03 * _screenWidth,
                  right: 0.03 * _screenWidth,
                ),
                child: Column(
                  children: [
                    Text(
                      'Your BMI is',
                      style: TextStyle(
                        fontSize: 0.04 * _screenHeight,
                        color: Colors.black,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                    Center(
                      child: Text(
                        bmi.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Gilroy',
                          fontSize: 0.1 * _screenHeight,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
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
