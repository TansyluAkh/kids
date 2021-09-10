import 'package:bebkeler/core/categories/category_repository.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:bebkeler/ui/screens/subcatscreen.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/core/categories/category.dart';
import 'package:bebkeler/ui/components/maincategorycard.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          title: Image.network('https://s9.gifyu.com/images/indigo1.png',
              width: width * 0.35, height: height * 0.1, fit: BoxFit.contain),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          leading: const Icon(Icons.home, color: AppColors.element, size: 45),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                child: FutureBuilder(
                    future: categoryRepository.getCategories('categories'),
                    builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                      final categories = snapshot.data;
                      return categories != null
                          ? ListView.builder(
                              itemCount: categories != null ? categories.length : 1,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GameModeCard(
                                    onTap: () {
                                      print('TAPPED');
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => SubHomePage(
                                                name: categories[index].name,
                                                title: categories[index].title,
                                              )));
                                    },
                                    description: categories[index].description,
                                    icon: categories[index].imageUrl,
                                    title: categories[index].title,
                                    name: categories[index].name);
                              })
                          : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.element,
                              ),
                            );
                    }))));
    // !Signout Area
    // Container(
    //     // color: Colors.grey[100],
    //     child: IconButton(
    //         icon: Icon(
    //           Icons.no_encryption,
    //           color: Colors.white60,
    //         ),
    //         onPressed: () {
    //           showDialog(
    //               context: context,
    //               builder: (context) => AlertDialog(
    //                     title: Text(
    //                       "bebkeler",
    //                     ),
    //                     content: Text("Sign out?"),
    //                     actions: <Widget>[
    //                       FlatButton(
    //                         onPressed: () {
    //                           Navigator.of(context).pop();
    //                         },
    //                         child: Text(
    //                           'No',
    //                         ),
    //                       ),
    //                       FlatButton(
    //                         onPressed: () async {
    //                           setState(() => loading = true);
    //                           await _auth.signOut().whenComplete(() {
    //                             setState(() => loading = false);
    //                             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
    //                               return LoginPage();
    //                             }), ModalRoute.withName('/'));
    //                           });
    //                         },
    //                         child: Text(
    //                           'Yes',
    //                         ),
    //                       )
    //                     ],
    //                   ));
    //         })),
  }
}
