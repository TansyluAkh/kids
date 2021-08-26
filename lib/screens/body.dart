import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/models/Colors.dart';

class Body extends StatelessWidget {
  final product;

  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(kDefaultPaddin),
        child: Column(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  product.tatword,
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color: elementscolor, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: kDefaultPaddin),
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Үрнәк: ',
                      style: TextStyle(
                        fontSize: 20,
                        color: elementscolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                        text: product.sentence,
                        style: TextStyle(
                          fontSize: 20,
                          color: elementscolor,
                        ))
                  ])),
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Билгеләмә: ',
                      style: TextStyle(
                        fontSize: 20,
                        color: elementscolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                        text: product.definition,
                        style: TextStyle(
                          fontSize: 20,
                          color: elementscolor,
                        ))
                  ]))
            ],
          ),
          Expanded(
            child: Stack(alignment: Alignment.center, children: [
              Blob.fromID(
                id: ['9-6-805993'],
                size: MediaQuery.of(context).size.height * 0.5,
                styles: BlobStyles(color: elementscolor),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(product.image_url, fit: BoxFit.scaleDown),
              ),
            ]),
          ),
          ElevatedButton(
            //TODO Navigate to real training screen
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('өйрәтү',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ))
        ]));
  }
}
