import 'package:bebkeler/ui/screens/details_screen.dart';
import 'package:bebkeler/ui/screens/spelling_bee/home.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'details_screen.dart';

class Tinder extends StatefulWidget {
  final items;
  const Tinder({Key key, this.items}) : super(key: key);
  @override
  _TinderState createState() => _TinderState();
}

class _TinderState extends State<Tinder> {
  int number = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.element, //change your color here
          ),
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          centerTitle: true,
          title: Text((number).toString() + ' / ' + widget.items.length.toString(),
              style: TextStyle(fontSize: 22, color: AppColors.black, fontWeight: FontWeight.bold)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: TinderSwapCard(
                    swipeUp: true,
                    swipeDown: true,
                    orientation: AmassOrientation.RIGHT,
                    totalNum: widget.items.length,
                    stackNum: 3,
                    swipeEdge: 4.0,
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    minHeight: MediaQuery.of(context).size.height * 0.55,
                    cardBuilder: (context, index) {
                      return getCard(index);
                    },
                    cardController: CardController(),
                    swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
                      setState(() {
                        number = index + 1;
                      });
                      if (index == widget.items.length - 1) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => SBHomePage()));
                      }
                      ;

                      /// Get orientation & index of swiped card!
                    },
                  ))
                ])));
  }

  Widget getCard(index) {
    return DetailsScreen(
        item: widget.items[index],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width);
  }
}
