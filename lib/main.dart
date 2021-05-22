import 'package:flutter/material.dart';
import 'package:img_pict/ch2/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: HomeCh2(),
    );
  }
}
