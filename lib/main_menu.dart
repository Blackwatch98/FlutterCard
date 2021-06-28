import 'package:flutter/material.dart';
import 'package:flutter_card/my_books_widget.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      var crossAxisCount = 2;
      return Scaffold(
        appBar: AppBar(title: Text("Menu Główne"),),
        backgroundColor: Colors.blue[100],
        body: Container(
          padding: EdgeInsets.all(30.0),
          height: size.height,
          width: size.width,
          child: GridView.count(
            crossAxisCount: crossAxisCount,
            children: <Widget>[
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyBooks()),
                    );
                  },
                  splashColor: Colors.blue,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.menu_book, size: 70.0,),
                        Text("Moje książki", style: TextStyle(fontSize: 17.0))
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                    onTap: () {},
                    splashColor: Colors.blue,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.now_wallpaper, size: 70.0,),
                          Text("Fiszki", style: TextStyle(fontSize: 17.0))
                        ],
                      ),
                    ),
                ),
              ),
              Card(
                child: InkWell(
                    onTap: () {},
                    splashColor: Colors.blue,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.settings, size: 70.0,),
                          Text("Ustawienia", style: TextStyle(fontSize: 17.0))
                        ],
                      ),
                    ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.blue,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.person, size: 70.0,),
                        Text("O autorze", style: TextStyle(fontSize: 17.0))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
