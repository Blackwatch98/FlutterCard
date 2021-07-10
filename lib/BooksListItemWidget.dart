import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card/models/firestorage_file.dart';
import 'firebase_storage.dart';
import 'pdf_viewer_screen.dart';
import 'dart:io';

class BooksListItemWidget extends StatelessWidget{
  final FirestorageFile item;
  final Animation animation;
  final VoidCallback onClicked;

  const BooksListItemWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    Key key,
}) : super(key : key);

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white
    ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        leading: Icon(Icons.book),
        title: Text(item.name),
        onTap: () async {
          final file = await FirebaseApi.loadFirebase(item.name);

          if (file == null) return;
          openPDF(context, file);
        },
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red,),
          onPressed: onClicked,
        ),
      )
  );

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerScreen(file: file)),
  );


}