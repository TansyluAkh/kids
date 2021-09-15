import 'package:bebkeler/core/categories/category_repository.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/components/maincategorycard.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login_screen.dart';
import 'wordsview.dart';
import 'package:bebkeler/infrastructure/auth/auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  final AuthService _auth = AuthService.instance;

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Icons.home, color: AppColors.darkBlue, size: 35), Image.network('https://s9.gifyu.com/images/indigo1.png',
              width: width * 0.4, height: height * 0.15, fit: BoxFit.contain),
           IconButton(
                    icon: Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: AppColors.darkBlue,
                      size: 25
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "bebkeler",
                                ),
                                content: Text("Sign out?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'No',
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      setState(() => loading = true);
                                      await _auth.signOut().whenComplete(() {
                                        setState(() => loading = false);
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                                          return LoginPage();
                                        }), ModalRoute.withName('/'));
                                      });
                                    },
                                    child: Text(
                                      'Yes',
                                    ),
                                  )
                                ],
                              ));
                    }),
          ]),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
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
