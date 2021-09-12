import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuizResultScreen extends StatelessWidget {
  final String title;
  final String tatcategory;
  final int questionCount;
  final int correctAnswersCount;

  const QuizResultScreen({
    Key key,
    this.title,
    this.tatcategory,
    this.questionCount,
    this.correctAnswersCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var s = capitalize(tatcategory);
    return Scaffold(
      backgroundColor: AppColors.white,
      body:
        Container(
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
          padding: const EdgeInsets.all(AppSpacing.defaultPadding),
        child: Align(
          alignment: Alignment.center,
          child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text(
                    "Котлыйбыз!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AppColors.darkBlue, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                  Text(
                    "$s категориясе өчен балларыныз:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.darkBlue, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                  Text(
                    "$correctAnswersCount/$questionCount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.darkBlue, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                    Image.network('https://s9.gifyu.com/images/duckpond.jpg', fit: BoxFit.contain, width: width*0.7, height: height*0.3),
                    SizedBox(
                      height: 20,
                    ),
                  IconButton(
                    iconSize: height*0.05,
                    icon: Icon(FontAwesomeIcons.redo),
                        color: AppColors.darkBlue,
                      onPressed: () => Navigator.pop(context),
                  )
                ]),
          ),
        )));}
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
