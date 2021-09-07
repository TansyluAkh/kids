import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    var s = capitalize(tatcategory);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
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
                        color: AppColors.indigo, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                  Text(
                    "$s категориясе өчен балларыныз:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                  Text(
                    "$correctAnswersCount/$questionCount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.indigo, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                    Image.network('https://s9.gifyu.com/images/duckpond.jpg'),
                    SizedBox(
                      height: 20,
                    ),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.indigo.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text("Кире кайтырга",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.white,
                          ))),
                ]),
          ),
        ));}
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
