import './create_workouts1.dart';
import './wishlist.dart';
import 'package:flutter/material.dart';
import './your-workouts.dart';
import './explore_workouts.dart';
import './created_by_user.dart';
import 'ongoing_workouts.dart';
import './workouts_history.dart';

class Workouts_Home extends StatelessWidget {
  static const routeName = '\Workouts-Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height / 7),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 10,

                //   borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/4805.png',
                  //  height: MediaQuery.of(context).size.height / 4.87,
                  // width: MediaQuery.of(context).size.width / 2.28,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 25,
                width: MediaQuery.of(context).size.width / 2.4,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFF).withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width / 13.8),
                  ),
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search),
                      Text('Explore',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            fontFamily: "Gilroy",
                          ))
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Explore_Workouts.routeName);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[300],
        title: Text(
          'WORKOUTS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewPadding.top) /
                  25,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: ListView(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 6,
           
              child: Column(children: [
                Text(
                  'Your Workouts',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: "Gilroy",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 80,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Ongoing_Workouts.routeName);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/clok.png',
                                    //  height: MediaQuery.of(context).size.height / 4.87,
                                    // width: MediaQuery.of(context).size.width / 2.28,
                                    fit: BoxFit.contain,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 25,
                                  width: MediaQuery.of(context).size.width / 8,
                                ),
                                Text(
                                  "FOLLOWING NOW",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Gro",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Created_by_user.routeName);
                            // Navigator.pushNamed(context, CWScreen1.routeName);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/idea.png',
                                    //  height: MediaQuery.of(context).size.height / 4.87,
                                    // width: MediaQuery.of(context).size.width / 2.28,
                                    fit: BoxFit.contain,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  width: MediaQuery.of(context).size.width / 8,
                                ),
                                Text(
                                  "CREATED BY YOU",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Gro",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height / 80,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Wishlist.routeName);
                            // Navigator.pushNamed(context, CWScreen1.routeName);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/wiss.png',
                                    //  height: MediaQuery.of(context).size.height / 4.87,
                                    // width: MediaQuery.of(context).size.width / 2.28,
                                    fit: BoxFit.contain,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  width: MediaQuery.of(context).size.width / 8,
                                ),
                                Text(
                                  "WISHLIST",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Gro",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, WorkoutHistoryScreen.routeName);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/hiss.png',
                                    //  height: MediaQuery.of(context).size.height / 4.87,
                                    // width: MediaQuery.of(context).size.width / 2.28,
                                    fit: BoxFit.contain,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  width: MediaQuery.of(context).size.width / 8,
                                ),
                                Text(
                                  "HISTORY",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Gro",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 6,
              decoration: BoxDecoration(
                  color: Colors.yellow[200],
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 30),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        'Create Workout',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: "Gilroy",
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Create_Workout2.routeName);
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/23.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
