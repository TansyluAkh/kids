import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  final String title;
  final int questionCount;
  final int correctAnswersCount;

  const QuizResultScreen({
    Key key,
    this.title,
    this.questionCount,
    this.correctAnswersCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.defaultPadding),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Text(
                  "Поздравляем!",
                  style: TextStyle(
                      color: AppColors.indigo, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Вы прошли квиз '$title'",
                  style: TextStyle(
                      color: AppColors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Количество набранных баллов:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$correctAnswersCount из $questionCount",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.indigo, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Вернуться назад",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.white,
                        ))),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
