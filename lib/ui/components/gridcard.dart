import 'package:bebkeler/ui/screens/swiper.dart';
import 'package:bebkeler/ui/shared/colors.dart';
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
                onTap: () {
                  print('TAPPED GRIDWORD');
                  all_items.remove(all_items[index]);
                  all_items.insert(0, item);
                  print(all_items);
                  print('ALL ITEMS');
                  print(all_items[0].imageUrl);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Swiper(items: all_items)));
                },
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.element, width: 5),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(item.imageUrl), fit: BoxFit.cover))),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Chip(
                        //side: BorderSide(width: 2, color: AppColors.element),
                        label: Text(capitalize(item.tatarWord)),
                        backgroundColor: AppColors.white,
                        labelStyle: TextStyle(
                            color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 12),
                        elevation: 7,
                        shadowColor: Colors.black.withOpacity(0.7),
                      ),
                    )
                  ],
                ))));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
