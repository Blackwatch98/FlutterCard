import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  File myFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Moje książki"),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () async {
          await createAlertDialog(context);
        },
      ),
      body: ListView(
      ),
    );
  }

  Future<void> createAlertDialog(BuildContext context) async {
    final fileName = myFile != null ? myFile.path : 'No File Selected';
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
                    primary: Colors.green,
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
            SizedBox(height: 48,)
          ],
        ),
      );
      });
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
}
