import 'package:fiitgn/Providers/DataProvider.dart';
import 'package:flutter/material.dart';

import '../utils/user_data.dart';

class Profile extends StatefulWidget {
  static const routeName = '\ProfilePage';
  const Profile({ Key key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static double height = 0;
  static double weight = 0;
  static double bmi = weight/(height*height/10000);
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
    var _screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
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
            'PROFILE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 0.04 * _screenHeight,
              fontFamily: 'Gilroy',
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(height: 0.05*_screenHeight),
            Container(
              alignment: Alignment.center,
              width: _screenWidth*0.4,
              height: _screenWidth*0.4,
              // padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage( 
                  image: NetworkImage(Data_Provider().user_display),
                  fit: BoxFit.contain,
                  scale: 1.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(Data_Provider().name.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text('Height: ' + height.toString() + ' cm',
                    style: TextStyle(
  
                      fontSize: 26,
                      color: Colors.black,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
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
                                double newheight =  double.parse(h);
                                print(newheight);
                                await editHeight(newheight, Data_Provider().uid);
                                setState(() {
                                  height = newheight;
                                  bmi = weight/(height*height/10000);
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
            SizedBox(height: 10.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text('Weight: ' + weight.toString() + ' kg',
                    style: TextStyle(
  
                      fontSize: 26,
                      color: Colors.black,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
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
                                double newweight =  double.parse(w);
                                print(newweight);
                                await editWeight(newweight, Data_Provider().uid);
                                setState(() {
                                  weight = newweight;
                                  bmi = weight/(height*height/10000);
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
            SizedBox(height: 10.0),
            Center(
              child: Text('BMI: ' + bmi.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontFamily: 'Gilroy',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}