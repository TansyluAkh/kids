import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final String tatcategory;
  final result;
  final qnum;


  const QuizResultScreen({Key key, this.tatcategory, this.qnum, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var s = capitalize(tatcategory);
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_bg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black12, BlendMode.dstATop),
              ),
            ),
            // color: Colors.white,\child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: AppSpacing.defaultPadding, right:  AppSpacing.defaultPadding, top: 70, bottom: 20 ),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        "$s категориясе өчен нәтиҗәгез:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.orange, fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${result} / ${qnum}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.darkBlue, fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.network('https://s9.gifyu.com/images/duckpond.jpg',
                          fit: BoxFit.contain, width: width * 0.7, height: height * 0.3),
                      SizedBox(
                        height: 20,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [IconButton(
                            iconSize: height * 0.05,
                            icon: Icon(FontAwesomeIcons.home),
                            color: AppColors.darkBlue,
                            onPressed: () =>  Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage()),
                            ),
                          ),
                            SizedBox(width: width*0.1),
                            IconButton(
                              iconSize: height * 0.045,
                              icon: Icon(FontAwesomeIcons.redo),
                              color: AppColors.darkBlue,
                              onPressed: () => Navigator.pop(context),
                            ),

                          ])]),
              ),
            )));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
