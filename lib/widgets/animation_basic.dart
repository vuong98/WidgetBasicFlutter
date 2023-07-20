import 'dart:math';

import 'package:flutter/material.dart';

class AnimationBasic extends StatefulWidget {
  AnimationBasic(
      {super.key, required this.controller, required this.animation});
  AnimationController? controller;
  Animation<double>? animation;

  @override
  State<AnimationBasic> createState() => _AnimationBasicState();
}

Offset offset = Offset(10, 10);

class _AnimationBasicState extends State<AnimationBasic>
    with SingleTickerProviderStateMixin {
  List<Widget> listChildren = [];
  @override
  void initState() {
    super.initState();

    listChildren.add(MyAnimation(
      animationController: widget.controller,
      position: 0,
      childWidget: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
        child: const Icon(
          Icons.edit,
          size: 20,
        ),
      ),
      x: 200,
      y: 200,
      buttonSize: 40,
    ));
    // listChildren.add(MyAnimation(
    //   position: 100,
    //   animationController: controller,
    //   childWidget: Container(
    //     height: 40,
    //     width: 40,
    //     decoration:
    //         const BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
    //   ),
    // ));
    // listChildren.add(MyAnimation(
    //   position: 200,
    //   animationController: controller,
    //   childWidget: Container(
    //     height: 40,
    //     width: 40,
    //     decoration:
    //         const BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
    //   ),
    // ));
    // listChildren.add(MyAnimation(
    //   position: 300,
    //   animationController: controller,
    //   childWidget: Container(
    //     height: 40,
    //     width: 40,
    //     decoration:
    //         const BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
    //   ), buttonSize: null, x: null, y: null,
    // ));
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [...listChildren],
    );
  }
}

// ignore: must_be_immutable
class MyAnimation extends StatelessWidget {
  MyAnimation(
      {super.key,
      required this.animationController,
      required this.childWidget,
      required this.x,
      required this.y,
      required this.buttonSize,
      required this.position});

  AnimationController? animationController;
  Widget? childWidget;
  double? position;
  double? x;
  double? y;
  double? buttonSize;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController!,
        builder: (context, child) {
          print('$x - $y - ${animationController!.value}');

          if (animationController?.status == AnimationStatus.completed) {
            offset = Offset(x! * animationController!.value,
                y! * animationController!.value);
          } else {}

          return Transform(
            transform: Matrix4.identity()
              ..translate(x! * animationController!.value,
                  y! * animationController!.value, 0)
              ..translate(buttonSize! / 2, buttonSize! / 2)
              ..rotateZ(180 * (1 - animationController!.value) * pi / 180)
              ..translate(-buttonSize! / 2, -buttonSize! / 2),
            child: childWidget,
          );
        });
  }
}
