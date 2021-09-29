import 'package:bebkeler/core/categories/category_repository.dart';
import 'package:bebkeler/ui/screens/aboutus.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/components/maincategorycard.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'wordsview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  var r = 'https://firebasestorage.googleapis.com/v0/b/bebkeler-89a5e.appspot.com/o/%D0%BE%D1%80%D0%B0%D0%BD%D0%B6%202.png?alt=media&token=92bd2bfa-6a96-4956-a605-2503adb22b64';
  @override
  Widget build(BuildContext context) {
    final categoryRepository = CategoryRepository.instance;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: AppColors.darkBlue, //change your color here
          ),
          centerTitle: true,

          title:
      Padding( padding: EdgeInsets.only(left:10), child:ConstrainedBox( constraints: BoxConstraints.tightFor(height: height*0.08, width: width*0.45),child: Image.network(r,  fit:BoxFit.contain))),
    leading: IconButton(
    icon: Icon(
    FontAwesomeIcons.info,
    color: AppColors.darkBlue,
    size: 30
    ),
    onPressed: () {Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AboutScreen()));}),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body:   Padding(
        padding: EdgeInsets.only(left:15, top:20, bottom:10),
        child: Container( height: height, child: FutureBuilder(
                    future: categoryRepository.getCategories('categories'),
                    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                      final categories = snapshot.data;
                      return categories != null
                          ? ListView.builder(
                              itemCount: categories != null ? categories.length : 1,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                print(categories[index].title);
                                return
                                Container(
                                    height: height*0.25, child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                  child: Text(
                                    capitalize(categories[index].title),
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.darkBlue, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                FutureBuilder(
                                future: categoryRepository.getCategories('categories/'+categories[index].name+'/subs'),
                                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> subsnapshot) {
                                final subs = subsnapshot.data;
                                return subs != null ?
                                Expanded(
                                child:
                                   ListView.builder(
                                     itemCount: categories != null ? subs.length : 1,
                                     shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int number) {
                                        return GameModeCard(
                                        icon: subs[number].imageUrl,
                                        title: subs[number].title,
                                        description: subs.length,
                                        onTap: () {
                                          print('TAPPED SUBS' + categories[number].name);
                                          Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => WordsPage(
                                          name: categories[index].name+'/'+subs[number].name,
                                          title: subs[number].title)));
                                          },
                                        );
                                        },
                                        ),
                                        ): Center(
    child: CircularProgressIndicator(
    color: AppColors.element,
    ),
    );})]));})
                          : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.element,
                              ),
                            );
                    }))));

  }
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
