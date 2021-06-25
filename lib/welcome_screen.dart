import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 80,
                child: Text(
                  "FlutterCard",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Railway",
                    foreground: Paint() ..color = Colors.blue ..strokeWidth = 2.0
                      ..style = PaintingStyle.stroke
                  ),
                ),
              ),
              Positioned(
                top: 150,
                child: Text(
                  "Co dzisiaj poczytamy?",
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ),
              Positioned(
                top: 150,
                child: Image.asset(
                    "assets/book.png",
                    width: size.width * 0.7,
                ),
              ),
              Positioned(
                top: 450,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: Colors.blue,
                  onPressed: () {},
                  child: Text(
                    "Działamy!",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                ),
                ),
              ),
            ],
          ),
        )
    );
  }
}