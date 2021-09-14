import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/shared/colors.dart';

class DetailsScreen extends StatelessWidget {
  final item;
  final width;
  final height;
  const DetailsScreen({Key key, this.item, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(capitalize(item.tatarWord),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.05),
                  Text(item.definition, style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.center),
                  SizedBox(height: height * 0.01),
                  Expanded(child:Align( alignment: Alignment.topCenter, child: Image.network(item.imageUrl,
                      fit: BoxFit.contain)),
                  )])));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
