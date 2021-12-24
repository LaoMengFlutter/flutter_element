import 'package:flutter/material.dart';

class ECollapseTransition extends AnimatedWidget {
  ECollapseTransition({
    Key? key,
    required this.collapse,
    required this.child,
    this.direction = CollapseDirection.down,
  }) : super(key: key, listenable: collapse);

  final Widget child;
  final Animation<double> collapse;
  final CollapseDirection direction;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: _getAlignment(direction),
        heightFactor: _getHeightFactor(direction, collapse.value),
        widthFactor: _getWidthFactor(direction, collapse.value),
        child: child,
      ),
    );
  }

  Alignment _getAlignment(CollapseDirection direction) {
    switch (direction) {
      case CollapseDirection.down:
        return Alignment.topCenter;
      case CollapseDirection.top:
        return Alignment.bottomCenter;
      case CollapseDirection.left:
        return Alignment.centerRight;
      case CollapseDirection.right:
        return Alignment.centerLeft;
    }
  }

  double _getHeightFactor(CollapseDirection direction, double value) {
    switch (direction) {
      case CollapseDirection.down:
        return value;
      case CollapseDirection.top:
        return value;
      case CollapseDirection.left:
        return 1;
      case CollapseDirection.right:
        return 1;
    }
  }

  double _getWidthFactor(CollapseDirection direction, double value) {
    switch (direction) {
      case CollapseDirection.down:
        return 1;
      case CollapseDirection.top:
        return 1;
      case CollapseDirection.left:
        return 1 - value;
      case CollapseDirection.right:
        return value;
    }
  }
}

enum CollapseDirection {
  //向下
  down,
  //向上
  top,
  //向左
  left,
  //向右
  right,
}
