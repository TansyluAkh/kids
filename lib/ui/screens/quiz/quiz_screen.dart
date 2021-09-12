import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/infrastructure/mvvm/view.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_result_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/material.dart';

import 'quiz_view_model.dart';
import 'option_card.dart';

class QuizScreen extends View<QuizViewModel> {
  QuizScreen({Key key, Quiz quiz}) : super(key: key, viewModel: QuizViewModel(quiz: quiz));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: backNavbar(context),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: body(context),
        ),
      ),
    );
  }

  Widget backNavbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.element,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  Widget body(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '„ ' + viewModel.currentQuestion.text + ' “',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(height: height * 0.25, child: optionGrid()),
        Text(
          viewModel.currentQuestion.definition,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColors.black.withOpacity(0.7), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        nextButton(context),
        timeIndicator(),
      ],
    );
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
                  color: AppColors.indigo, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: LinearProgressIndicator(
            value: viewModel.animation.value,
            minHeight: 5,
            color: AppColors.indigo,
          ))
        ],
      ),
    );
  }

  Widget nextButton(context) {
    if (!viewModel.isAnswered) return const SizedBox();

    final label = viewModel.isLastStep ? 'Тәмам' : 'Киләсе';
    Function() onTap;
    if (viewModel.isLastStep) {
      onTap = () async {
        final result = await viewModel.finish();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return QuizResultScreen(tatcategory: viewModel.quiz.tatcategory, result: result);
        }));
      };
    } else {
      onTap = () {
        viewModel.goNext();
      };
    }

    return Row(children: [
      Expanded(
          child: SizedBox(
        height: 48,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.white,
            ),
          ),
        ),
      ))
    ]);
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
        childAspectRatio: 2.5 / 1,
        mainAxisSpacing: 5,
        children: optionCards);
  }
}
