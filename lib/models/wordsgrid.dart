import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WordGrid {
  final String image;
  final String name;
  final String desc;
  final String title;
  final String doc;
  WordGrid({Key key, this.image, this.title, this.name, this.desc, this.doc});
}

Future getWordGridData(name) async {
  print(name+'GETWORDGRID');
  CollectionReference categories = FirebaseFirestore.instance.collection(name);
  List<Object> arr = [];
  QuerySnapshot querySnapshot =
      await categories.orderBy('word', descending: false).get();
  final allData = querySnapshot.docs.forEach((element) {
    Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    print(data);
    WordGrid gridItem = WordGrid(
        image: data['image_url'].toString(),
        name: data['category1'].toString() + '_'+ data['category2'].toString(),
        title: data['tatword'].toString(),
        doc: data['word'].toString(),
        desc: '');
    arr.add(gridItem);
  });
  print(arr);
  return arr;
}
