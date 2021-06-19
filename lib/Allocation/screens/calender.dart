import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  static const routeName = "CalenderScreen";
  

  const Calender({Key key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  List<String> timeofDay = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];
  List<Color> colorList = [];
  Map<int, List<Color>> colorMap = {};

  int numberofslotschoosen = 0;
  int chosendayindex = -1;
  int chosentimeindex = -1;
 
  @override
  Widget build(BuildContext context) {
    //create colorList
    for(int i = 0; i < 24; i++){
      colorList.add(Colors.grey[300]);
    }

    for(int i = 0; i < 7; i++){
     // ignore: unnecessary_cast
     colorMap[i] = colorList as List<Color>; //required cast
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "CHOOSE SLOTS",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontFamily: 'Gilroy'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            //Day 0
            Container(
              child: ListView.builder(
                itemCount: timeofDay.length,
                itemBuilder: (context, timeindex) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: (){
                      if(numberofslotschoosen == 0){
                        if (colorMap[0][timeindex] == Colors.grey[300]) {
                          setState(() {
                            print(colorMap[0][timeindex]);
                            colorMap[0][timeindex] = Colors.green;
                            chosendayindex = 0;
                            chosentimeindex = timeindex;
                            print(colorMap);
                          });  
                          numberofslotschoosen += 1;                        
                        }
                      } else {
                        if (colorMap[0][timeindex] == Colors.grey[300]) {
                          print("Cannot chose more than one time slot");    
                          numberofslotschoosen -= 1;                     
                        } else {
                          setState(() {
                            colorMap[0][timeindex] = Colors.grey[300];
                            chosendayindex = -1;
                            chosentimeindex = -1;
                          });  
                          numberofslotschoosen -= 1;  
                        }
                      }
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          timeofDay[timeindex] + ":00"
                          ,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 30,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: colorMap[0][timeindex],
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width,
            ),
            Divider(),
            //Day 1
            Container(
              child: ListView.builder(
                itemCount: timeofDay.length,
                itemBuilder: (context, timeindex) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: (){
                      if(numberofslotschoosen == 0){
                        if (colorMap[1][timeindex] == Colors.grey[300]) {
                          setState(() {
                            print(colorMap[1][timeindex]);
                            colorMap[1][timeindex] = Colors.green;
                            chosendayindex = 1;
                            chosentimeindex = timeindex;
                            print(colorMap);
                          });  
                          numberofslotschoosen += 1;                        
                        }
                      } else {
                        if (colorMap[1][timeindex] == Colors.grey[300]) {
                          print("Cannot chose more than one time slot");    
                          numberofslotschoosen -= 1;                     
                        } else {
                          setState(() {
                            colorMap[1][timeindex] = Colors.grey[300];
                            chosendayindex = -1;
                            chosentimeindex = -1;
                          });  
                          numberofslotschoosen -= 1;  
                        }
                      }
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          timeofDay[timeindex] + ":00"
                          ,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 30,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: colorMap[0][timeindex],
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
