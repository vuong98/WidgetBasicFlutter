import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetscomponent/widgets/custom_floating_widget.dart';

// ignore: must_be_immutable
class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  Offset initialOffset;
  final Function(Offset) onPressed;
  final Color? color;
  final BoxShape? shape;
  final double? radius;
  final double? distance ;

  DraggableFloatingActionButton({
    super.key,
    required this.child,
    required this.initialOffset,
    required this.onPressed,
    required this.parentKey,
    this.color,
    this.shape,
    required this.radius,
    this.distance = 60.0,
  });

  final GlobalKey parentKey;

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  bool _isDragging = false;
  late Offset _minOffset;
  late Offset _maxOffset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_setBoundary);
  }

  void _setBoundary(_) {
    try {
      final double maxWidth =
          MediaQuery.of(context).size.width - widget.radius!;
      double maxHeight = MediaQuery.of(context).size.height -
          const Size.fromHeight(kToolbarHeight).height -
          (widget.radius! * 3)- widget.distance!;

      const double minWidth = 0.0;
      double minHeight = widget.distance! + (widget.radius! * 2);
      setState(() {
        _minOffset = Offset(minWidth, minHeight);
        _maxOffset = Offset(maxWidth, maxHeight);
        print("_minOffset = $_minOffset");
        print(_maxOffset);
      });
    } catch (e) {
      print('catch: $e');
    }
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = widget.initialOffset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = widget.initialOffset.dy + pointerMoveEvent.delta.dy;

    if (newOffsetX < _minOffset.dx) {
      newOffsetX = _minOffset.dx;
    } else if (newOffsetX > _maxOffset.dx) {
      newOffsetX = _maxOffset.dx;
    }

    if (newOffsetY < _minOffset.dy) {
      newOffsetY = _minOffset.dy;
    } else if (newOffsetY > _maxOffset.dy) {
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      widget.initialOffset = Offset(newOffsetX, newOffsetY);
      print(widget.initialOffset);
      _isDragging = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('floating movable');
    return Positioned(
      left: widget.initialOffset.dx,
      top: widget.initialOffset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed(widget.initialOffset);
          }
        },
        child: Container(
          height: widget.radius ?? 30.0,
          width: widget.radius ?? 30.0,
          decoration: BoxDecoration(
            color: widget.color ?? Colors.greenAccent,
            shape: widget.shape ?? BoxShape.circle,
          ),
          key: widget.parentKey,
          child: widget.child,
        ),
      ),
    );
  }
}

// // ignore: must_be_immutable
// class ExpandableDraggableFloatingButton extends StatefulWidget {
//   ExpandableDraggableFloatingButton(
//       {super.key,
//       required this.children,
//       required this.offset,
//       this.childMain,
//       this.direction,
//       this.sizeMainFloatingButon,
//       this.controller});
//
//   final GlobalKey _parentKey = GlobalKey();
//   final Direction? direction;
//   final double? sizeMainFloatingButon;
//   Widget? childMain;
//   Color? colorChildMain;
//   List<Widget>? children;
//   Offset? offset;
//   int? spacingMainToChild;
//   AnimationController? controller;
//
//   @override
//   State<ExpandableDraggableFloatingButton> createState() =>
//       _ExpandableDraggableFloatingButtonState();
// }
//
// class _ExpandableDraggableFloatingButtonState
//     extends State<ExpandableDraggableFloatingButton> {
//   List<Widget> listChild = [];
//   bool isOpening = false;
//
//   @override
//   void initState() {
//     super.initState();
//     listChild.clear();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     widget.controller?.dispose();
//     super.dispose();
//   }
//
//   Widget childWidget(double dx, double dy, Widget childWidget1, int i) {
//     return Positioned(
//       left: dx,
//       top: dy,
//       child: childWidget1,
//     );
//   }
//
//   Position getCurrentPosition(int sizeFloatingButton, double currentDx,
//       double currentDy, BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     double midWidth = size.width / 2;
//
//     if ((widget.children?.length ?? 0) > 0) {
//       // Top Left / Right
//
//       double tmpY = currentDy -
//           ((sizeFloatingButton + 10) * (widget.children?.length ?? 1) +
//               (sizeFloatingButton + 10));
//
//       if (tmpY < 0) {
//         if (currentDx <= midWidth - sizeFloatingButton - 10) {
//           return Position.TopLeft;
//         } else if (currentDx >= midWidth + sizeFloatingButton + 10) {
//           return Position.TopRight;
//         } else {
//           return Position.Auto;
//         }
//       } else {
//         if (currentDx <= midWidth - sizeFloatingButton - 10) {
//           return Position.BottomLeft;
//         } else if (currentDx >= midWidth + sizeFloatingButton + 10) {
//           return Position.BottomRight;
//         } else {
//           return Position.Auto;
//         }
//       }
//     }
//     return Position.TopLeft;
//   }
//
//   void testUpdatePosition(Offset offset, int sizeFloatingButton,
//       Position current, Direction curDirection) {
//     listChild.clear();
//     _updatePosition(offset, sizeFloatingButton, current, curDirection);
//   }
//
//   int getOffset(int i, int sizeFloatingButton) {
//     return ((sizeFloatingButton + 10) * i + (sizeFloatingButton + 10));
//   }
//
//   void _updatePosition(Offset offset, int sizeFloatingButton, Position current,
//       Direction curDirection) {
//     for (int i = 0; i < (widget.children?.length ?? 0); i++) {
//       double newOffsetX = offset.dx;
//       double newOffsetY = offset.dy;
//
//       switch (curDirection) {
//         case Direction.Column:
//           newOffsetX = offset.dx;
//           newOffsetY = (current == Position.BottomLeft ||
//                   current == Position.BottomRight)
//               ? offset.dy - getOffset(i, sizeFloatingButton)
//               : offset.dy + getOffset(i, sizeFloatingButton);
//           break;
//         case Direction.Row:
//           if (current == Position.Auto) {
//             newOffsetX = offset.dx;
//             newOffsetY = (current == Position.BottomLeft ||
//                     current == Position.BottomRight)
//                 ? offset.dy - getOffset(i, sizeFloatingButton)
//                 : offset.dy + getOffset(i, sizeFloatingButton);
//           } else if (current == Position.BottomLeft ||
//               current == Position.TopLeft) {
//             newOffsetX = offset.dx + getOffset(i, sizeFloatingButton);
//             newOffsetY = offset.dy;
//           } else {
//             newOffsetX = offset.dx - getOffset(i, sizeFloatingButton);
//             newOffsetY = offset.dy;
//           }
//           break;
//         case Direction.Diagonal:
//           double angleIncrement = pi /
//               ((((widget.children?.length ?? 2) > 1)
//                       ? widget.children!.length
//                       : 2) -
//                   1);
//
//           double radian = 0.0;
//
//           if ((current == Position.BottomLeft || current == Position.TopLeft)) {
//             radian = pi / 2 + (angleIncrement * i);
//             newOffsetX = offset.dx -
//                 (widget.sizeMainFloatingButon! *
//                     (widget.spacingMainToChild ?? 2) *
//                     cos(radian));
//
//             newOffsetY = offset.dy -
//                 (widget.sizeMainFloatingButon! *
//                     (widget.spacingMainToChild ?? 2) *
//                     sin(radian));
//           } else {
//             radian = -(pi / 2) +
//                 (angleIncrement * (((widget.children?.length ?? 0) - 1) - i));
//             newOffsetX = offset.dx -
//                 (widget.sizeMainFloatingButon! *
//                     (widget.spacingMainToChild ?? 2) *
//                     cos(radian));
//
//             newOffsetY = offset.dy -
//                 (widget.sizeMainFloatingButon! *
//                     (widget.spacingMainToChild ?? 2) *
//                     sin(radian));
//           }
//
//         default:
//           break;
//       }
//       listChild.add(childWidget(newOffsetX, newOffsetY,
//           widget.children?[i] ?? const SizedBox(height: 0), i));
//     }
//     setState(() {
//       widget.offset = offset;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         ...listChild,
//         DraggableFloatingActionButton(
//             direction: widget.direction,
//             radius: widget.sizeMainFloatingButon!,
//             initialOffset: widget.offset!,
//             color: widget.colorChildMain ?? Colors.blue,
//             onPressed: (offset) {
//               Position current = (getCurrentPosition(
//                   widget.sizeMainFloatingButon!.toInt(),
//                   offset.dx,
//                   offset.dy,
//                   context));
//
//               setState(() {
//                 isOpening = !isOpening;
//                 (isOpening == true)
//                     ? testUpdatePosition(
//                         offset,
//                         widget.sizeMainFloatingButon!.toInt(),
//                         current,
//                         widget.direction ?? Direction.Column)
//                     : listChild.clear();
//               });
//             },
//             parentKey: widget._parentKey,
//             child: widget.childMain!)
//       ],
//     );
//   }
// }
//
// class AnimationFloatingButton extends StatelessWidget {
//   AnimationFloatingButton({super.key, this.animationController});
//
//   AnimationController? animationController;
//
//   Widget? childWidget;
//   Offset? offset;
//   double? sizeButton;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (context, child) {
//         return Transform(
//             transform: Matrix4.identity()
//               ..translate(offset!.dx, offset!.dy)
//               ..translate(sizeButton! / 2, sizeButton! / 2)
//               ..rotateZ((1 - animationController!.value) * pi / 180)
//               ..translate(-sizeButton! / 2, -sizeButton! / 2));
//       },
//     );
//   }
// }
//
// enum Position {
//   // ignore: constant_identifier_names
//   TopLeft,
//   // ignore: constant_identifier_names
//   TopRight,
//   // ignore: constant_identifier_names
//   BottomLeft,
//   // ignore: constant_identifier_names
//   BottomRight,
//   // ignore: constant_identifier_names
//   Auto,
// }
//
// // ignore: constant_identifier_names
// enum Direction { Row, Column, Diagonal }
//
// class MyFlowDelegate extends FlowDelegate {
//   AnimationController? animationController;
//   int? buttonSize;
//   Offset? currentMainButtonOffset;
//
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     int n = context.childCount;
//     for (var i = 0; i < n; i++) {
//       double x = 10;
//       double y = 10;
//
//       context.paintChild(i,
//           transform: Matrix4.identity()
//             ..translate(x, y, 0)
//             ..translate(buttonSize! / 2, buttonSize! / 2)
//             ..rotateZ((180 * (1 - animationController!.value) * pi / 180))
//             ..translate(-buttonSize! / 2, -buttonSize! / 2));
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant MyFlowDelegate oldDelegate) {
//     return currentMainButtonOffset != oldDelegate.currentMainButtonOffset;
//   }
// }
