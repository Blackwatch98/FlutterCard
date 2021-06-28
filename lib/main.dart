import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fcApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fcApp,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print('You have an error: ${snapshot.error.toString()}');
            return Text('Something gone wrong!');
          } else if(snapshot.hasData) {
            return WelcomeScreen();
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}

