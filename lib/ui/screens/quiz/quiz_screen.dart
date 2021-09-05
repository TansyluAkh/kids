import 'package:bebkeler/infrastructure/mvvm/view.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_result_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/material.dart';

import 'models.dart';
import 'quiz_view_model.dart';
import 'option_card.dart';

class QuizScreen extends View<QuizViewModel> {
  QuizScreen({Key key, Quiz quiz}) : super(key: key, viewModel: QuizViewModel(quiz: quiz));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
    return Column(
      children: [
        timeIndicator(),
        const SizedBox(
          height: 10,
        ),
        Text(
          viewModel.currentQuestion.text,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.indigo, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 24,
        ),
        Expanded(child: optionGrid()),
        nextButton(context)
      ],
    );
  }

  Widget timeIndicator() {
    return AnimatedBuilder(
      animation: viewModel.animation,
      builder: (_, __) => Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              viewModel.secondsLeft.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.indigo, fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: LinearProgressIndicator(
            value: viewModel.animation.value,
            minHeight: 20,
            color: AppColors.indigo,
          ))
        ],
      ),
    );
  }

  Widget nextButton(context) {
    if (!viewModel.isAnswered) return const SizedBox();

    final label = viewModel.isLastStep ? 'Закончить' : 'Дальше';
    Function() onTap;
    if (viewModel.isLastStep) {
      onTap = () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return QuizResultScreen(
              title: viewModel.quiz.title,
              questionCount: viewModel.quiz.questions.length,
              correctAnswersCount: viewModel.countCorrectAnswers());
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
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        mainAxisSpacing: 20,
        children: optionCards);
  }
}
