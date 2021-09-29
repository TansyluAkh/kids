import 'package:bebkeler/core/info/info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'info.dart';

Future<Info> getInfo(String name, String docname) async {
    print(name);
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection(name).doc(docname).get();
    final data = doc.data() as Map<String, dynamic>;
    print(data);
    Info info = Info.fromMap(data);
    print(info);
    return info;
  }

