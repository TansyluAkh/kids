import 'package:flutter/material.dart';
import 'package:bebkeler/screens/login_screen.dart';
import 'package:bebkeler/models/category.dart';
import 'package:bebkeler/services/auth_service.dart';
import 'package:bebkeler/components/game_mode_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsetsDirectional.only(top: 30.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFFFFE484).withOpacity(1),
                    Color(0xFFFFCC33).withOpacity(1)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // !Logo Area
              Expanded(
                flex: 3,
                child: Container(
                  child: Image(
                    image: NetworkImage('https://s6.gifyu.com/images/bklogo.png'),
                  ),
                ),
              ),
              // !Game Modes Cards
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      child: FutureBuilder(
                      future: getCategoriesData('categories'),
                      builder: (BuildContext context, AsyncSnapshot text) {
                        print(text.data);
                      return text.data != null ?
                        ListView.builder(
                          itemCount:  text.data != null ? text.data[0].sub.length : 1,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(text.data);
                          return GameModeCard(ontap: (){print('TAPPED'); print(text.data[index].sub);}, sub: text.data[index].sub, description: text.data[index].desc, icon: text.data[index].image, title: text.data[index].name,);}
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
      ),
    );
  }
}
