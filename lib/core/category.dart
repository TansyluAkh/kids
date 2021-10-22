import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String title;
  final String name;
  final String description;
  final String imageUrl;

  Category(
      {required this.title, required this.name, required this.description, required this.imageUrl});
}

Future<List<Category>> getCategories(String name) async {
  final firebase = FirebaseFirestore.instance;
  final categories = firebase.collection(name);
  final snapshot = await categories.orderBy('name', descending: false).get();
  return snapshot.docs.map((e) => _mapFirebaseData(e.data() as Map<String, dynamic>)).toList();
}

Category _mapFirebaseData(Map<String, dynamic> map) {
  return Category(
    title: map['tat'].toString(),
    name: map['name'].toString(),
    description: map['desc'].toString() != "NaN" ? map['desc'].toString() : ' ',
    imageUrl: map['image'].toString(),
  );
}
