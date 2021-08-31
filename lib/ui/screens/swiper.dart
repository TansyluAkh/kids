import 'package:bebkeler/ui/screens/details_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'details_screen.dart';

class Swiper extends StatefulWidget {
  final items;
  final controller;
  const Swiper({Key key, this.items, this.controller}) : super(key: key);
  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.controller,
      children: get_arr()
    );
  }

  List<Widget> get_arr() {
    List<Widget> arr = [];
    widget.items.forEach((element) {
      arr.add(Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppColors.black, //change your color here
            ),
            systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            centerTitle: true,
            title: Text((widget.items.indexOf(element)+1).toString() + ' / ' + widget.items.length.toString(),
                style: TextStyle(
                    fontSize: 22,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            backgroundColor: Colors.transparent,
            // Colors.white.withOpacity(0.1),
            elevation: 0,
          ),
          body: DetailsScreen(item:element)));});
    return arr;
  }
}