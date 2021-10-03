import 'package:bebkeler/core/words/word.dart';
import 'package:bebkeler/core/words/word_repository.dart';
import 'package:bebkeler/ui/screens/swiper.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WordsPage extends StatefulWidget {
  final name;
  final title;

  WordsPage({Key key, @required this.name, @required this.title}) : super(key: key);

  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.orange, //change your color here
          ),
          centerTitle: false,
          title: Text(capitalize(widget.title),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
                fontSize: 22,
                color: AppColors.darkBlue,
              )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: NetworkImage('https://urban.tatar/bebkeler/tatar/assets/terrazo.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.dstATop),
              ),),
            child: FutureBuilder(
                future: WordRepository.instance.getWord('categories/' + widget.name),
                builder: (BuildContext context, AsyncSnapshot<List<Word>> text) {
                  print(text.data);
                  return text.data != null
                      ? Column(children: [
                        SizedBox(height: height*0.12),
                          Expanded(
                            child: StaggeredGridView.countBuilder(
                              padding: EdgeInsets.all(20),
                              crossAxisCount: 2,
                              itemCount: text.data.length,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                              itemBuilder: (context, index) {
                                return Stack(alignment: Alignment.bottomLeft, children: [
                                  InkWell(
                                      onTap: () {
                                        print('TAPPED GRIDWORD');
                                        var all_items = text.data;
                                        var item = text.data[index];
                                        all_items.remove(all_items[index]);
                                        all_items.insert(0, item);
                                        print(all_items);
                                        print('ALL ITEMS');
                                        print(all_items[0].imageUrl);
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => Swiper(items: all_items)));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        height: height * 0.15,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          image: DecorationImage(
                                            image: NetworkImage(text.data[index].imageUrl),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      )),
                                  Chip(
                                      backgroundColor: AppColors.white,
                                      label: Text(
                                        capitalize(text.data[index].tatarWord),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkBlue),
                                      )),
                                ]);
                              },
                              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                            ),
                          ),
                        ])
                      : const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.element,
                        ));
                })));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
