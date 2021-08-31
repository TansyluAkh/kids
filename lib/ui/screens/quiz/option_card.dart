import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/material.dart';

import 'models.dart';

enum OptionState { Selected, Disabled, Default }

class OptionCard extends StatelessWidget {
  final Option option;
  final OptionState state;
  final Function() onTap;

  const OptionCard({
    Key key,
    @required this.option,
    @required this.onTap,
    this.state = OptionState.Default,
  }) : super(key: key);

  Color getBorderColor() {
    switch (state) {
      case OptionState.Default:
      case OptionState.Disabled:
        return AppColors.gray;
      case OptionState.Selected:
        {
          if (option.isCorrect)
            return AppColors.darkGreen;
          else
            return AppColors.darkRed;
        }
    }
  }

  Color getBackgroundColor() {
    switch (state) {
      case OptionState.Default:
      case OptionState.Disabled:
        return AppColors.white;
      case OptionState.Selected:
        {
          if (option.isCorrect)
            return AppColors.lightGreen;
          else
            return AppColors.lightRed;
        }
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
      case OptionState.Selected:
        {
          if (option.isCorrect)
            color = AppColors.darkGreen;
          else
            color = AppColors.darkRed;
        }
    }

    return TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold);
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: getBackgroundColor(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: getBorderColor(), width: 2)),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (option.imageUrl != null)
                Image(
                  image: NetworkImage(option.imageUrl),
                ),
              if (option.text != null && option.imageUrl != null)
                SizedBox(
                  height: 10,
                ),
              if (option.text != null)
                Text(
                  option.text,
                  textAlign: TextAlign.center,
                  style: getTextStyle(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
