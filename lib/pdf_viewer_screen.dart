

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart' as p;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pdf_text/pdf_text.dart';

class PDFViewerScreen extends StatefulWidget {

  final File file;

  const PDFViewerScreen({
    @required this.file,
  });

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {

  PDFDoc pdfDoc;

  Widget build(BuildContext context) {
    final name = p.basename(widget.file.path);

    _pickPDFText();

    return Scaffold(
        appBar: AppBar(
        title: Text(name)),

        //ROZWIĄZANIE SŁABE
        // body: SfPdfViewer.file(
        //     widget.file,
        //   enableTextSelection: true,
        // ),

        body: PDFView(
          filePath: widget.file.path,
          enableSwipe: true,
          swipeHorizontal: true,
        )
    );
  }

  Future _pickPDFText() async {
      pdfDoc = await PDFDoc.fromFile(widget.file);

      String text = await pdfDoc.pageAt(1).text;
      print(text);
      print("-------------------------");
      //setState(() {});
  }
}