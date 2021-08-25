import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WordGrid {
  final String image;
  final String name;
  final String desc;
  final String title;
  WordGrid({Key key, this.image, this.title, this.name, this.desc});
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
        name: data['category1'].toString() + '/'+ data['category2'].toString()+ '/'+ data['word'].toString(),
        title: data['tatword'].toString(),
        desc: '');
    arr.add(gridItem);
  });
  print(arr);
  return arr;
}
