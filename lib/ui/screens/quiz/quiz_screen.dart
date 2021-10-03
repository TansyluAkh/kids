import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/infrastructure/mvvm/view.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_result_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'quiz_view_model.dart';
import 'option_card.dart';

class QuizScreen extends View<QuizViewModel> {
  QuizScreen({Key key, Quiz quiz}) : super(key: key, viewModel: QuizViewModel(quiz: quiz));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: AppColors.white,
      appBar: backNavbar(context),
      body:  body(context),
    );
  }

  Widget backNavbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(
          color: AppColors.orange),
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      centerTitle: true,
      title: Text((viewModel.currentQuestionIndex+1).toString()+' / '+ viewModel.quiz.questions.length.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
            fontSize: 22,
            color: AppColors.orange,
          )),
    );
  }

  Widget body(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: NetworkImage('https://urban.tatar/bebkeler/tatar/assets/terrazo.jpg'),
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.dstATop))),
        child:  Padding( padding: EdgeInsets.only(top: height*0.12, left: 10, right:10, bottom:10), child:Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '„ ' + viewModel.currentQuestion.text + ' “',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.darkBlue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container( height: height*0.25,  child: optionGrid()),
    Container( height: height*0.2, child: Image.network(viewModel.currentQuestion.image, fit: BoxFit.contain)),
        Text(
          viewModel.currentQuestion.definition,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.darkBlue, fontSize: 16, fontWeight: FontWeight.bold),
        ),

        nextButton(context, height),
        timeIndicator(),
      ],
    )));
  }

  Widget timeIndicator() {
    return AnimatedBuilder(
      animation: viewModel.animation,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              viewModel.secondsLeft.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.darkBlue, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: LinearProgressIndicator(
                backgroundColor: AppColors.element,
            value: viewModel.animation.value,
            minHeight: 5,
            color: AppColors.darkBlue,
          ))
        ],
      ),
    );
  }

  Widget nextButton(context, height) {
    if (!viewModel.isAnswered) return const SizedBox();
    Function() onTap;
    if (viewModel.isLastStep) {
      onTap = () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return QuizResultScreen(tatcategory: viewModel.quiz.tatcategory,
              result: countscore(),
             qnum: viewModel.quiz.questions.length);
        }));
      };
    } else {
      onTap = () {
        viewModel.goNext();
      };
    }
    return IconButton(
      icon: Icon(FontAwesomeIcons.arrowCircleRight),
          iconSize: height*0.07,
          color: AppColors.orange,
          onPressed: onTap,
        );
  }

  Widget optionGrid() {
    final List<Widget> optionCards = [];
    for (var i = 0; i < viewModel.currentQuestion.options.length; i++) {
      final option = viewModel.currentQuestion.options[i];
      final onTap = () => viewModel.answer(i);

      var state = OptionState.Default;
      final isSelected = viewModel.isAnswered && viewModel.currentAnswer.chosenOptionIndex == i;
      if (viewModel.isAnswered) {
        final currentOption = viewModel.currentQuestion.options[i];
        if (currentOption.isCorrect)
          state = OptionState.Correct;
        else if (isSelected)
          state = OptionState.Wrong;
        else
          state = OptionState.Disabled;
      }

      optionCards
          .add(OptionCard(option: option, state: state, isSelected: isSelected, onTap: onTap));
    }

    return GridView.count(
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        childAspectRatio: 2 / 1,
        mainAxisSpacing: 5,
        children: optionCards);
  }
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  int countscore(){
    var correctAnswers = 0;
    for (final answer in viewModel.userAnswers) {
      final userOptionIndex = answer.chosenOptionIndex;
      final correctOptionIndex =
      viewModel.quiz.questions[answer.questionIndex].options.indexWhere((opt) => opt.isCorrect);
      if (userOptionIndex == correctOptionIndex) correctAnswers++;
    }
    return correctAnswers;
  }
}
