import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category {
  final String title;
  final String name;
  final String description;
  final String imageUrl;
  Category({this.title, this.name, this.description, this.imageUrl});

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
        title: map['tat'].toString(),
        name: map['name'].toString(),
        description: map['desc'].toString() != "NaN" ? map['desc'].toString(): ' ',
        imageUrl: map['image'].toString(),
       );
  }
}

