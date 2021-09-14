import 'package:bebkeler/core/categories/category_repository.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/screens/subcatscreen.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/core/categories/category.dart';
import 'package:bebkeler/services/auth_service.dart';
import 'package:bebkeler/ui/components/maincategorycard.dart';
import 'package:flutter/services.dart';

import 'wordsview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final categoryRepository = CategoryRepository.instance;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title:Image.network('https://s9.gifyu.com/images/indigo1.png',
              width: width*0.35, height: height * 0.1, fit: BoxFit.contain),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          leading: const Icon(Icons.home, color: AppColors.element, size: 45),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body:   Padding(
        padding: EdgeInsets.only(left:15, top:10),
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
                                print(categories[index][0].title);
                                return
                                Container(
                                    height: height*0.3, child:
                                Column(children:[
                                Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                  child: Text(
                                    capitalize(categories[index][0].title),
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                Expanded(
                                child:
                                   ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int number) {
                                        return GameModeCard(
                                        icon: categories[index][1][number].imageUrl,
                                        title: categories[index][1][number].title,
                                        description: "234",
                                        onTap: () {
                                          print('TAPPED SUBS' + categories[index].name);
                                          Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => WordsPage(
                                          name: categories[index][0].name,
                                          title: categories[index][0].title)));
                                          },
                                        );
                                        },
                                        ),
                                        )]));})
                          : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.element,
                              ),
                            );
                    }))));

  }
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
