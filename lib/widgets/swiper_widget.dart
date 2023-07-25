import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widgetscomponent/constants/constants.dart';
import 'package:widgetscomponent/utils/text_style.dart';
import 'package:widgetscomponent/widgets/indicator_widget.dart';

// ignore: must_be_immutable
class Swiper extends StatefulWidget {
  Swiper(
      {super.key,
      this.marginIndicatorBottom,
      this.paddingItemindicator,
      this.heightIndicator,
      required this.widthIndicator,
      required this.itemCount,
      this.colorSelectedIndicator,
      this.axis,
      this.colorUnselectedIndicator,
      this.alignmentCrossView,
      this.alignmentMainView,
      this.alignment,
      this.radiusItemIndicator,
      this.viewportFraction,
      this.modeAnimation,
      required this.child});
  final EdgeInsets? marginIndicatorBottom;
  final EdgeInsets? paddingItemindicator;
  final double? heightIndicator;
  final double? widthIndicator;
  final int? itemCount;
  final double? radiusItemIndicator;
  final double? viewportFraction;

  final Curve? modeAnimation;

  final CrossAxisAlignment? alignmentCrossView;
  final MainAxisAlignment? alignmentMainView;
  final Alignment? alignment;
  final Axis? axis;
  // Widget? Function(BuildContext, int) itemBuilder;

  final Color? colorSelectedIndicator;
  final Color? colorUnselectedIndicator;
  final Widget? Function(BuildContext, int) child;

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  PageController? _pageController;
  Timer? _timer;

  int currentPage = 0;
  @override
  void initState() {
    currentPage = 0;
    super.initState();
    _pageController =
        PageController(viewportFraction: widget.viewportFraction ?? 1);

    _pageController?.addListener(() {
      print('scroll');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Swiper',
            style: AppTextStyle.textStyle,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 7,
              child: PageView.builder(
                controller: _pageController,
                allowImplicitScrolling: false,
                onPageChanged: (value) {
                  print(value);
                  setState(() {
                    currentPage = value % widget.itemCount!;
                    _pageController?.jumpToPage(
                      currentPage,
                    );
                  });
                },
                itemBuilder: widget.child,
              ),
            ),
            Container(
                margin: widget.marginIndicatorBottom ??
                    const EdgeInsets.only(bottom: 10),
                height: widget.heightIndicator,
                width: double.infinity,
                child: IndicatorWidget(
                    radius: widget.radiusItemIndicator,
                    alignment: widget.alignment,
                    itemCount: widget.itemCount,
                    axis: widget.axis,
                    currentPage: (currentPage % widget.itemCount!),
                    paddingItem: widget.paddingItemindicator,
                    height: widget.heightIndicator,
                    width: widget.widthIndicator,
                    colorSelected:
                        widget.colorSelectedIndicator ?? Colors.amber,
                    colorUnSelected:
                        widget.colorUnselectedIndicator ?? Colors.black))
          ],
        ));
  }
}
