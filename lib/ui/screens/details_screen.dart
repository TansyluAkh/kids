import 'package:bebkeler/core/words/word.dart';
import 'package:bebkeler/core/words/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/screens/body.dart';

class DetailsScreen extends StatelessWidget {
  final name;
  final doc;

  const DetailsScreen({Key key, this.name, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordRepository = WordRepository.instance;

    return Scaffold(
        backgroundColor: AppColors.yellow,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          leading: Icon(Icons.home, color: AppColors.purple, size: 35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: SafeArea(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          // !Game Modes Cards
          Expanded(
              flex: 8,
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                      child: FutureBuilder(
                          future: wordRepository.getWord(name, doc),
                          builder: (BuildContext context, AsyncSnapshot<Word> snapshot) {
                            final word = snapshot.data;
                            return word != null
                                ? Body(product: word)
                                : Center(
                                    child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ));
                          }))))
        ])));
  }
}
