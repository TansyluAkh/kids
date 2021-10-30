import 'package:bebkeler/core/category.dart';
import 'package:bebkeler/ui/about_us.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/shared/category_card.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'words_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  var r = 'https://urban.tatar/bebkeler/tatar/assets/green.png';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: AppColors.green, //change your color here
          ),
          centerTitle: true,
          title: Image.network(r, fit: BoxFit.contain, height: height * 0.12, width: width * 0.45),
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.info, color: AppColors.green, size: 30),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) => About()));
                })
          ],
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Container(
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://urban.tatar/bebkeler/tatar/assets/terrazo.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.dstATop),
              ),
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10, bottom: 15),
                child: FutureBuilder(
                    future: getCategories('categories'),
                    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                      final categories = snapshot.data;
                      return categories != null
                          ? Column(children: [
                              SizedBox(height: height * 0.12),
                              Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      itemCount: categories.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        print(categories[index].title);
                                        return Container(
                                            height: height * 0.25,
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10,
                                                    ),
                                                    child: Text(
                                                      capitalize(categories[index].title),
                                                      textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          ?.copyWith(
                                                              color: AppColors.green,
                                                              fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  FutureBuilder(
                                                      future: getCategories('categories/' +
                                                          categories[index].name +
                                                          '/subs'),
                                                      builder: (BuildContext context,
                                                          AsyncSnapshot<List<dynamic>>
                                                              subSnapshot) {
                                                        final subs = subSnapshot.data;
                                                        return subs != null
                                                            ? Expanded(
                                                                child: ListView.builder(
                                                                  itemCount: subs.length,
                                                                  shrinkWrap: true,
                                                                  scrollDirection: Axis.horizontal,
                                                                  itemBuilder:
                                                                      (BuildContext context,
                                                                          int number) {
                                                                    return CategoryCard(
                                                                      iconUrl:
                                                                          subs[number].imageUrl,
                                                                      title: subs[number].title,
                                                                      onTap: () {
                                                                        Navigator.of(context).push(
                                                                            MaterialPageRoute(
                                                                                builder: (context) => WordsPage(
                                                                                    name: categories[
                                                                                                index]
                                                                                            .name +
                                                                                        '/' +
                                                                                        subs[number]
                                                                                            .name,
                                                                                    title: subs[
                                                                                            number]
                                                                                        .title)));
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              )
                                                            : Center(
                                                                child: CircularProgressIndicator(
                                                                  color: AppColors.element,
                                                                ),
                                                              );
                                                      })
                                                ]));
                                      })),
                            ])
                          : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.element,
                              ),
                            );
                    }))));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}