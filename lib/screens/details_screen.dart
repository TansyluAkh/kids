import 'package:bebkeler/models/wordpage.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bebkeler/models/Colors.dart';

import 'copyhome.dart';
class DetailsScreen extends StatelessWidget {
  final name;
  final doc;
  const DetailsScreen({Key key, this.name, this.doc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;
    return FutureBuilder(
            future: getWordsData(name, doc),
            builder: (BuildContext context, AsyncSnapshot text) {
              print(text.data);
              var product = text.data;
              return text.data != null
                  ? Scaffold(
                  backgroundColor: yellow,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: elementscolor, //change your color here
                    ),
                    systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                    title: Text(
                      capitalize(product.tatword),
                      style: Theme.of(context).textTheme.headline4.copyWith(color: elementscolor, decoration: TextDecoration.underline)
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                    ),
                    backgroundColor: Colors.transparent,
                    // Colors.white.withOpacity(0.1),
                    elevation: 0,
                  ),

                  body: Padding(
                    padding: EdgeInsets.all(15),
                      child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          children: [Text(product.definition, style: Theme.of(context).textTheme.headline6),
                            SizedBox(height: height*0.05),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(product.image_url, fit: BoxFit.cover, width: MediaQuery.of(context).size.width * 0.7),
                            ),
                            SizedBox(height: height*0.05),
                        ElevatedButton(

                          style: ButtonStyle(
                              elevation:  MaterialStateProperty.all<double>(10.0),
                              shadowColor: MaterialStateProperty.all<Color>(elementscolor),
                              shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(
                                  side: BorderSide(color: elementscolor)
                              )), backgroundColor: MaterialStateProperty.all<Color>(elementscolor),
                              minimumSize: MaterialStateProperty.all<Size>(Size(height*0.12, height*0.12))),
                          //TODO Navigate to real training screen
                            onPressed: () { Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage()));
              },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Уйна',
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ))
                      ])))
                  : Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ));
            });
  }
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
