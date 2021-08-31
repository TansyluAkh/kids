import 'package:bebkeler/ui/screens/quiz/quiz_result_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models.dart';
import 'quiz_view_model.dart';
import 'option_card.dart';

class QuzScreen extends ConsumerWidget {
  final Quiz quiz;

  QuzScreen({this.quiz});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(quizViewModelProvider(quiz));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: backNavbar(context),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: body(context, vm),
        ),
      ),
    );
  }

  Widget backNavbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.element,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  Widget body(BuildContext context, QuizViewModel vm) {
    return Column(
      children: [
        Expanded(
          child: Column(children: [
            Text(
              vm.currentQuestion.text,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.indigo, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(child: optionGrid(vm))
          ]),
        ),
        nextButton(context, vm)
      ],
    );
  }

  Widget nextButton(context, QuizViewModel vm) {
    if (!vm.isAnswered) return SizedBox();

    final label = vm.isLastStep ? 'Закончить' : 'Дальше';
    Function() onTap;
    if (vm.isLastStep) {
      onTap = () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return QuizResultScreen(
              title: vm.quiz.title,
              questionCount: vm.quiz.questions.length,
              correctAnswersCount: vm.countCorrectAnswers());
        }));
      };
    } else {
      onTap = () => vm.goNext();
    }

    return Row(children: [
      Expanded(
          child: Container(
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
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.white,
            ),
          ),
        ),
      ))
    ]);
  }

  Widget optionGrid(QuizViewModel vm) {
    final List<Widget> optionCards = [];
    for (var i = 0; i < vm.currentQuestion.options.length; i++) {
      final option = vm.currentQuestion.options[i];
      final onTap = () => vm.answer(i);

      var state = OptionState.Default;
      if (vm.isAnswered)
        state =
            vm.currentAnswer.chosenOptionIndex == i ? OptionState.Selected : OptionState.Disabled;

      optionCards.add(OptionCard(option: option, state: state, onTap: onTap));
    }

    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        mainAxisSpacing: 20,
        children: optionCards);
  }
}
