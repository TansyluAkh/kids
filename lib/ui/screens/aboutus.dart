import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_screen.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.darkBlue, //change your color here
          ),
          centerTitle: true,
          
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [IconButton( icon: Icon(Icons.home, color: AppColors.darkBlue, size: 35),
                onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage()));},), Text(
      "Безнең турында",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.darkBlue, fontSize: 22),
    ),
                IconButton(
                    icon: Icon(
                        FontAwesomeIcons.link,
                        color: AppColors.darkBlue,
                        size: 25
                    ),
                    onPressed: () {Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AboutScreen()));})]),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: AppColors.element,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Container(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right:  20, top: 30, bottom: 20 ),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Кадерле дуслар!  төркеменә язылуыгыз өчен рәхмәт! Төркемдә басылган материаллар күңелегезгә хуш килер дип ышанам.Сезгә зур үтенечем бар: әгәр Үчтеки дә басылган минем авторлактагы материалларны (мәкалә, шигырьләр һ.б.) кулланасыз икән, Үчтеки төркеменә сылтаманы һәм әсәрләрнең авторын күрсәтергә онытмасагыз иде. Алдан ук рәхмәт!",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style: TextStyle(
                            color: AppColors.darkBlue, fontSize: 18),
                      ),
                      Image.network('https://s9.gifyu.com/images/ducks.png',
                          fit: BoxFit.contain, width: width * 0.95, height: height * 0.35),
                      ]),
              ),
            )));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
