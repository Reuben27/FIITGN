import 'package:flutter/material.dart';

class HomeScreenItem extends StatelessWidget {
  final title;
  final url;
  final routeName;
  final description;
  final heroID;

  HomeScreenItem({
    this.title,
    this.routeName,
    this.url,
    this.description,
    this.heroID,
  });
  @override
  Widget build(BuildContext context) {
    return
        //InkWell(
        //   onTap: () => {
        //     if (routeName != '')
        //       {
        //         Navigator.pushNamed(context, routeName),
        //       } //IMAGE ADD KARO WITH Image.asset url and text is the title. description bhi add karo alag se.
        //   },
        // child: Container(
        //  margin: EdgeInsets.all(10.0),
        //  width: MediaQuery.of(context).size.width,
        //    child: Stack(
        // alignment: Alignment.topCenter,
        //     children: <Widget>[

        //    decoration: BoxDecoration(
        // color: Colors.white,
        //   borderRadius: BorderRadius.circular(20.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black26,
        //     offset: Offset(0.0, 2.0),
        //     blurRadius: 6.0,
        //   ),
        // ],
        //    ),
        //   Container(
        // margin: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
        // height: MediaQuery.of(context).size.height / 5,
        // width: MediaQuery.of(context).size.width / 2,
        // color: Colors.red[400],
        Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width / 2,
              ),
              color: Colors.grey[200],
            ),
            // margin: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        // top: MediaQuery.of(context).size.height / 14,
        Positioned(
          child: InkWell(
            onTap: () => {
              if (routeName != '')
                {
                  Navigator.pushNamed(context, routeName),
                } //IMAGE ADD KARO WITH Image.asset url and text is the title. description bhi add karo alag se.
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: MediaQuery.of(context).size.width / 18.7,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    color: Colors.blueGrey[800],
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 30)),
              ),
            ),
          ),
        ),
        //    Hero(
        //    tag: url,
        Positioned(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 5.844,
              width: MediaQuery.of(context).size.width / 2.74267,
              child: ClipRRect(
                //   borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  url,
                  //  height: MediaQuery.of(context).size.height / 4.87,
                  // width: MediaQuery.of(context).size.width / 2.28,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),

        // Text(
        //   title,
        //   style: TextStyle(
        //     fontSize: MediaQuery.of(context).size.width / 18.7,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        // Text(
        //   description,
        //   style: TextStyle(color: Colors.grey),
        // )
      ],
    );
  }
}
