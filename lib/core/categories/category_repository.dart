import 'package:bebkeler/core/categories/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  final FirebaseFirestore _firebase;

  CategoryRepository(this._firebase);

  static CategoryRepository get instance => CategoryRepository(FirebaseFirestore.instance);

  Future<List<dynamic>> getCategories(String name) async {
    CollectionReference categories = _firebase.collection(name);
    List arr = [];
    QuerySnapshot querySnapshot =
        await categories.orderBy('name', descending: false).get();
    final allData = querySnapshot.docs.forEach((element) async {
      var subArr = [];
      var item =  Category.fromMap(element.data() as Map<String, dynamic>);
      print(item.name);
      CollectionReference subs = FirebaseFirestore.instance.collection('categories').doc(item.name).collection('subs');
      QuerySnapshot subquerySnapshot = await subs.get();
      final subData = subquerySnapshot.docs.forEach((subel) async {
        var sub =  Category.fromMap(subel.data() as Map<String, dynamic>);
        subArr.add(sub);
        print(sub);
        print('SUB');
      });
      arr.add([item, subArr]);
    });
    print(arr);
    print('ARR');
    return arr;}}