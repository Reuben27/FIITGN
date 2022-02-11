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
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => {
            if (routeName != '')
              {
                Navigator.pushNamed(context, routeName),
              } 
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
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              child: Image.asset(url, fit: BoxFit.fitWidth),
            ),
          ),
        ),
        InkWell(
          onTap: () => {
            if (routeName != '')
              {
                Navigator.pushNamed(context, routeName),
              } 
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
                  title.toString().toUpperCase(),
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
    );
  }
}
