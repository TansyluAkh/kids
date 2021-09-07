import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/material.dart';

import 'models.dart';

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
        return AppColors.background;
      case OptionState.Wrong:
        return AppColors.darkRed;
      case OptionState.Correct:
        return AppColors.darkGreen;
    }
  }

  Color getBackgroundColor() {
    switch (state) {
      case OptionState.Default:
      case OptionState.Disabled:
        return Colors.transparent;
      case OptionState.Wrong:
        return AppColors.lightRed;
      case OptionState.Correct:
        return AppColors.lightGreen;
    }
  }

  TextStyle getTextStyle() {
    Color color;
    switch (state) {
      case OptionState.Default:
        color = AppColors.black;
        break;
      case OptionState.Disabled:
        color = AppColors.lightGray;
        break;
      case OptionState.Wrong:
        color = AppColors.darkRed;
        break;
      case OptionState.Correct:
        color = AppColors.darkGreen;
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
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: getBorderColor(), width: 2)),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.defaultPadding),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (option.imageUrl != null)
                    Image(
                      image: NetworkImage(option.imageUrl),
                    ),
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
