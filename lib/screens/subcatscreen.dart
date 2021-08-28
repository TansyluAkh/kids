import 'package:bebkeler/models/Colors.dart';
import 'package:bebkeler/screens/wordsview.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/screens/login_screen.dart';
import 'package:bebkeler/models/category.dart';
import 'package:bebkeler/services/auth_service.dart';
import 'package:bebkeler/components/game_mode_card.dart';
import 'package:flutter/services.dart';

class SubHomePage extends StatefulWidget {
  final name;
  final title;
  SubHomePage({Key key, @required this.name, @required this.title})
      : super(key: key);
  @override
  _SubHomePageState createState() => _SubHomePageState();
}

class _SubHomePageState extends State<SubHomePage> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellow,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: elementscolor, //change your color here
        ),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: false,
        title: Text(widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
              fontSize: 20,
              color: purple,
            )),
        shape: RoundedRectangleBorder(
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
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      child: FutureBuilder(
                      future: getCategoriesData('categories/'+widget.name+'/subs'),
                      builder: (BuildContext context, AsyncSnapshot text) {
                        print(text.data);
                      return text.data != null ?
                        ListView.builder(
                          itemCount:  text.data != null ? text.data.length : 1,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(text.data);
                          return GameModeCard(ontap: (){
                            print('TAPPED SUBS'+text.data[index].name);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WordsPage(name:text.data[index].name, title: text.data[index].title)));
                            },
                              description: text.data[index].desc, icon: text.data[index].image, title: text.data[index].title, name: text.data[index].name);}
                          )
                              :Center(child:CircularProgressIndicator(
                          backgroundColor: Colors.white,),
                        );})))),
                // !Signout Area
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
                                        await _auth.signOut().whenComplete(() {
                                          setState(() => loading = false);
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) {
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
                      })),
            ],
          ),
        ),
      );
  }
}
