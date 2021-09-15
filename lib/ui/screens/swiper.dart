import 'package:bebkeler/core/words/word.dart';
import 'package:bebkeler/ui/screens/details_screen.dart';
import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'details_screen.dart';
import 'package:slider_button/slider_button.dart';

class Swiper extends StatefulWidget {
  final List<Word> items;

  const Swiper({Key key, this.items}) : super(key: key);

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
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          centerTitle: true,
          title: Text((element + 1).toString() + ' / ' + widget.items.length.toString(),
              style:
                  TextStyle(fontSize: 22, color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          VxSwiper.builder(
            itemCount: widget.items.length,
            autoPlay: false,
            enableInfiniteScroll: true,
            onPageChanged: (index) {
              setState(() {
                element = index;
              });
            },
            itemBuilder: (context, index) {
              return get_arr(height, width, widget.items[index]);
            },
            height: height * 0.5,
            viewportFraction: 0.9,
          ),
          SizedBox(height: height * 0.05),
          Container( width: width*0.7, height: height*0.2, child:Center(
              child:SliderButton(
                action: () {
                    print('tappedplay');
                    Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => QuizScreen(
                    quiz: Quiz.fromSubcategory(
                    widget.items[element].subCategory,
                    widget.items[element].collectionPath,
                    widget.items[element].tatarCategory,
                    widget.items))),
                    );
                    },
                label: Text(
                  "Уйна!",
                  style: TextStyle(
                      color: Color(0xff707cba),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                icon: Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 60.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    )),
                boxShadow: BoxShadow(
                  color: Color(0xff707cba),
                  blurRadius: 4,
                ),
                width: width*0.5,
                dismissible: false,
                shimmer: false,
                radius: 70,
                buttonColor: Color(0xff707cba),
                backgroundColor: Color(0xfffdfdfd),
                highlightedColor: Color(0xfffdfdfd),
                baseColor: Color(0xff707cba),
              )))]));
  }

  Widget get_arr(height, width, item) {
    return DetailsScreen(item: item, height: height, width: width);
  }
}
