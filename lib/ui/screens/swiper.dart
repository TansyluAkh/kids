import 'package:bebkeler/ui/screens/details_screen.dart';
import 'package:flutter/material.dart';

import 'details_screen.dart';

class Swiper extends StatefulWidget {
  final items;
  final index;
  const Swiper({Key key, this.items, this.index}) : super(key: key);
  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  var _controller;
  @override
  void initState() {
    super.initState();
    PageController _controller = PageController(
      initialPage:widget.index,
    );}
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: get_arr()
    );
  }

  List<Widget> get_arr() {
    List<Widget> arr = [];
    widget.items.forEach((element) {
      arr.add(DetailsScreen(item:element));});
    return arr;
  }
}