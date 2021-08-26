import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/models/Colors.dart';


class Body extends StatelessWidget {
  final product;

  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Padding(
      padding: const EdgeInsets.all(kDefaultPaddin),
      child:
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(constraints: BoxConstraints(maxHeight: height * 0.1), child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
        Text(
            product.tatword,
            style: Theme
                .of(context)
                .textTheme
                .headline4
                .copyWith(
                color: elementscolor, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Text(product.sentence,
                  style: TextStyle(
                    fontSize: 20,
                    color: elementscolor,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 10,
                  overflow: TextOverflow.clip,
                ),
            ],
          )),
        Stack(
        children:[
        Align(alignment:Alignment.center,
    child:
     Blob.fromID(
          id: ['9-6-805993'],
          size: height*0.6,
          styles: BlobStyles(
           color: elementscolor),
    )),

    ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height * 0.4, maxWidth: width*0.7),
           child: Align(alignment:Alignment.centerRight,
               child:Image.network(product.image_url, fit: BoxFit.scaleDown)))]),
          ]));
  }
}
