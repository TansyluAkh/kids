import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category {
  final String image;
  final String name;
  final String desc;
  final String title;
  Category({Key key, this.image, this.title, this.name, this.desc});
}

Future getCategoriesData(name) async {
  CollectionReference categories = FirebaseFirestore.instance.collection(name);
  List<Object> arr = [];
  QuerySnapshot querySnapshot =
      await categories.orderBy('name', descending: false).get();
  final allData = querySnapshot.docs.forEach((element) {
    Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    print(data);
    Category categoryItem = Category(
        image: data['image'].toString(),
        name: data['name'].toString(),
        title: data['tat'].toString(),
        desc: data['desc'].toString());
    arr.add(categoryItem);

  });
  print(arr);
  return arr;
}

Category categoryInit = Category(
  image: '',
  name: '',
  desc: '',
  title: '',
);

List initData = [categoryInit];
