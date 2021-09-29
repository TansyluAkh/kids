import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Info {
  final String rus_desc;
  final String tat_desc;
  final String imageUrl;
  final String social;
  Info({this.tat_desc, this.rus_desc, this.imageUrl, this.social});

  static Info fromMap(Map<String, dynamic> map) {
    return Info(
       social: map['social'].toString(),
        rus_desc: map['rus_desc'].toString(),
        tat_desc: map['tat_desc'].toString(),
        imageUrl: map['image'].toString(),
       );
  }
}

