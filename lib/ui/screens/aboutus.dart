import 'package:bebkeler/core/info/info.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bebkeler/core/info/info_repository.dart';
class AboutScreen extends StatelessWidget {
  @override
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getInfo('info', 'about'),
        builder: (BuildContext context, AsyncSnapshot<Info> text) {
          print(text.data);
          return text.data != null
              ? Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: AppColors.orange, //change your color here
          ),
          centerTitle: true,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [IconButton( icon: Icon(Icons.arrow_back_rounded , color: AppColors.orange, size: 35),
                onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage()));},), Text(
              "Безнең турында",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue, fontSize: 22),
            ),
                IconButton(
                    icon: Icon(
                        FontAwesomeIcons.link,
                        color: AppColors.darkBlue,
                        size: 25
                    ),
                    onPressed: (){
                      print(_launched);
                      print(text.data.social);
                      _launched = _launchInBrowser(text.data.social);
                    })]),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
                  child: Padding( padding: EdgeInsets.only(left:25, right:10, top:10, bottom: 10),
                    child: SingleChildScrollView(child:
                        getelem(text.data.rus_desc))
            )))])): Scaffold(
              backgroundColor: AppColors.background, body: const Center(
              child: CircularProgressIndicator(
                color: AppColors.element,
              )));
  });}
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget getelem(texter) {
    var split = texter.split('\n').map((i) {
      if (i == "") {
        return Divider();
      } else {
        return Text(
          i,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 100,
          style: TextStyle(
              color: AppColors.black, fontSize: 18));
        }}).toList();
    var displayElement = Column(children: split);
    return displayElement;
  }
}
