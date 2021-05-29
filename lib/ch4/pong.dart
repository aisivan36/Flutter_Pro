import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'ball.dart';
import 'bat.dart';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() {
    return _PongState();
  }
}

class _PongState extends State<Pong> with TickerProviderStateMixin {
  double? width;
  double? height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  /// Scores game
  int score = 0;

  /// For vertical and horizontal direction.
  double randX = 1;
  double randY = 1;

  ///Random numbers from the `dart:math`
  ///The `Random` generates random bool, int or double values. It's `next int` method return a random `interger` from 0,
  /// inclusive, and the parameter you pass, exclusive. In this case it will be a number between 0 and 100 inclusive.
  /// To that we add 50 and we add the generated interger obtiaining a number between 50 and 150, and we then divede it by 100, Thus, the function will return a number between 0.5 and 1.5.
  double randomNumber() {
    /// This is a number between 0.5 and 1.5.
    var ran = Random();
    int myNum = ran.nextInt(301);
    return (190 + myNum) / 300;
  }

  /// Animation move Set to 5
  final double increment = 5;

  /// Make a ball move down and left.
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  late Animation<double> animation;
  late AnimationController controller;

  ///To check whether the ball has reached its border and will change the direction whenever it wants.
  void checkBorders() {
    final double diameter = 50;

    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width! - diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height! - diameter - batHeight && vDir == Direction.down) {
      ///Check if the bat is here, otherwise loose.
      if (posX >= (batPosition - diameter) &&
          posX <= (batPosition + batWidth + diameter)) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score++;
        });
      } else {
        controller.stop();

        /// We call the `showMessage()` to ask the user whether they want to play again or not.
        showMessage(context);
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
    }

    /// To check the scores each tiem when the ball is touching the bat.
    // if (posX >= (batPosition - diameter) &&
    //     posX <= (batPosition + batWidth + diameter)) {
    //   vDir = Direction.up;
    //   randY = randomNumber();
    //   safeSetState(() {
    //     score++;
    //   });
    // }
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;

    /// To make the animation going for as is 10k minutes
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 10000),
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);

    /// we use ternary opererator to move the ball based on the direction, if the horizontal direction is `Direction.right`,
    ///  we need to increment the horizontal position, other otherwise, we need to decrement it.
    /// The same logic applies to the vertical postion as well.
    /// We increment posY when the direction is `down`, and we decrement it when the direction is `up`. Afetr each movement,
    ///  we call the `checkBorders()` method to see whether it's necessary to change direction.
    ///
    animation.addListener(() {
      /// call `safeSetState()` instead of `setState()`
      safeSetState(() {
        (hDir == Direction.right)
            ? posX += ((increment * randX).round())
            : posX -= ((increment * randX).round());
        (vDir == Direction.down)
            ? posY += ((increment * randX).round())
            : posY -= ((increment * randX).round());
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  /// To make it `bat` move controller
  void moveBat(DragUpdateDetails updateDetails) {
    /// call `safeSetState()` instead of `setState()`
    safeSetState(() {
      batPosition += updateDetails.delta.dx;
    });
  }

  /// This method will be automatically called when the _PongSate object is discarded.
  /// Then inside this method we add and called `dispose()` of the `animation controller` to prevent memory leaks
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// This method to prevent getting errors when the object is no longer usable.
  /// The mounted property checks whether the state object is currently mounted.
  /// State object is `mounted` before calling the `initState()` and till `dispose()` is called.
  /// Calling `setState()` when it's `mounted` is not right it will raises an error.
  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  /// To show a message when the game is over
  void showMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Heh! Kue arep maen neh opo orak?'),
        actions: [
          MaterialButton(
            child: Text('Iyo a'),
            onPressed: () {
              ///If the users press ` iyo or yes` it will re-render the `setState()` and reset the ball position as well as the scores.
              setState(() {
                posX = 0;
                posY = 0;
                score = 0;
              });
              Navigator.of(context).pop();
              controller.repeat();
            },
          ),
          MaterialButton(
            child: Text('Emoh aku!'),
            onPressed: () {
              return closeApp();
              // Navigator.of(context).pop();
              // dispose(); //Then exits, `dispose()` is called.
            },
          ),
        ],
      ),
    );
  }

  ///This method to close the app.
  void closeApp() {
    if (Platform.isAndroid) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      dispose();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width! / 5;
        batHeight = height! / 20;
        return Stack(
          children: [
            Positioned(
              top: 0,
              right: 24,
              child: Text(
                'Score: ' + score.toString(),
              ),
            ),
            Positioned(
              child: Ball(),
              top: posY,
              left: posX,
            ),
            Positioned(
              bottom: 0,
              left: batPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (update) => moveBat(update),
                child: Bat(
                  width: batWidth,
                  height: batHeight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
