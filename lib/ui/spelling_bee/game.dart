import 'package:bebkeler/ui/quiz/quiz_result_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class Spelling extends StatefulWidget {
  final Map<String, String> items;
  final String tatCategory;

  const Spelling({Key? key, required this.items, required this.tatCategory}) : super(key: key);

  @override
  _SpellingState createState() => _SpellingState();
}

class _SpellingState extends State<Spelling> {
  var buttonColor = AppColors.green;
  var scoreColor = AppColors.green;
  int score = 0;
  int i = 0;
  bool isCorrect = false;
  String? chosenAnswer;
  int currentQuestion = 1;
  final double height = 35.0;
  final double width = 35.0;
  final double margin = 2;
  final color = AppColors.green;
  final Color fontColor = AppColors.background;
  final double fontSize = 18.0;
  final _style = const TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: "Montserrat",
    fontSize: 18,
    color: AppColors.green,
  );

  final TextEditingController _textController = TextEditingController();
  AudioPlayer player = AudioPlayer();
  int amtQuestions = 0;
  List<String> words = [];

  get result => buttonColor;

  @override
  void initState() {
    amtQuestions = widget.items.length;
    words = widget.items.keys.toList();
    words.shuffle();
    super.initState();
  }

  void onPressedButton(String k) {
    if (k == 'бушлык') {
      _textController.text += ' ';
    } else {
      _textController.text += k;
    }
  }

  void clearLast() {
    if (_textController.text.length > 0) {
      _textController.text = _textController.text.substring(0, _textController.text.length - 1);
    }
  }

  void clearAll() {
    _textController.clear();
  }

  void onSkip() {
    setState(() {
      score = score - 1;
    });
    nextQuestion();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void nextQuestion() async {
    setState(() {
      if (i < amtQuestions - 1) {
        currentQuestion++;
        i++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => QuizResultScreen(
            result: score,
            maxResult: amtQuestions,
            tatCategory: widget.tatCategory,
          ),
        ));
      }
    });
    try {
      await player.setUrl(widget.items[words[i]]!);
    } on Exception catch (_) {
      ('no audio');
    }
  }

  void checkAnswer(double screenHeight, double screenWidth) {
    print(chosenAnswer);
    if (chosenAnswer?.toLowerCase() == words[i].toLowerCase()) {
      score = score + 1;
      isCorrect = true;
    } else {
      isCorrect = false;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                backgroundColor: isCorrect
                    ? AppColors.element.withOpacity(0.8)
                    : AppColors.orange.withOpacity(0.8),
                content: isCorrect
                    ? Text("Җавабың дөрес - ${chosenAnswer?.toUpperCase()}!",
                        style: TextStyle(color: AppColors.green, fontSize: 20))
                    : Text("Җавабың ялгыш, дөресе - ${words[i].toUpperCase()} ",
                        style: TextStyle(color: AppColors.white, fontSize: 20)),
                actions: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              size: screenHeight * 0.035,
                              color: isCorrect ? AppColors.green : AppColors.white),
                          onPressed: () async {
                            if (i < amtQuestions - 1) {
                              try {
                                await player.setUrl(widget.items[words[i + 1]]!);
                              } on Exception catch (_) {
                                ('no audio');
                              }
                            }
                            setState(() {
                              if (i < amtQuestions - 1) {
                                currentQuestion++;
                                i++;
                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => QuizResultScreen(
                                    result: score,
                                    maxResult: amtQuestions,
                                    tatCategory: widget.tatCategory,
                                  ),
                                ));
                              }
                            });
                          }))
                ]));
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: () async {
          return await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        content: Text("Уеннан чыгырга мы?", style: _style),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Юк', style: _style),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                                ModalRoute.withName('/'),
                              );
                            },
                            child: Text('Әйе', style: _style),
                          )
                        ],
                      )) ??
              false;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.orange),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('$currentQuestion / $amtQuestions ',
                        textAlign: TextAlign.center, style: _style.copyWith(fontSize: 22)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite_rounded,
                              color: AppColors.orange, size: screenHeight * 0.045),
                          Text(' ' + score.toString(),
                              style: TextStyle(
                                  color: AppColors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  fontSize: 22)),
                        ])
                  ]),
            ),
            backgroundColor: AppColors.background,
            body: Container(
                height: screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://urban.tatar/bebkeler/tatar/assets/terrazo.jpg'),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.dstATop),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.orange.withOpacity(0.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.orange.withOpacity(0.4),
                                    blurRadius: 5,
                                    spreadRadius: 7,
                                  )
                                ]),
                            child: IconButton(
                              icon: Icon(Icons.volume_up_rounded),
                              color: AppColors.background,
                              iconSize: 65.0,
                              onPressed: () async {
                                try {
                                  await player.setUrl(widget.items[words[i]]!);
                                } on Exception catch (_) {
                                  ('no audio');
                                }
                                print(widget.items[words[i]]);
                                player.play();
                              },
                              tooltip: 'Киредән тыңлау өчен басыгыз',
                            )),
                        Container(
                            width: screenWidth * 0.6,
                            child: TextFormField(
                              controller: _textController,
                              onChanged: (val) {
                                chosenAnswer = val;
                              },
                              textCapitalization: TextCapitalization.characters,
                              readOnly: true,
                              maxLength: words[i].length,
                              showCursor: false,
                              textAlign: TextAlign.center,
                              autocorrect: false,
                              style: TextStyle(
                                fontSize: 25.0,
                                color: AppColors.green,
                                letterSpacing: 5.0,
                              ),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  iconSize: 30,
                                  onPressed: clearLast,
                                  icon: Icon(Icons.backspace_rounded,
                                      size: 35, color: AppColors.green),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(45),
                                  borderSide: BorderSide(
                                    color: AppColors.green,
                                    width: 5.0,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(45),
                                  borderSide: BorderSide(
                                    color: AppColors.green,
                                    width: 5.0,
                                  ),
                                ),
                              ),
                            )),
                        Column(children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: getKey(
                                'У К Е Н Г Ш Ә З Х'.split(' '), height, width, TextAlign.center),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: getKey(
                                  'Ы В А П Р О Л Д Ң'.split(' '), height, width, TextAlign.center)),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: getKey(
                                'Ч С М И Т Җ Б Ы Ү'.split(' '), height, width, TextAlign.center),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: getKey(
                                'Э Я Й Ө Һ Ф Ъ Ь Ю'.split(' '), height, width, TextAlign.center),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            getKey(['бушлык'], 40.0, 105.00, TextAlign.start)[0],
                            getKey(['-'], 40.0, width, TextAlign.center)[0]
                          ]),
                          SizedBox(
                            height: 5.0,
                          ),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.orange.withOpacity(0.9),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(45))),
                                  minimumSize: Size(screenWidth * 0.35, screenHeight * 0.07),
                                  textStyle: _style.copyWith(
                                      color: AppColors.background, fontWeight: FontWeight.normal)),
                              icon: Icon(Icons.skip_next_rounded, size: screenHeight * 0.05),
                              label: Text(
                                'Башка\nсорау',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              onPressed: () {
                                _textController.clear();
                                onSkip();
                              },
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.green.withOpacity(1),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(45))),
                                  minimumSize: Size(screenWidth * 0.35, screenHeight * 0.07),
                                  textStyle: _style.copyWith(
                                      color: AppColors.background, fontWeight: FontWeight.normal)),
                              icon: Icon(Icons.check_box_rounded, size: screenHeight * 0.05),
                              onPressed: () {
                                chosenAnswer = _textController.text;
                                checkAnswer(screenHeight, screenWidth);
                                _textController.clear();
                              },
                              label: Text(
                                'Җавап\nбир',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ]),
                ))));
  }

  List<Widget> getKey(letters, height, width, textAlign) {
    List<Widget> arr = [];
    letters.forEach((l) {
      arr.add(
        Container(
            margin: EdgeInsets.all(margin),
            height: height,
            width: width,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                onPressedButton(l.toLowerCase());
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
