import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_screen.dart';
import 'package:bebkeler/ui/screens/spelling_bee/home.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

Widget sliderbtn( label, icon, action, width, context, element, items){
  return SliderButton(
      action: action == 'playquiz' ? (){
      print('tappedplay');
      Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => QuizScreen(
              quiz: Quiz.fromSubcategory(
                  element.subCategory,
                  element.collectionPath,
                  element.tatarCategory,
                  items))),
  );
} : (){Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) => SBHomePage()));},
      label: Text(
      label,
      style: TextStyle(
      color: AppColors.darkBlue,
      fontSize: 18),
      ),
      icon: Center(
      child: Icon(
      icon,
      color: Colors.white,
      size: 35.0,
      )),
      boxShadow: BoxShadow(
      color: AppColors.darkBlue,
      blurRadius: 4,
      ),
      width: width*0.55,
      dismissible: false,
      shimmer: false,
      radius: 70,
      buttonColor: AppColors.darkBlue,
      backgroundColor: AppColors.white,
      highlightedColor: AppColors.darkBlue,
      baseColor:AppColors.darkBlue,
      );}

