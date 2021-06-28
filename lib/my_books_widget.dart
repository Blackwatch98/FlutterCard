import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBooks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Moje książki"),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      body: ListView(
      ),
    );
  }
}

class ListOfMyBooks extends StatefulWidget {
  var files;

  @override
  State<StatefulWidget> createState() {
    return _ListOfMyBooks();
  }
}

class _ListOfMyBooks extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}