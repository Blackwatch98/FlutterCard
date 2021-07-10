import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_card/models/firestorage_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FirebaseApi {
  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print("An error has occurred:" + e.message);
      return null;
    }
  }

  static UploadTask uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      print("An error has occurred:" + e.message);
      return null;
    }
  }

  static Future<List<FirestorageFile>> listExample(String user) async {
    final result = await FirebaseStorage.instance.ref(user).listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
        final ref = result.items[index];
        final name = ref.name;
        final file = FirestorageFile(ref : ref, name : name, url : url);
        return MapEntry(index, file);
    }).values.toList();
  }

  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<File> loadFirebase(String url) async {
    try {
      final refPDF = FirebaseStorage.instance.ref('files').child(url);
      final bytes = await refPDF.getData();

      return _getFile(url, bytes);
    } catch (e) {
      print("An error has occurred:" + e.message);
      return null;
    }
  }

  static Future<File> _getFile(String url, List<int> bytes) async {
    final filename = p.basename(url);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}