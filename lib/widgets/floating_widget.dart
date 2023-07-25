import 'package:flutter/material.dart';

import 'custom_fab_widget.dart';

// ignore: must_be_immutable
class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  Offset initialOffset;
  final Function(Offset) onPressed;
  final Color? color;
  final BoxShape? shape;
  final double? radius;
  final double? distance;
  final Duration? duration;

  DraggableFloatingActionButton({
    super.key,
    required this.child,
    required this.initialOffset,
    required this.onPressed,
    required this.parentKey,
    required this.parentPreviousViewKey,
    this.color,
    this.shape,
    this.controller,
    required this.radius,
    this.distance = 60.0,
    this.duration,
  });

  final GlobalKey parentKey;
  final GlobalKey parentPreviousViewKey;
  AnimationController? controller;

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> with TickerProviderStateMixin {
  bool _isDragging = false;
  late Offset _minOffset;
  late Offset _maxOffset;
  late double widthScreen;
  late double heightScreen;
  double? positionX;
  double? positionY;

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_setBoundary);
  }

  void _setBoundary(_) {
    try {
      widthScreen = MediaQuery.of(context).size.width;
      heightScreen = MediaQuery.of(context).size.height;

      RenderBox? renderBox = widget.parentPreviousViewKey.currentContext
          ?.findRenderObject() as RenderBox?;
      final position = renderBox?.localToGlobal(Offset.zero);

      final double maxWidth = widthScreen - widget.radius!;

      double maxHeight = heightScreen -
          const Size.fromHeight(kToolbarHeight).height -
          (widget.radius! * 3) -
          widget.distance!;

      double minWidth = position?.dx ?? 0.0;

      double minHeight =
          (position?.dy ?? 0.0) + widget.distance! + (widget.radius! * 2);

      setState(() {
        _minOffset = Offset(minWidth, minHeight);
        _maxOffset = Offset(maxWidth, maxHeight);
      });
    } catch (e) {}
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
    return AnimatedPositioned(
      duration: (_isDragging == true)
          ? const Duration(milliseconds: 0)
          : widget.duration ?? const Duration(milliseconds: 150),
      left: widget.initialOffset.dx,
      top: widget.initialOffset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          if (_isDragging) {
            Position position = getCurrentPosition(
                widthScreen,
                heightScreen,
                Offset(widget.initialOffset.dx, widget.initialOffset.dy),
                widget.radius?.toInt() ?? 35);

            if (position == Position.TopLeft ||
                position == Position.BottomLeft) {
              widget.initialOffset = Offset(0, widget.initialOffset.dy);
            } else {
              widget.initialOffset = Offset(
                  widthScreen - (widget.radius ?? 35), widget.initialOffset.dy);
            }

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
            child: AnimatedBuilder(
              animation: widget.controller!,
              child: widget.child,
              builder: (context, child) {
                return Transform.rotate(
                  angle: (widget.controller!.value == 1)
                      ? 0
                      : widget.controller!.value,
                  alignment: Alignment.center,
                  child: child,
                );
              },
            )),
      ),
    );
  }
}
