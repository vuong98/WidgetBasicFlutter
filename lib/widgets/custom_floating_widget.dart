import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetscomponent/widgets/floating_widget.dart';

const double buttonSize = 60;

class CustomFloatingWidget extends StatefulWidget {
  CustomFloatingWidget(
      {super.key, required this.positionX, required this.positionY});

  double? positionX;
  double? positionY;

  @override
  State<CustomFloatingWidget> createState() => _CustomFloatingWidgetState();
}

class _CustomFloatingWidgetState extends State<CustomFloatingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  final GlobalKey parentKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  @override
  void dispose() {
    animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Flow(
        delegate: FlowMenuDelegate(
            controller: animationController!,
            height: widget.positionX!,
            width: widget.positionY!),
        children: <IconData>[
          Icons.mail,
          Icons.call,
          Icons.notifications,
          Icons.sms,
          Icons.menu
        ].map((e) => buildFAB(e)).toList(),
      ),
    ]);
  }

  Widget buildFAB(IconData iconData) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      height: buttonSize,
      width: buttonSize,
      child: (iconData == Icons.menu)
          ? FloatingActionButton(
              elevation: 0,
              shape: const CircleBorder(),
              splashColor: Colors.black,
              child: Icon(
                iconData,
                color: Colors.white,
                size: 45,
              ),
              onPressed: () {
                if (animationController?.status == AnimationStatus.completed) {
                  animationController?.reverse();
                } else {
                  animationController?.forward();
                }
              },
            )
          : Container(),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate(
      {required this.controller, required this.height, required this.width})
      : super(repaint: controller);
  final Animation<double> controller;
  final double height;
  final double width;

  dynamic abs(dynamic a, dynamic b) {
    return (a - b < 0) ? b - a : a - b;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final n = context.childCount;
    double height = this.height - buttonSize;
    double width = this.width - buttonSize * 2;
    for (int i = 0; i < n; i++) {
      final isLastItem = (i == n - 1) ? true : false;

      setValue(value) => isLastItem ? 0.0 : value;

      final radian = i * pi * 0.5 / (n - 2);

      final radius = 180 * controller.value;

      final x = abs(width, setValue(radius * cos(radian)));
      final y = abs(height / 2, setValue(radius * sin(radian)));
      print('X = $x - Y= $y');
      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 2, buttonSize / 2)
            ..rotateZ(180 * (1 - controller.value) * pi / 180)
            ..translate(-buttonSize / 2, -buttonSize / 2));
    }
  }

  @override
  bool shouldRepaint(covariant FlowMenuDelegate oldDelegate) {
    return controller != oldDelegate.controller;
  }
}
