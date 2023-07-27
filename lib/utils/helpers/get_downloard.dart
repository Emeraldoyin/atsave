import 'package:firebase_storage/firebase_storage.dart';

Future<String> getDownloadUrl(int id) async {
  final path = FirebaseStorage.instance.ref().child('$id.jpeg');
  return await path.getDownloadURL();
}
