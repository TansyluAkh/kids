import 'dart:async';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Hero(
            tag: 'home_logo',
            child: Image(
              image: NetworkImage('https://s6.gifyu.com/images/bklogo.png'),
              height: 175.0,
            ),
          ),
          // SizedBox(
          //   height: 10.0,
          // ),
          // TyperAnimatedTextKit(
          //     text: [
          //       'Made by Tansylu',
          //     ],
          //     speed: Duration(milliseconds: 150),
          //     isRepeatingAnimation: false,
          //     textAlign: TextAlign.center,
          //     textStyle: TextStyle(
          //         fontSize: 25.0,
          //         fontFamily: "Pacifico",
          //         color: Colors.white70),
          //     alignment: AlignmentDirectional.topStart),
        ],
      ),
    );
  }
}
