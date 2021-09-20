import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/screens/home_screen.dart';
import 'package:bebkeler/ui/screens/spelling_bee/summary.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class Spelling extends StatefulWidget {
  final items;

  const Spelling({Key key, this.items}) : super(key: key);

  @override
  _SpellingState createState() => _SpellingState();
}

class _SpellingState extends State<Spelling> {

  final rightColor = AppColors.darkBlue;
  final wrongColor = AppColors.red;
  var buttonColor = AppColors.darkBlue;
  var scoreColor = AppColors.darkBlue;
  int score = 0;
  int i = 0;
  int timer = 15;
  String showTimer = '15';
  String choosenAnswer;
  bool canceltimer = false;
  int currentQuestion = 1;
  final double height = 30.0;
  final double width = 30.0;
  final double margin = 2;
  final color = AppColors.darkBlue;
  final Color fontColor = Colors.white;
  final double fontSize = 18.0;
  final TextEditingController _textController = TextEditingController();
  AudioPlayer player;
  int amtQuestions = 0;
  List words = [];

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    amtQuestions = widget.items != null? widget.items.length:0;
    words = widget.items.keys.toList();
    starttimer();
  }

  void onpressedButton(String k) {
    _textController.text += k;
  }

  void clearLast() {
    if (_textController.text.length > 0) {
      _textController.text =
          _textController.text.substring(0, _textController.text.length - 1);
    }
  }

  void clearAll() {
    _textController.clear();
  }

  void onSkip() {
    scoreColor = wrongColor;
    score = score - 1;
    Timer(Duration(seconds: 1), nextquestion);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    buttonColor = AppColors.darkBlue;
    scoreColor = AppColors.darkBlue;
    canceltimer = false;
    timer = 15;
    setState(() {
      if (i < amtQuestions - 1) {
        currentQuestion++;
        i++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SBSummaryPage(
            score: score,
            questions: amtQuestions,
          ),
        ));
      }
    });
    starttimer();
  }

  void checkanswer() {
    if (choosenAnswer.toLowerCase() == words[i].toLowerCase()) {
      score = score + 1;
      buttonColor = rightColor;
    } else {
      buttonColor = wrongColor;
    }
    setState(() {
      canceltimer = true;
    });
    Timer(Duration(seconds: 1), nextquestion);
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
    canceltimer = true;
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    _textController.text;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text("Уеннан чыгырга?"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Юк',
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()),
                          ModalRoute.withName('/'),
                        );
                      },
                      child: Text(
                        'Әйе',
                      ),
                    )
                  ],
                ));
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.darkBlue),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: AppColors.element,
          centerTitle: true,
          title:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('$currentQuestion / $amtQuestions',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      fontSize: 22,
                      color: AppColors.darkBlue,
                    )),
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.favorite_rounded, color: AppColors.red, size: screenheight*0.05),
                Text( ' '+ score.toString(),
                    style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 25)),
              ])]),
        ),
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:10, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
            CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.red, child: IconButton(
        icon: Icon(Icons.volume_up_rounded),
        color: AppColors.white,
        iconSize: 65.0,
        onPressed: () async {
          await player.setUrl(
              'https://firebasestorage.googleapis.com/v0/b/bebkeler-89a5e.appspot.com/o/pronunciation_tt_%D1%80%D3%99%D1%85%D0%BC%D3%99%D1%82.mp3?alt=media&token=1fa2d250-afc6-4b27-be6e-e5660021531a');
          player.play();
        },
        tooltip: 'Киредән тыңлау өчен басыгыз',
      )),
            Container( width: screenwidth*0.6, child: TextFormField(
                  controller: _textController,
                  onChanged: (val) {
                    choosenAnswer = val;
                  },
                  textCapitalization: TextCapitalization.characters,
                  readOnly: true,
                  cursorWidth: 3.0,
                  cursorColor: AppColors.darkBlue,
                  maxLength: words[i].length,
                  showCursor: true,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: AppColors.darkBlue,
                    letterSpacing: 5.0,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(
                        color: AppColors.darkBlue,
                        width: 5.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: BorderSide(
                        color: AppColors.darkBlue,
                        width: 5.0,
                      ),
                    ),
                  ),
                )),

              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getkey('Й Ө У К Е Н Г Ш Ә З Х'.split(' ')),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getkey('Һ Ф Ы В А П Р О Л Д Ң'.split(' '))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getkey('Э Я Ч С М И Т Җ Б Ю Ү'.split(' ')),
                  ),
                      ]),
              Row(

                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.check_circle_outline_rounded),
                      iconSize: height*0.07,
                      color: AppColors.darkBlue,
                      onPressed: () => checkanswer(),),
                  ]),
            ],

              ),
      ),
    ));
  }

  List<Widget> getkey(letters) {
    List<Widget> arr = [];
    letters.forEach((l) {
      arr.add(
        Container(
            margin: EdgeInsets.all(margin),
            height: height,
            width: width,
            child: RaisedButton(
              color: color,
              onPressed: () {
                onpressedButton(l);
              },
              child: Text(
                l,
                textAlign: TextAlign.center,
                style: TextStyle(color: fontColor, fontSize: fontSize),
              ),
            )),
      );
    });
    return arr;
  }
}
