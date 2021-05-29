import 'package:flutter/material.dart';
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

  /// Animation move Set to 5
  double increment = 5;

  /// Make a ball move down and left.
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  late Animation<double> animation;
  late AnimationController controller;

  ///To check whether the ball has reached its border and will change the direction whenever it wants.
  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= width! - 50 && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= height! - 50 && vDir == Direction.down) {
      vDir = Direction.up;
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
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
    animation.addListener(() {
      setState(() {
        (hDir == Direction.right) ? posX += increment : posX -= increment;
        (vDir == Direction.down) ? posY += increment : posY -= increment;
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
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
              child: Ball(),
              top: posY,
              left: posX,
            ),
            Positioned(
              child: Bat(
                width: batWidth,
                height: batHeight,
              ),
              bottom: 0,
            ),
          ],
        );
      },
    );
  }
}
