import 'package:flutter/material.dart';
import 'package:widgetscomponent/ui/list_switch.dart';
import 'package:widgetscomponent/ui/swiper_screen.dart';

Map<String, WidgetBuilder> routes = {
  ListSwitch.routeName: (context) => const ListSwitch(),
  SwiperScreen.routeName: (context) => const SwiperScreen()
};
