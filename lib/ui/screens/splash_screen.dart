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

    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        // ignore: prefer_const_literals_to_create_immutables
        const Center(
            child: Image(
              image: NetworkImage('https://s9.gifyu.com/images/indigo1.png'),
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
