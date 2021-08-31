import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/shared/colors.dart';

class DetailsScreen extends StatelessWidget {
  final item;

  const DetailsScreen({Key key, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return
        Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.element,
                border: Border.all(color: AppColors.element, width: 5),
                borderRadius: BorderRadius.circular(20),),
              width: width * 0.9,
              height: height * 0.7,
              child:
              Padding(
                  padding: EdgeInsets.all(15), child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  children: [
                  Text(capitalize(item.tatarWord), style: Theme
                  .of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
              SizedBox(height: height * 0.05),
              Text(item.definition, style: Theme
                  .of(context)
                  .textTheme
                  .headline6),
              SizedBox(height: height * 0.05),
              ClipPath(
                  clipper: MyCustomClipper(),
              child: Container(
                color: AppColors.white,
                  child: Image.network(item.imageUrl, fit: BoxFit.contain,
                  width: width * 0.7, height: height * 0.35)),
            ),
            ]))));
  }
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
  class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 50;

    Path path = Path()
      ..lineTo(size.width - radius, 0)
      ..arcTo(
          Rect.fromPoints(
              Offset(size.width - radius, 0), Offset(size.width, radius)),
          // Rect
          1.5 * pi, // Start engle
          0.5 * pi, // Sweep engle
          true) // direction clockwise
      ..lineTo(size.width, size.height - radius)
      ..arcTo(Rect.fromCircle(
          center: Offset(size.width - radius, size.height - radius),
          radius: radius), 0, 0.5 * pi, false)
      ..lineTo(radius, size.height)
      ..arcTo(
          Rect.fromLTRB(0, size.height - radius, radius, size.height), 0.5 * pi,
          0.5 * pi, false)
      ..lineTo(0, radius)
      ..arcTo(Rect.fromLTWH(0, 0, 70, 100), 1 * pi, 0.5 * pi, false)
      ..close();

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

