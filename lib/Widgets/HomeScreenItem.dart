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
            width: MediaQuery.of(context).size.width / 1.2,
            child: ClipRRect(
              //   borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                url,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/120,),
        InkWell(
          onTap: () => {
            if (routeName != '')
              {
                Navigator.pushNamed(context, routeName),
              } //IMAGE ADD KARO WITH Image.asset url and text is the title. description bhi add karo alag se.
          },
          child: Center(
            child: Text(
              title.toString().toUpperCase(),
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: MediaQuery.of(context).size.width / 10,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
