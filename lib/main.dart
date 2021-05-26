import 'package:flutter/material.dart';
// import 'package:img_pict/ch2/home.dart';
import 'package:img_pict/ch3/homech3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A title app',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: HomeCh3(),
    );
  }
}
