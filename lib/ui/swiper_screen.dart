import 'package:flutter/material.dart';
import 'package:widgetscomponent/constants/constants.dart';
import 'package:widgetscomponent/widgets/item_slider_widget.dart';
import 'package:widgetscomponent/widgets/swiper_widget.dart';

class SwiperScreen extends StatelessWidget {
  const SwiperScreen({super.key});

  static const String routeName = '/swiper_screen';

  @override
  Widget build(BuildContext context) {
    return Swiper(
      radiusItemIndicator: 10,
      widthIndicator: 10,
      alignmentItem: Alignment.bottomCenter,
      alignment: Alignment.centerRight,
      heightIndicator: 10,
      colorSelectedIndicator: Colors.red,
      colorUnselectedIndicator: Colors.amberAccent[60],
      itemCount: 4,
      mode: ModeAnimation.FadeInAnimation,
      child: (context, index) {
        return ItemSliderWidget(
            alignmentItem: MainAxisAlignment.start,
            nameDevice: 'Device $index',
            description:
                'Thông tin chi tiết sản phẩm $index ----------------------',
            spacingHeightItem: 10,
            price: index * 120,
            imageUrl:
                'https://t3.ftcdn.net/jpg/03/24/73/92/360_F_324739203_keeq8udvv0P2h1MLYJ0GLSlTBagoXS48.jpg',
            errorWidget: const Icon(
              Icons.error_rounded,
              color: Colors.red,
            ));
      },
    );
  }
}
