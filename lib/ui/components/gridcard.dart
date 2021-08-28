
import 'package:bebkeler/ui/screens/details_screen.dart';
import 'package:bebkeler/ui/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final String name;
  final String image;
  final String doc;
  final String title;
  GridCard({@required this.title, @required this.name, @required this.doc,
    @required this.image,});

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
                onTap: (){print('TAPPED GRIDWORD');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsScreen(name: name, doc: doc)));},
                child: Stack(
                  children:[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.purple, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage( image: NetworkImage(image), fit: BoxFit.cover))),
                    Positioned(
                      bottom: 10,
                      left: 5,
                      child:Chip(
                        label: Text(title),
                        backgroundColor: AppColors.purple,
                        labelStyle:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        elevation: 7,
                        shadowColor: Colors.black.withOpacity(0.7),
                      ),
                    )
                  ],
                ))));
  }
}