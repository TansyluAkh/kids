import 'package:bebkeler/core/info/info.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bebkeler/core/info/info_repository.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  List<bool> isSelected = [true, false];

  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return FutureBuilder(
        future: getInfo('info', 'about'),
        builder: (BuildContext context, AsyncSnapshot<Info> text) {
          print(text.data);
          return text.data != null
              ? Scaffold(
              backgroundColor: AppColors.background,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                iconTheme: const IconThemeData(
                  color: AppColors.orange, //change your color here
                ),
                centerTitle: false,
                title: Text(
                  isSelected[0]? "Безнең турында" : "О нас",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                      fontSize: 22),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded,
                      color: AppColors.orange, size: 35),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => HomePage()));
                  },
                ),
                actions: [
              ToggleButtons(
              borderRadius: BorderRadius.circular(10),
            color: AppColors.darkBlue,
            selectedColor: AppColors.darkBlue,
            fillColor: AppColors.element,
            splashColor: AppColors.element,
            hoverColor: AppColors.element,
            focusColor: AppColors.element,
            highlightColor: AppColors.element,
            disabledBorderColor: AppColors.element,
            selectedBorderColor: AppColors.element,
            borderColor: AppColors.element,
            disabledColor: AppColors.white,
            children: <Widget>[
              Text('тат'),
              Text('рус')
            ],
            isSelected: isSelected,
            onPressed: (int index) {
              setState(() {
                for (int indexBtn = 0;indexBtn < isSelected.length;indexBtn++) {
                  if (indexBtn == index) {
                    isSelected[indexBtn] = !isSelected[indexBtn];
                  }
                  else {
                    isSelected[indexBtn] = false;
                  }}
              });
            },
          ),
                  IconButton(
                      icon: Icon(FontAwesomeIcons.link,
                          color: AppColors.darkBlue, size: 25),
                      onPressed: () {
                        print(_launched);
                        print(text.data.social);
                        _launched = _launchInBrowser(text.data.social);
                      })
                ],
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent),
                shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                backgroundColor: Colors.transparent,
                // Colors.white.withOpacity(0.1),
                elevation: 0,
              ),
              body:  Container(
                  height: height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://urban.tatar/bebkeler/tatar/assets/terrazo.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.dstATop),
                    )),child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [ SizedBox(height: height*0.12),
              Expanded(
              child: Container(
              child: Padding(
              padding: EdgeInsets.only(
              left: 25,
                  right: 10,
                  top: 30,
                  bottom: 10),
              child: SingleChildScrollView(
                  child:
                  getelem(isSelected[0]? text.data.tat_desc: text.data.rus_desc))))
          )
              ]))
          ): Scaffold(
          backgroundColor: AppColors.background,
          body: const Center(
          child: CircularProgressIndicator(
          color: AppColors.element,
          )));
        });
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget getelem(texter) {
    print(texter);
    List split = texter.split('%').map<Widget>((i) {
      if (i == "") {
        return SizedBox(height: 0);
      } else {
        return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(i,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
                style: TextStyle(color: AppColors.black, fontSize: 18)));
      }
    }).toList();
    split.add( Padding( padding: EdgeInsets.only(top:10), child: Text('Разработано SightRo & Tansyluakh\n2021',maxLines: 2,
      overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.darkBlue, fontSize: 12),
    )));
    print(split);
    var displayElement = Column(children: split);
    return displayElement;
  }
}
