import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:widgetscomponent/utils/text_style.dart';

class ItemSliderWidget extends StatelessWidget {
  ItemSliderWidget(
      {super.key,
      this.edgeInsets,
      required this.imageUrl,
      required this.errorWidget,
      this.nameDevice,
      this.description,
      this.price,
      this.spacingHeightItem,
      this.alignmentItem});

  EdgeInsets? edgeInsets;
  String imageUrl;
  Widget errorWidget;
  String? nameDevice;
  String? description;
  int? price;
  TextStyle? textStyleTitle;
  TextStyle? textStyleDescription;
  TextStyle? textStylePrice;
  double? spacingHeightItem;
  double? spacingHeightTextItem;
  MainAxisAlignment? alignmentItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets ??
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: alignmentItem ?? MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            progressIndicatorBuilder: (context, url, progress) =>
                const CircularProgressIndicator(),
            errorWidget: (context, url, error) => errorWidget,
          ),
          SizedBox(height: spacingHeightItem ?? 10.0),
          Container(
            alignment: Alignment.center,
            child: Column(children: [
              Text(
                nameDevice ?? '',
                style: textStyleTitle ??
                    AppTextStyle.textStyle
                        .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: spacingHeightTextItem ?? 0),
              Text(description ?? '',
                  style: textStyleDescription ?? AppTextStyle.textStyle),
              SizedBox(height: spacingHeightTextItem ?? 0),
              Text("\$$price",
                  style: textStyleDescription ??
                      AppTextStyle.textStyle
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
            ]),
          ),
        ],
      ),
    );
  }
}
