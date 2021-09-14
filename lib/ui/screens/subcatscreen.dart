import 'package:bebkeler/core/categories/category_repository.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/screens/wordsview.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/screens/login_screen.dart';
import 'package:bebkeler/core/categories/category.dart';
import 'package:bebkeler/services/auth_service.dart';
import 'package:bebkeler/ui/components/maincategorycard.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SubHomePage extends StatefulWidget {
  final name;
  final title;
  SubHomePage({Key key, @required this.name, @required this.title}) : super(key: key);
  @override
  _SubHomePageState createState() => _SubHomePageState();
}

class _SubHomePageState extends State<SubHomePage> {
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
          color: AppColors.element),
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: false,
        title: Text(capitalize(widget.title),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
              fontSize: 22,
              color: AppColors.darkBlue,
            )),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        backgroundColor: Colors.transparent,
        // Colors.white.withOpacity(0.1),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 8,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FutureBuilder(
                            future: categoryRepository
                                .getCategories('categories/' + widget.name + '/subs'),
                            builder:
                                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                              final categories = snapshot.data;
                              print('CATEGORIES');
                              return categories != null
                                  ? StaggeredGridView.countBuilder(
                                padding: EdgeInsets.all(20),
                                crossAxisCount: 2,
                                itemCount: categories.length,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                itemBuilder: (context, index) {
                                  return Stack(
                                      alignment: Alignment.bottomLeft,
                                      children:[
                                        InkWell(
                                            onTap: () {
                                              print('TAPPED SUBS' + categories[index].name);
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => WordsPage(
                                                      name: categories[index].name,
                                                      title: categories[index].title)));
                                            },
                                            child:
                                            Container(
                                              padding: EdgeInsets.all(20),
                                              height: index.isEven ? height*0.2 : height*0.25,
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius: BorderRadius.circular(16),
                                                image: DecorationImage(
                                                  image: NetworkImage(categories[index].imageUrl),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            )), Chip(
                                            backgroundColor: AppColors.white,
                                            label: Text(
                                              capitalize(categories[index].title),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkBlue),
                                            )),
                                      ]);
                                },
                                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                              )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.element,
                                      ),
                                    );
                            }))),
           IconButton(
                    icon: const Icon(
                      Icons.no_encryption,
                      color: Colors.white60,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  "bebkeler",
                                ),
                                content: const Text("Sign out?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'No',
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      setState(() => loading = true);
                                      await _auth.signOut().whenComplete(() {
                                        setState(() => loading = false);
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(builder: (context) {
                                          return LoginPage();
                                        }), ModalRoute.withName('/'));
                                      });
                                    },
                                    child: const Text(
                                      'Yes',
                                    ),
                                  )
                                ],
                              ));
                    }),
          ],
        ),
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
