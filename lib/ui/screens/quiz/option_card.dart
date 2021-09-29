import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/quiz/models.dart';

enum OptionState { Correct, Wrong, Disabled, Default }

class OptionCard extends StatelessWidget {
  final Option option;
  final OptionState state;
  final bool isSelected;
  final Function() onTap;

  const OptionCard({
    Key key,
    @required this.option,
    @required this.isSelected,
    @required this.onTap,
    this.state = OptionState.Default,
  }) : super(key: key);

  Color getBorderColor() {
    switch (state) {
      case OptionState.Default:
      case OptionState.Disabled:
        return AppColors.element;
      case OptionState.Wrong:
        return AppColors.red;
      case OptionState.Correct:
        return AppColors.darkBlue;
    }
  }

  Color getBackgroundColor() {
    switch (state) {
      case OptionState.Default:
      case OptionState.Disabled:
        return AppColors.orange.withOpacity(0.1);
      case OptionState.Wrong:
        return AppColors.red.withOpacity(0.2);
      case OptionState.Correct:
        return AppColors.darkBlue.withOpacity(0.2);
    }
  }

  TextStyle getTextStyle() {
    Color color;
    switch (state) {
      case OptionState.Default:
        color = AppColors.orange;
        break;
      case OptionState.Disabled:
        color = AppColors.lightGray;
        break;
      case OptionState.Wrong:
        color = AppColors.red;
        break;
      case OptionState.Correct:
        color = AppColors.darkBlue;
        break;
    }

    return TextStyle(color: color, fontSize: 18);
  }

  IconData getIcon() {
    if (isSelected) {
      return option.isCorrect ? Icons.done : Icons.close;
    }
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: getBackgroundColor(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(105)),
            //side: BorderSide(color: getBorderColor(), width: 1)),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.defaultPadding),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (option.text != null && option.imageUrl != null)
                    const SizedBox(
                      height: 5,
                    ),
                  if (option.text != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          option.text,
                          textAlign: TextAlign.center,
                          style: getTextStyle(),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
