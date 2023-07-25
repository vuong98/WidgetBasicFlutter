import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetscomponent/widgets/floating_widget.dart';

class CustomFABWidget extends StatefulWidget {
  CustomFABWidget(
      {super.key,
      this.parentKey,
      this.parentPreviousViewKey,
      this.distance,
      this.offsetDistance,
      required this.initOffset,
      required this.children,
      this.duration,
      this.sizeMainFAB});
  GlobalKey? parentKey;
  GlobalKey? parentPreviousViewKey;

  double? distance;
  double? offsetDistance; // trong doan [1...2]
  double? sizeMainFAB;
  Offset? initOffset;
  List<Widget> children;
  Duration? duration;
  double? maxHeight;
  double? maxWidth;
  double? minHeight;
  double? minWidth;

  @override
  State<CustomFABWidget> createState() => _CustomFABWidgetState();
}

class _CustomFABWidgetState extends State<CustomFABWidget>
    with TickerProviderStateMixin {
  AnimationController? controller;
  bool isOpening = false;
  double? positionX;
  double? positionY;
  int count = 0;
  Size? size;
  @override
  void initState() {
    // TODO: implement initState

    controller = AnimationController(
        vsync: this,
        duration: widget.duration ?? const Duration(milliseconds: 350));

    controller?.addStatusListener((status) {
      print('isOpening = $isOpening');
      if (status == AnimationStatus.dismissed) {
        setState(() {
          count = 0;
          isOpening = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Visibility(
            visible: (count != 0),
            child: Flow(
                delegate: MyFlowDelegate(
                    offsetDistance: widget.offsetDistance,
                    animationController: controller!,
                    currentMainButtonOffset: widget.initOffset,
                    heightScreen: size!.height,
                    widthScreen: size!.width,
                    distance: widget.distance ?? 70,
                    buttonSize: widget.sizeMainFAB?.toInt() ?? 35),
                children: widget.children.asMap().entries.map((e) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      double maxHeight = widget.maxHeight ?? 50;
                      double maxWidth = widget.maxWidth ?? 50;
                      double minHeight = widget.minHeight ?? 35;
                      double minWidth = widget.minWidth ?? 35;
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: minWidth,
                            minHeight: minHeight,
                            maxHeight: maxHeight,
                            maxWidth: maxWidth),
                        child: e.value,
                      );
                    },
                  );
                }).toList()),
          ),
          DraggableFloatingActionButton(
            controller: controller,
            parentPreviousViewKey: widget.parentPreviousViewKey!,
            radius: widget.sizeMainFAB ?? 35,
            distance: widget.distance ?? 70,
            initialOffset: widget.initOffset!,
            color: Colors.blue,
            onPressed: (offset) {
              setState(() {
                count++;

                widget.initOffset = offset;
                if (controller?.status == AnimationStatus.completed) {
                  controller?.reverse();
                } else {
                  controller?.forward();
                  isOpening = true;
                }
              });
            },
            parentKey: widget.parentKey!,
            child: Visibility(
                visible: true,
                child: (isOpening)
                    ? const Icon(Icons.close_rounded)
                    : const Icon(Icons.add)),
          ),
        ],
      ),
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  MyFlowDelegate(
      {required this.animationController,
      required this.buttonSize,
      required this.widthScreen,
      required this.heightScreen,
      required this.distance,
      this.offsetDistance = 1.5, // trong doan [1...2]
      required this.currentMainButtonOffset})
      : super(repaint: animationController);

  Animation<double> animationController;
  int? buttonSize;
  Offset? currentMainButtonOffset;
  double widthScreen;
  double heightScreen;
  double? distance;
  double? offsetDistance;

  @override
  void paintChildren(FlowPaintingContext context) {
    int n = context.childCount;
    Position currentPosition = getCurrentPosition(
        widthScreen, heightScreen, currentMainButtonOffset!, buttonSize!);

    Size sizeChild = context.getChildSize(0)!;

    dynamic tempButtonSize = min(sizeChild.height, sizeChild.width).toInt();

    buttonSize = min(buttonSize!, tempButtonSize);

    if (n <= 3) {
      dynamic radius = distance! *
          ((offsetDistance! > 2 || offsetDistance! < 1)
              ? 2.0
              : offsetDistance!) *
          animationController.value;
      for (int i = 0; i < n; i++) {
        dynamic x = 0;
        dynamic y = 0;
        if (currentPosition == Position.TopLeft ||
            currentPosition == Position.BottomLeft) {
          dynamic rad = 2 * pi / 3 + i * 2 * pi / 6;

          x = currentMainButtonOffset!.dx - (radius * cos(rad));
          y = currentMainButtonOffset!.dy - (radius * sin(rad));
        } else {
          dynamic rad = (n <= 2)
              ? 2 * pi / 3 - (n - i) * 2 * pi / 6
              : pi / 3 - (n - 1 - i) * 2 * pi / 6;

          x = currentMainButtonOffset!.dx - (radius * cos(rad));
          y = (n > 2)
              ? currentMainButtonOffset!.dy + (radius * sin(rad))
              : currentMainButtonOffset!.dy - (radius * sin(rad));
        }
        context.paintChild(i,
            transform: Matrix4.identity()
              ..translate(x, y, 0)
              ..translate(buttonSize! / 2, buttonSize! / 2)
              ..rotateZ((180 * (1 - animationController.value) * pi / 180))
              ..translate(-buttonSize! / 2, -buttonSize! / 2));
      }
    } else {
      for (var i = 0; i < n; i++) {
        final idxAngle = pi / ((n == 1) ? 0 : n - 1);

        dynamic rad = pi / 2 + (idxAngle * i);

        dynamic radius = distance! *
            ((offsetDistance! > 2 || offsetDistance! < 1)
                ? 2.0
                : offsetDistance!) *
            animationController.value;

        if (currentPosition == Position.TopLeft ||
            currentPosition == Position.BottomLeft) {
          rad = pi / 2 + (idxAngle * i);
        } else {
          rad = -pi / 2 + (idxAngle * (n - 1 - i));
        }
        final x = currentMainButtonOffset!.dx - (radius * cos(rad));
        final y = currentMainButtonOffset!.dy - (radius * sin(rad));
        context.paintChild(i,
            transform: Matrix4.identity()
              ..translate(x, y, 0)
              ..translate(buttonSize! / 2, buttonSize! / 2)
              ..rotateZ(
                  (degree * (1 - animationController.value) * pi / degree))
              ..translate(-buttonSize! / 2, -buttonSize! / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant MyFlowDelegate oldDelegate) {
    return currentMainButtonOffset != oldDelegate.currentMainButtonOffset;
  }
}

Position getCurrentPosition(double widthScreen, double heightScreen,
    Offset currentOffset, int sizeButton,
    {int delta = 10}) {
  double midWidth = widthScreen / 2;
  double midHeight = heightScreen / 2;
  // Top
  double positionTop = currentOffset.dy - (midHeight + delta);

  bool isLeft = (currentOffset.dx <= (midWidth - sizeButton - delta));

  if (positionTop < 0) {
    // Left
    if (isLeft) {
      // TopLeft
      return Position.TopLeft;
    } else {
      // TopRight
      return Position.TopRight;
    }
  } else {
    // Right
    if (isLeft) {
      // BottomLeft
      return Position.BottomLeft;
    } else {
      // BottomRight
      return Position.BottomRight;
    }
  }
}

enum Position {
  // ignore: constant_identifier_names
  TopLeft,
  // ignore: constant_identifier_names
  TopRight,
  // ignore: constant_identifier_names
  BottomLeft,
  // ignore: constant_identifier_names
  BottomRight;
}

const int degree = 180;
