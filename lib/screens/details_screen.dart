import 'package:bebkeler/models/wordcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bebkeler/models/Colors.dart';
import 'package:bebkeler/screens/body.dart';

class DetailsScreen extends StatelessWidget {
  final name;
  final doc;
  const DetailsScreen({Key key, this.name, this.doc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellow ,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        leading: Icon(Icons.home, color: purple, size: 35),
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
    // !Game Modes Cards
    Expanded(
    flex: 8,
    child: Padding(
    padding: EdgeInsets.all(10.0),
    child: Container(
          child: FutureBuilder(
          future: getWordsData(name, doc),
          builder: (BuildContext context, AsyncSnapshot text) {
          print(text.data);
          return text.data != null ?
          Body(product: text.data)
        : Center(child:CircularProgressIndicator(
    backgroundColor: Colors.white,));
  }))))])));}

}
