import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card/models/firestorage_file.dart';
import 'BooksListItemWidget.dart';
import 'firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;


class MyBooksAlertDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyBooksAlertDialog();
  }
}

class _MyBooksAlertDialog extends State<MyBooksAlertDialog> {

  UploadTask myUploadTask;
  File myFile;

  Future<List<FirestorageFile>> files;

  @override
  void initState() {
    super.initState();

    files = FirebaseApi.listExample("files");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Moje książki"),),
      backgroundColor: Colors.blue[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
        onPressed: () async {
          await createAlertDialog(context);
        },
      ),
      body:  FutureBuilder<List<FirestorageFile>> (
        future: files,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                final files = snapshot.data;
                return AnimatedList(
                      initialItemCount: files.length,
                      itemBuilder: (context, index, animation) =>
                        buildItem(files[index], index, animation));
              }
          }
        },
      )
    );
  }

  Widget buildItem(item, int index, Animation<double> animation) =>
    BooksListItemWidget(
      item: item,
      animation: animation,
      onClicked: () => removeItem(index),
    );

  Future<void> createAlertDialog(BuildContext context) async {
    final fileName = myFile != null ? p.basename(myFile.path) : 'No File Selected';
    return await showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text("Dodaj książkę:"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 300),
                child: ElevatedButton.icon(
                  onPressed: () {
                    selectFile();
                    Navigator.of(context).pop();
                  },
                  label: Text('Wybierz plik'),
                  icon: Icon(Icons.attach_file),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
            ),
            SizedBox(height: 8,),
            Text(
              fileName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 48),
            ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 300),
                child: ElevatedButton.icon(
                  onPressed: () {
                    uploadFile();
                  },
                  label: Text('Wyślij plik'),
                  icon: Icon(Icons.cloud_upload_outlined),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
            ),
            SizedBox(height: 20),
            myUploadTask != null ? buildUploadStatus(myUploadTask) : Container(),
          ],
        ),
      );
      });
    }).then((val) {
        files = FirebaseApi.listExample("files");
        setState(() {});
    });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    final extension = p.extension(path);

    if(extension != ".pdf") {
      print("Bad extension error!"); //Needs to be replaced with toast
      return;
    }

    setState(() => myFile = File(path));
    await createAlertDialog(context);
  }

  Future uploadFile() async {
    if (myFile == null) return;

    final fileName = p.basename(myFile.path);
    final destination = 'files/$fileName'; // needs to be updated with current user folder

    myUploadTask = FirebaseApi.uploadFile(destination, myFile);
    setState(() {});

    await createAlertDialog(context);
    Navigator.of(context).pop();

    if (myUploadTask == null) return;
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);


        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );

  void removeItem(int index) {
    //remove metod to implement
  }
}
