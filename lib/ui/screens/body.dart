import 'package:bebkeler/core/words/word.dart';
import 'package:bebkeler/ui/screens/quiz/quiz_screen.dart';
import 'package:bebkeler/ui/screens/quiz/test_data.dart';
import 'package:bebkeler/ui/shared/spacing.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:bebkeler/ui/shared/colors.dart';

class Body extends StatelessWidget {
  final Word product;

  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppSpacing.defaultPadding),
        child: Column(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  product.tatarWord,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: AppColors.element, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: AppSpacing.defaultPadding),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Үрнәк: ',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.element,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: product.sentence,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.element,
                    ))
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Билгеләмә: ',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.element,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                    text: product.definition,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.element,
                    ))
              ]))
            ],
          ),
          Expanded(
            child: Stack(alignment: Alignment.center, children: [
              Blob.fromID(
                id: ['9-6-805993'],
                size: MediaQuery.of(context).size.height * 0.5,
                styles: BlobStyles(color: AppColors.element),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(product.imageUrl, fit: BoxFit.scaleDown),
              ),
            ]),
          ),
          ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => QuzScreen(quiz: getTestQuiz()))),
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
