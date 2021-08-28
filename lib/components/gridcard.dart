
import 'package:bebkeler/screens/details_screen.dart';
import 'package:bebkeler/models/Colors.dart';
import 'package:bebkeler/screens/swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final item;
  final all_items;
  final index;
  GridCard({@required this.item, this.all_items, this.index});

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
                onTap: (){print('TAPPED GRIDWORD');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Swiper(items: all_items, index:index)));},
                child: Stack(
                  children:[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: purple, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage( image: NetworkImage(item.image_url), fit: BoxFit.cover))),
                    Positioned(
                      bottom: 10,
                      left: 5,
                      child:Chip(
                        label: Text(item.tatword),
                        backgroundColor: purple,
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