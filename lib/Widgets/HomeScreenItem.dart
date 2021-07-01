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
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => {
            if (routeName != '')
              {
                Navigator.pushNamed(context, routeName),
              } //IMAGE ADD KARO WITH Image.asset url and text is the title. description bhi add karo alag se.
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF94D0CC),
              borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(MediaQuery.of(context).size.width / 20.57),
                topRight:
                    Radius.circular(MediaQuery.of(context).size.width / 20.57),
              ),
            ),
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 27.5,
                right: MediaQuery.of(context).size.width / 27.5),
            //   height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              //   borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(url, fit: BoxFit.fitWidth),
            ),
          ),
        ),
        InkWell(
          onTap: () => {
            if (routeName != '')
              {
                Navigator.pushNamed(context, routeName),
              } //IMAGE ADD KARO WITH Image.asset url and text is the title. description bhi add karo alag se.
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 27.5,
                right: MediaQuery.of(context).size.width / 27.5),
            decoration: BoxDecoration(
              color: Color(0xFFEEC4C4),
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(MediaQuery.of(context).size.width / 20.57),
                bottomRight:
                    Radius.circular(MediaQuery.of(context).size.width / 20.57),
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).viewPadding.top) / 140,
                    bottom: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).viewPadding.top) / 140),
                child: Text(
                  title.toString().toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: MediaQuery.of(context).size.width / 8,
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
