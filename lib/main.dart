import 'package:flutter/material.dart';
import 'package:flutter_carrot/page/app.dart';
import 'package:flutter_carrot/page/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: App(),
    );
  }
}
