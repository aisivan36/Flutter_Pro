import 'package:flutter/material.dart';
import 'pong.dart';

class HomeCh4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pong Demo',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Simple Pong"),
        ),
        body: SafeArea(
          child: Pong(),
        ),
      ),
    );
  }
}
