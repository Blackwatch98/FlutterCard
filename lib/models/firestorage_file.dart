import 'package:firebase_storage/firebase_storage.dart';

class FirestorageFile {

  final Reference ref;
  final String name;
  final String url;

  const FirestorageFile({
    this.ref,
    this.name,
    this.url,
  });
}