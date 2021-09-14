import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameModeCard extends StatelessWidget {
  final title;
  final description;
  final icon;
  final onTap;
  final name;
  GameModeCard({this.title, this.name, this.description, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
          width: height*0.2,
          height: height*0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.element, width: 5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                 Expanded(child:Image.network(
                    icon,
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                      return Text('нет');
                    },
                  )),
                      Text(
                        capitalize(title),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.0, color: AppColors.darkBlue),
                      ),
                    ],
                  ),
                )));

  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
