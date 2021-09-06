import 'package:bebkeler/ui/screens/details_screen.dart';
import 'package:bebkeler/ui/screens/quiz/models.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'details_screen.dart';

class Swiper extends StatefulWidget {
  final items;
  final controller;

  const Swiper({Key key, this.items, this.controller}) : super(key: key);

  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  var element = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<Widget> arr = [];
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.element, //change your color here
          ),
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          centerTitle: true,
          title: Text(
              (element + 1).toString() + ' / ' + widget.items.length.toString(),
              style: TextStyle(
                  fontSize: 22,
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.bold)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Column(children: [
          VxSwiper.builder(
            itemCount: widget.items.length,
            autoPlay: false,
            autoPlayAnimationDuration: 3.seconds,
            autoPlayCurve: Curves.easeInOut,
            enableInfiniteScroll: true,
            onPageChanged: (index) {
              setState(() {
                element = index;
              });
            },
            itemBuilder: (context, index) {
              return get_arr(height, width, widget.items[index]);
            },
            height: height * 0.55,
            viewportFraction: 0.8,
          ),
          SizedBox(height: height*0.05),
          Chip(
              autofocus: true,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              labelPadding: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              backgroundColor: AppColors.white.withOpacity(0.6),
              label: InkWell(
                  onTap: () {
                    print('tappedplay');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuzScreen(
                            quiz: Quiz.fromSubcategory(
                                widget.items[element].category2, widget.items))));
                  },
                  child: Container(
                      width: width * 0.22,
                      height: height * 0.05,
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Уйна',
                              style: TextStyle(
                                  color: AppColors.darkBlue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))))),
              avatar: Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                      iconSize: height * 0.045,
                      color: AppColors.darkBlue,
                      icon: Icon(FontAwesomeIcons.play),
                      onPressed: () {
                        print('tappedplay');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => QuzScreen(
                                  quiz: Quiz.fromSubcategory(
                                      widget.items[element].category2,
                                      widget.items))),
                        );
                      })))
        ]));
  }

  Widget get_arr(height, width, item) {
    return DetailsScreen(item: item, height: height, width: width);
  }
}
