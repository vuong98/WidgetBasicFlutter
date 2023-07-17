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
      this.alignmentItem,
      this.mode,
      required this.child});
  final EdgeInsets? marginIndicatorBottom;
  final EdgeInsets? paddingItemindicator;
  final double? heightIndicator;
  final double? widthIndicator;
  final int? itemCount;
  final double? radiusItemIndicator;
  final double? viewportFraction;

  final ModeAnimation? mode;

  final CrossAxisAlignment? alignmentCrossView;
  final MainAxisAlignment? alignmentMainView;
  final Alignment? alignment;
  final Alignment? alignmentItem;
  final Axis? axis;
  // Widget? Function(BuildContext, int) itemBuilder;

  final Color? colorSelectedIndicator;
  final Color? colorUnselectedIndicator;
  final Widget? Function(BuildContext, int)? child;

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  PageController? _pageController;
  int currentPage = 0;
  @override
  void initState() {
    currentPage = 0;
    super.initState();
    _pageController =
        PageController(viewportFraction: widget.viewportFraction ?? 1);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
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
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: widget.itemCount,
                itemBuilder: (context, index) {
                  switch (widget.mode) {
                    case ModeAnimation.TweenAnimation:
                      var _scale = (index == currentPage) ? 1.0 : 0.7;
                      return TweenAnimationBuilder(
                        tween: Tween(begin: _scale, end: _scale),
                        duration: const Duration(milliseconds: 350),
                        child: widget.child?.call(context, index),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                      );
                    case ModeAnimation.FadeInAnimation:
                      return widget.child?.call(context, index);
                    default:
                      break;
                  }
                },
              ),
            ),
            Container(
                margin: widget.marginIndicatorBottom ??
                    const EdgeInsets.only(bottom: 10),
                padding: widget.paddingItemindicator ??
                    const EdgeInsets.symmetric(horizontal: 20),
                height: widget.heightIndicator,
                width: double.infinity,
                child: IndicatorWidget(
                    radius: widget.radiusItemIndicator,
                    alignment: widget.alignment,
                    itemCount: widget.itemCount,
                    axis: widget.axis,
                    currentPage: currentPage,
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
