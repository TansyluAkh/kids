import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class Spelling extends StatefulWidget {
  final items;

  const Spelling({Key key, this.items}) : super(key: key);

  @override
  _SpellingState createState() => _SpellingState();
}

class _SpellingState extends State<Spelling> {

  var buttonColor = AppColors.darkBlue;
  var scoreColor = AppColors.darkBlue;
  int score = 0;
  int i = 0;
  bool iscorrect=false;
  String choosenAnswer;
  int currentQuestion = 1;
  final double height = 35.0;
  final double width = 35.0;
  final double margin = 2;
  final color = AppColors.darkBlue;
  final Color fontColor = Colors.white;
  final double fontSize = 18.0;
  final _style = const TextStyle(
    fontFamily: "Montserrat",
    fontSize: 18,
    color: AppColors.darkBlue,
  );

  final TextEditingController _textController = TextEditingController();
  AudioPlayer player;
  int amtQuestions = 0;
  List words = [];

  get result => buttonColor;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    amtQuestions = widget.items != null? widget.items.length:0;
    words = widget.items.keys.toList();
  }

  void onpressedButton(String k) {
    if (k == 'бушлык'){
      _textController.text += ' ';
    }
    else{
    _textController.text += k;}
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
    score = score - 1;
   nextquestion;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void nextquestion() {
    buttonColor = AppColors.darkBlue;
    scoreColor = AppColors.darkBlue;
    setState(() {
      if (i < amtQuestions - 1) {
        currentQuestion++;
        i++;
      } else {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => SBSummaryPage(
        //     score: score,
        //     questions: amtQuestions,
        //   ),
        // ));
      }
    });
  }

  void checkanswer(screenheight, screenwidth) {
    print(choosenAnswer);
    if (choosenAnswer.toLowerCase() == words[i].toLowerCase()) {
      score = score + 1;
      iscorrect = true;}
    else {
      iscorrect = false;};
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: iscorrect? Text("Җавабың дөрес - ${choosenAnswer.toLowerCase()}!\n +1 йөрәк",  style: _style) : Text("Җавабың ялгыш, дөресе - ${words[i].toLowerCase()} ", style: _style.copyWith(color: AppColors.red)),
          actions: <Widget>[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: AppColors.darkBlue, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(45))), minimumSize: Size(screenwidth*0.35, screenheight*0.07), textStyle: _style.copyWith(color: AppColors.white, fontWeight: FontWeight.normal)),
              icon: Icon(Icons.check_box_rounded, size:  screenheight*0.05),
              onPressed:
                  () { Navigator.of(context).pop();
              }, label: Text('Киләсе\nсорау', overflow: TextOverflow.ellipsis, maxLines: 3,),
            ),
          ],
        ));
    nextquestion();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
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
                  content: Text("Уеннан чыгырга мы?",  style: _style),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Юк',  style: _style
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
                        'Әйе',  style: _style
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
                    style: _style),
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.favorite_rounded, color: AppColors.red, size: screenheight*0.05),
                Text( ' '+ score.toString()+words[i],
                    style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', fontSize: 25)),
              ])]),
        ),
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:10, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.red,
                    boxShadow: [BoxShadow(
                        color: AppColors.yellow,
                        blurRadius: 15,
                        spreadRadius: 5,
                    )]
                ), child: IconButton(

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
                    suffixIcon: IconButton(
                      iconSize: 30,
                      onPressed: clearLast,
                      icon: Icon(Icons.backspace_rounded, size:35, color: AppColors.darkBlue),
                    ),
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
                    children: getkey('У К Е Н Г Ш Ә З Х'.split(' '), height, width,  TextAlign.center),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getkey('Ы В А П Р О Л Д Ң'.split(' '), height, width,  TextAlign.center)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getkey('Ч С М И Т Җ Б Ю Ү'.split(' '), height, width,  TextAlign.center),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getkey('Э Я Й Ө Һ Ф Ъ Ь'.split(' '), height , width, TextAlign.center),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [getkey(['бушлык'], 40.0, 105.00, TextAlign.start)[0], getkey(['-'], 40.0 , width, TextAlign.center)[0]]),
                  SizedBox(
                    height: 5.0,
                  ),
                      ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
         ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: AppColors.darkBlue, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(45))), minimumSize: Size(screenwidth*0.35, screenheight*0.07), textStyle: _style.copyWith(color: AppColors.white, fontWeight: FontWeight.normal)),
                icon: Icon(Icons.skip_next_rounded, size: screenheight*0.05),
                label: Text('Башка\nсорау', overflow: TextOverflow.ellipsis, maxLines: 3,),
                onPressed:
                      () {_textController.clear();
    onSkip();},
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: AppColors.darkBlue, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(45))), minimumSize: Size(screenwidth*0.35, screenheight*0.07), textStyle: _style.copyWith(color: AppColors.white, fontWeight: FontWeight.normal)),
                icon: Icon(Icons.check_box_rounded, size: screenheight*0.05),
                onPressed:
                    () {
                      choosenAnswer = _textController.text;
                      checkanswer(screenheight, screenwidth);
                      _textController.clear();
                    }, label: Text('Җавап\nбир', overflow: TextOverflow.ellipsis, maxLines: 3,),
              ),
            ],
              ),
      ]),
    )));
  }

  List<Widget> getkey(letters, height, width, textAlign) {
    List<Widget> arr = [];
    letters.forEach((l) {
      arr.add(
        Container(
            margin: EdgeInsets.all(margin),
            height: height,
            width: width,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)),
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
