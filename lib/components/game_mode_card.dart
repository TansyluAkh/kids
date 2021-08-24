import 'package:flutter/material.dart';

class GameModeCard extends StatelessWidget {
  final title;
  final  description;
  final  icon;
  final sub;
  final ontap;

  GameModeCard({ this.title, this.sub,  this.description,  this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.circular(100),),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 45.0,
                  backgroundColor: Colors.transparent,
                  child: Image.network(
                    icon),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black.withOpacity(0.75)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            // fontSize: 15.0,
                            color: Colors.black.withOpacity(0.75)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final  title;
  final  description;
  final icon;
  final ontap;

  HomeCard({this.title, this.description, this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: InkWell(
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.0),
              color: Colors.white),
        ),
      ),
    );
  }
}
