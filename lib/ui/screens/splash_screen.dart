import 'dart:async';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var r = 'https://urban.tatar/bebkeler/tatar/assets/green.png';
    var s = 'https://urban.tatar/bebkeler/tatar/assets/biglogo.PNG';
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: NetworkImage('https://urban.tatar/bebkeler/tatar/assets/terrazo.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.15), BlendMode.dstATop),
        ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
              Image(
              image: NetworkImage(r),
              height: height * 0.25,
              width: width*0.8,
            ),
            Image(
              image: NetworkImage(s),
              height: height * 0.35,
              width: width*0.95,
            ),
        ],
      ),
    ));
  }
}
