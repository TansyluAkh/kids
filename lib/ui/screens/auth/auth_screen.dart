import 'dart:io';

import 'package:bebkeler/infrastructure/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import '../home_screen.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_bg.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.dstATop),
                ),
              ),
              // color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: NetworkImage('https://s9.gifyu.com/images/indigo1.png'),
                      height: 150.0,
                    ),
                    SizedBox(height: 30),
                    _signInButton(context),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _signInButton(context) {
    if (Platform.isAndroid) {
      return SignInButton(Buttons.GoogleDark, onPressed: () async {
        await signIn(context, SignInProvider.google);
      });
    }
    if (Platform.isIOS) {
      return Column(
        children: [
          SignInButton(Buttons.AppleDark, onPressed: () async {
            await signIn(context, SignInProvider.google);
          }),
          SignInButton(Buttons.GoogleDark, onPressed: () async {
            await signIn(context, SignInProvider.google);
          })
        ],
      );
    }
    throw UnsupportedError('Platform is not supported');
  }

  Future signIn(BuildContext context, SignInProvider provider) {
    if (isLoading) return Future.value();

    setState(() => isLoading = true);

    return AuthService.instance.signIn(provider).whenComplete(() {
      setState(() => isLoading = false);
      if (AuthService.instance.isAuthenticated)
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
}
