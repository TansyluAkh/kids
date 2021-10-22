import 'package:cloud_firestore/cloud_firestore.dart';

class AboutInfo {
  final String rusDescription;
  final String tatDescription;
  final String imageUrl;
  final String social;

  AboutInfo(
      {required this.tatDescription,
      required this.rusDescription,
      required this.imageUrl,
      required this.social});
}

Future<AboutInfo> getAboutInfo(String name, String docName) async {
  final doc = await FirebaseFirestore.instance.collection(name).doc(docName).get();
  final data = doc.data() as Map<String, dynamic>;
  AboutInfo info = _mapFirebaseData(data);
  return info;
}

AboutInfo _mapFirebaseData(Map<String, dynamic> map) {
  return AboutInfo(
    social: map['social'].toString(),
    rusDescription: map['rus_desc'].toString(),
    tatDescription: map['tat_desc'].toString(),
    imageUrl: map['image'].toString(),
  );
}
