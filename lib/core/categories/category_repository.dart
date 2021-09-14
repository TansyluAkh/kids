import 'package:bebkeler/core/categories/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  final FirebaseFirestore _firebase;

  CategoryRepository(this._firebase);

  static CategoryRepository get instance => CategoryRepository(FirebaseFirestore.instance);

  Future<List<Category>> getCategories(String name) async {
    CollectionReference categories = _firebase.collection(name);
    QuerySnapshot querySnapshot =
    await categories.orderBy('name', descending: false).get();
    return querySnapshot.docs
        .map((e) => Category.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
}