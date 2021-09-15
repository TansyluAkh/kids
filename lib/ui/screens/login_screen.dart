import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/screens/home_screen.dart';
import 'package:bebkeler/services/auth_service.dart';
import 'package:bebkeler/ui/components/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_bg.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.dstATop),
                ),
              ),
              // color: Colors.white,\child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: NetworkImage('https://s9.gifyu.com/images/indigo1.png'),
                      width: width*0.8,
                      height: height*0.25,
                    ),
                    SizedBox(height: 30),
                    _signInButton(),
                  ],
                ),
              ),
            );
  }

  Widget _signInButton() {
    return RaisedButton(
      color: AppColors.white,
      splashColor: AppColors.white,
      onPressed: () async {
        setState(() => loading = true);

        await _auth.signInWithGoogle().whenComplete(() {
          setState(() => loading = false);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
            return HomePage();
          }), ModalRoute.withName('/'));
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      // highlightElevation: 0,
      // borderSide: BorderSide(color: Colors.grey),
      child:
        Chip(
          backgroundColor: AppColors.white,
          avatar:
            Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
            label: Text(
                'Вход',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              )));}}