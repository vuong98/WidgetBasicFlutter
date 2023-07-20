import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget(
      {super.key,
      this.colorSelected,
      this.colorUnSelected,
      this.width,
      this.height,
      required this.currentPage,
      required this.itemCount,
      this.paddingItem,
      this.radius,
      this.axis,
      this.alignment});

  final Color? colorSelected;
  final EdgeInsets? paddingItem;
  final int? currentPage;
  final Color? colorUnSelected;
  final double? width;
  final double? height;
  final double? radius;
  final int? itemCount;
  final Alignment? alignment;
  final Axis? axis;

  Widget _buidItemIndicator(double? height, double? width, Color? color,
      BorderRadiusGeometry borderRadius) {
    return Container(
      height: height ?? 15,
      width: width ?? 15,
      decoration: BoxDecoration(color: color, borderRadius: borderRadius),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: (height ?? 1) * 2,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: itemCount,
        scrollDirection: axis ?? Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              padding:
                  paddingItem ?? const EdgeInsets.symmetric(horizontal: 10),
              child: _buidItemIndicator(
                  height,
                  (currentPage == index) ? ((width ?? 15) * 2) : width,
                  (currentPage == index) ? colorSelected : colorUnSelected,
                  BorderRadius.circular(radius ?? 30)));
        },
      ),
    );
  }
}
