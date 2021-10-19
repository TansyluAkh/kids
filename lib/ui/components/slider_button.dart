import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart' as SliderLib;

class SliderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onSlide;
  final double height;
  final double width;

  const SliderButton({Key key, this.label, this.icon, this.onSlide, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderLib.SliderButton(
      action: onSlide,
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.darkBlue, fontSize: 16),
      ),
      icon: Center(
          child: Icon(
        icon,
        color: Colors.white,
        size: height * 0.055,
      )),
      boxShadow: BoxShadow(
        color: AppColors.darkBlue,
        blurRadius: 4,
      ),
      buttonSize: height * 0.075,
      width: width * 0.45,
      height: height * 0.08,
      dismissible: false,
      shimmer: false,
      radius: 70,
      buttonColor: AppColors.darkBlue,
      backgroundColor: AppColors.white,
      highlightedColor: AppColors.darkBlue,
      baseColor: AppColors.darkBlue,
    );
  }
}