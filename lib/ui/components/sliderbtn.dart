import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_screen.dart';
import 'package:bebkeler/ui/screens/spelling_bee/game.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

Widget sliderbtn( label, icon, action, width, height, context, element, items){
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
} : (){
        var words_dict = {};
        items.forEach((e){
          words_dict[e.tatarWord] = e.tatarAudio;});
        print(words_dict);
        Navigator.of(context).push(
    MaterialPageRoute(
    builder: (text) => Spelling(items: words_dict, tatcategory: element.tatarCategory)));},
      label: Text(
      label,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      textAlign: TextAlign.center,
      style: TextStyle(
      color: AppColors.darkBlue,
      fontSize: 16),
      ),
      icon: Center(
      child: Icon(
      icon,
      color: Colors.white,
      size: height*0.055,
      )),
      boxShadow: BoxShadow(
      color: AppColors.darkBlue,
      blurRadius: 4,
      ),
    buttonSize: height*0.075,
      width: width*0.45,
    height: height*0.08,
      dismissible: false,
      shimmer: false,
      radius: 70,
      buttonColor: AppColors.darkBlue,
      backgroundColor: AppColors.white,
      highlightedColor: AppColors.darkBlue,
      baseColor:AppColors.darkBlue,
      );}

