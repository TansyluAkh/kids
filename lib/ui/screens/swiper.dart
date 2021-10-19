import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/core/words/word.dart';
import 'package:bebkeler/ui/components/slider_button.dart';
import 'package:bebkeler/ui/screens/details_screen.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_screen.dart';
import 'package:bebkeler/ui/screens/spelling_bee/game.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'details_screen.dart';
import 'drag_and_drop/dnd_screen.dart';

class Swiper extends StatefulWidget {
  int itemIndex;
  final List<Word> items;

  Swiper({Key key, this.itemIndex, this.items}) : super(key: key);

  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  Word get currentWord => widget.items[widget.itemIndex];

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
          title: Text((widget.itemIndex + 1).toString() + ' / ' + widget.items.length.toString(),
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
                initialPage: widget.itemIndex,
                autoPlay: false,
                enableInfiniteScroll: true,
                onPageChanged: (index) {
                  setState(() {
                    widget.itemIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return DetailsScreen(item: widget.items[index], height: height, width: width);
                },
                height: height * 0.5,
                viewportFraction: 0.9,
              ),
              SizedBox(height: height * 0.02),
              SliderButton(
                  label: 'Квиз\nуйна',
                  icon: Icons.psychology,
                  width: width,
                  height: height,
                  onSlide: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => QuizScreen(
                                quiz: Quiz.fromSubcategory(
                                    currentWord.subCategory,
                                    currentWord.collectionPath,
                                    currentWord.tatarCategory,
                                    widget.items))),
                      )),
              SizedBox(height: height * 0.02),
              SliderButton(
                label: 'Тыңлап\nуйна',
                icon: Icons.music_note,
                width: width,
                height: height,
                onSlide: () {
                  Map<String, String> words_dict = {};
                  for (final item in widget.items)
                    words_dict[item.tatarWord] = item.tatarAudio;

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (text) =>
                          Spelling(items: words_dict, tatCategory: currentWord.tatarCategory)));
                },
              ),
              SizedBox(height: height * 0.02),
              SliderButton(
                label: 'Тест',
                icon: Icons.videogame_asset,
                width: width,
                height: height,
                onSlide: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => DndTest(words: widget.items))),
              )
            ])));
  }
}
