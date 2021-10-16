import 'package:bebkeler/core/words/word.dart';
import 'package:bebkeler/ui/components/sliderbtn.dart';
import 'package:bebkeler/ui/screens/details_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'details_screen.dart';

class Swiper extends StatefulWidget {
  final int startIndex;
  final List<Word> items;

  const Swiper({Key key, this.startIndex, this.items}) : super(key: key);

  @override
  _SwiperState createState() => _SwiperState(startIndex);
}

class _SwiperState extends State<Swiper> {
  int elementIndex;

  _SwiperState(startIndex) : elementIndex = startIndex;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.orange, //change your color here
          ),
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          centerTitle: true,
          title: Text((elementIndex + 1).toString() + ' / ' + widget.items.length.toString(),
              style:
                  TextStyle(fontSize: 22, color: AppColors.darkBlue, fontWeight: FontWeight.bold)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Container(
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://urban.tatar/bebkeler/tatar/assets/terrazo.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.dstATop),
              ),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              VxSwiper.builder(
                scrollPhysics: ClampingScrollPhysics(),
                itemCount: widget.items.length,
                autoPlay: false,
                enableInfiniteScroll: true,
                onPageChanged: (index) {
                  setState(() {
                    elementIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return DetailsScreen(item: widget.items[elementIndex], height: height, width: width);
                },
                height: height * 0.5,
                viewportFraction: 0.9,
              ),
              SizedBox(height: height * 0.02),
              sliderbtn('Квиз\nуйна', Icons.psychology, 'playquiz', width, height, context,
                  widget.items[elementIndex], widget.items),
              SizedBox(height: height * 0.02),
              sliderbtn('Тыңлап\nуйна', Icons.music_note, 'playspelling', width, height, context,
                  widget.items[elementIndex], widget.items),
              SizedBox(height: height * 0.02),
              sliderbtn('Тест', Icons.videogame_asset, 'test', width, height, context,
                  widget.items[elementIndex], widget.items)
            ])));
  }
}
