import 'package:bebkeler/core/info/info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'info.dart';

Future<Info> getInfo(String name, String docName) async {
  print(name);
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection(name).doc(docName).get();
  final data = doc.data() as Map<String, dynamic>;
  print(data);
  Info info = Info.fromMap(data);
  print(info);
  return info;
}
