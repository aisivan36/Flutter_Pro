import 'package:flutter/material.dart';

///In Dart, `typedef` can be used as a `pointer` that `references` a `function`.
///This is because we want to call the function, with the correct parameters, from the relevant button.
typedef CallbackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  /// A brief explanation of this.
  /// You may have noticed that the parameters are included in curly brackets [({})] and have a [@required] annotation. This is because we are using named parameters here.
  ///  The purpose of using named parameters is that when you call the function and pass values, you also specify the name of the parameter you are setting.
  ///  For example, when creating an instance of [ProductivityButton],
  /// you can use the syntax [ProductivityButton (color: Colors.blueAccent, text: 'Hello World', onPressed: doSomething, size: 150)].
  /// As named parameters are referenced by name, they can be used in any order. Named parameters are optional,
  ///  but you can annotate them with the @required annotation to indicate that the parameter is mandatory.
  ///
  ProductivityButton({
    required this.color,
    required this.text,
    required this.onPressed,
    required this.size,
  }) : super();

///// =============The end of the explanation.================

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.size,
    );
  }
}
