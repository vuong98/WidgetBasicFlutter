import 'package:flutter/material.dart';
import 'package:widgetscomponent/ui/list_switch.dart';
import 'package:widgetscomponent/ui/swiper_screen.dart';
import 'package:widgetscomponent/widgets/animation_basic.dart';
import 'package:widgetscomponent/widgets/button_widget.dart';
import 'package:widgetscomponent/widgets/custom_fab_widget.dart';
import 'package:widgetscomponent/widgets/custom_floating_widget.dart';
import 'package:widgetscomponent/widgets/floating_widget.dart';

// ignore: must_be_immutable
class TestComponent extends StatefulWidget {
  const TestComponent({super.key});

  @override
  State<TestComponent> createState() => _TestComponentState();
}

class _TestComponentState extends State<TestComponent>
    with TickerProviderStateMixin {
  Offset offset = const Offset(20, 20);
  final GlobalKey _parentKey = GlobalKey();
  // AnimationController? controller;

  @override
  void initState() {
    // TODO: implement initState

    // controller =
    //     AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  title: 'Swiper',
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SwiperScreen.routeName);
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                    title: 'Switch',
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ListSwitch.routeName);
                    }),
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  title: 'Floating',
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  onPressed: () {},
                ),
              )
            ]),
          ),

          CustomFABWidget(parentKey: _parentKey,
            distance: 50,
            sizeMainFAB: 50,
            offsetDistance: 1.5,
            initOffset: Offset(MediaQuery.of(context).size.width - 50,
              MediaQuery.of(context).size.height / 2
            ), children:[
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.amber),
              ),
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
              ),
            ],)
        ]));
  }
}
