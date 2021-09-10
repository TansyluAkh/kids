import 'package:bebkeler/infrastructure/auth/auth_service.dart';
import 'package:bebkeler/ui/components/maincategorycard.dart';
import 'package:bebkeler/ui/screens/spelling_bee/home.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/shared/colors.dart';

import 'auth/auth_screen.dart';
import 'math_ninja/home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GameModeCard(
                          title: 'Math Ninja',
                          description: 'The Robber is here to test you math skills',
                          icon: "https://s6.gifyu.com/images/cube.png",
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MNHomePage(),
                            ));
                          },
                        ),
                        GameModeCard(
                          title: 'Spelling Bee',
                          description: 'Challenge our AI with your spelling skills',
                          icon: "https://s6.gifyu.com/images/cube.png",
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SBHomePage(),
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                )),
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
                                      await AuthService.instance.signOut().whenComplete(() {
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
        ));
  }
}
