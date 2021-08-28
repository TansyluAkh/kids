import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WordCard {
  final String tatword;
  final String definition;
  final String sentence;
  final String tatcategory;
  final String word;
  final String image;
  final String image_url;
  final String audio1;
  final String audio2;
  final String category1;
  final String category2;
  WordCard({Key key, this.tatword,	this.definition,	this.sentence,	this.tatcategory,	this.word,	this.image,	this.image_url,	this.audio1,	this.audio2,	this.category1,	this.category2});
}

Future getWordsData(name) async {
  CollectionReference categories = FirebaseFirestore.instance.collection(name);
  QuerySnapshot querySnapshot = await categories.get();
  List arr = [];
  final allData = querySnapshot.docs.forEach((element) {
    Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    print(data);
    WordCard WordCardItem = WordCard(
      tatword: data['tatword'].toString(),	definition: data['definition'].toString(),
      sentence: data['sentence'].toString(),	tatcategory: data['tatcategory'].toString(),
      word: data['word'].toString(),	image: data['image'].toString(),
      image_url: data['image_url'].toString(),	audio1: data['audio1'].toString(),
      audio2: data['audio2'].toString(),	category1: data['category1'].toString(),
      category2: data['category2'].toString());
    arr.add(WordCardItem);
    print(WordCardItem.sentence);});
  return arr;
}

