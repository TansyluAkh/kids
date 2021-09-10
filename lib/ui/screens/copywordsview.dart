import 'package:bebkeler/core/words/word_repository.dart';
import 'package:bebkeler/infrastructure/auth/auth_service.dart';
import 'package:bebkeler/ui/components/gridcard.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';

import 'auth/auth_screen.dart';

class WordsPage extends StatefulWidget {
  final name;
  final title;

  WordsPage({Key key, @required this.name, @required this.title}) : super(key: key);

  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColors.element, //change your color here
          ),
          centerTitle: false,
          title: Text(capitalize(widget.title),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
                fontSize: 22,
                color: AppColors.darkBlue,
              )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          backgroundColor: Colors.transparent,
          // Colors.white.withOpacity(0.1),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                  child: FutureBuilder(
                      future: WordRepository.instance.getWord(widget.name),
                      builder: (BuildContext context, AsyncSnapshot text) {
                        print(text.data);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            text.data != null
                                ? GridView.builder(
                                    padding: EdgeInsets.all(10.0),
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: text.data.length,
                                    itemBuilder: (context, index) {
                                      print(text.data);
                                      return GridCard(
                                          item: text.data[index],
                                          all_items: text.data,
                                          index: index);
                                    })
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.element,
                                    ),
                                  ),
                            Container(
                                // color: Colors.grey[100],
                                child: IconButton(
                                    icon: Icon(
                                      Icons.no_encryption,
                                      color: Colors.white60,
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
                                                      await AuthService.instance
                                                          .signOut()
                                                          .whenComplete(() {
                                                        setState(() => loading = false);
                                                        Navigator.of(context).pushAndRemoveUntil(
                                                            MaterialPageRoute(builder: (context) {
                                                          return AuthScreen();
                                                        }), ModalRoute.withName('/'));
                                                      });
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                    ),
                                                  )
                                                ],
                                              ));
                                    })),
                          ],
                        );
                      })))
        ])));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
