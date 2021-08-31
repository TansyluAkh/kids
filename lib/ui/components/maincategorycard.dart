import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameModeCard extends StatelessWidget {
  final title;
  final  description;
  final  icon;
  final ontap;
  final name;
  GameModeCard({ this.title, this.name, this.description,  this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.element, width: 5),
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
                      icon,
                      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                        return Text('нет');
                      },
                    ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        capitalize(title),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: AppColors.darkBlue),
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
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
