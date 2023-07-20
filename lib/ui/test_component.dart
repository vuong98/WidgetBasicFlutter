import 'package:flutter/material.dart';
import 'package:widgetscomponent/ui/list_switch.dart';
import 'package:widgetscomponent/ui/swiper_screen.dart';
import 'package:widgetscomponent/widgets/animation_basic.dart';
import 'package:widgetscomponent/widgets/button_widget.dart';
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
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //   child: Column(children: [
          //     SizedBox(
          //       width: double.infinity,
          //       child: ButtonWidget(
          //         title: 'Swiper',
          //         textStyle: const TextStyle(color: Colors.white, fontSize: 18),
          //         onPressed: () {
          //           Navigator.of(context).pushNamed(SwiperScreen.routeName);
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       width: double.infinity,
          //       child: ButtonWidget(
          //           title: 'Switch',
          //           textStyle:
          //               const TextStyle(color: Colors.white, fontSize: 18),
          //           onPressed: () {
          //             Navigator.of(context).pushNamed(ListSwitch.routeName);
          //           }),
          //     ),
          //     SizedBox(
          //       width: double.infinity,
          //       child: ButtonWidget(
          //         title: 'Floating',
          //         textStyle: const TextStyle(color: Colors.white, fontSize: 18),
          //         onPressed: () {},
          //       ),
          //     )
          //   ]),
          // ),
          // DraggableFloatingActionButton(
          //   initialOffset: Offset(MediaQuery.of(context).size.width - 65,
          //       MediaQuery.of(context).size.height / 2 - 65),
          //   parentKey: _parentKey,
          //   onPressed: () {
          //     print('Click');
          //   },
          //   child: Container(
          //     width: 60,
          //     height: 60,
          //     decoration: const ShapeDecoration(
          //       shape: CircleBorder(),
          //       color: Colors.red,
          //     ),
          //   ),
          // ),
          ExpandableDraggableFloatingButton(
            offset: const Offset(150, 450),
            direction: Direction.Diagonal,
            childMain: Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            sizeMainFloatingButon: 40,
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.amber),
                child: const Icon(Icons.menu),
              ),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: const Icon(Icons.menu),
              ),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
                child: const Icon(Icons.menu),
              ),
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepOrange),
                child: const Icon(Icons.menu),
              ),
              // Container(
              //   height: 40,
              //   width: 40,
              //   alignment: Alignment.center,
              //   decoration: const BoxDecoration(
              //       shape: BoxShape.circle, color: Colors.deepOrange),
              //   child: const Icon(Icons.menu),
              // ),
              // Container(
              //   height: 40,
              //   width: 40,
              //   alignment: Alignment.center,
              //   decoration: const BoxDecoration(
              //       shape: BoxShape.circle, color: Colors.lime),
              //   child: const Icon(Icons.menu),
              // )
            ],
          )
          // AnimationBasic(controller: controller, animation: animation),
          // GestureDetector(
          //   onTap: () {
          //     print('Click');
          //     if (controller?.status == AnimationStatus.completed) {
          //       controller?.reverse();
          //     } else {
          //       controller?.forward();
          //     }
          //   },
          //   child: Container(
          //     decoration: const BoxDecoration(
          //         color: Colors.black, shape: BoxShape.circle),
          //     height: 40,
          //     width: 40,
          //     alignment: Alignment.center,
          //     child: const Icon(
          //       Icons.add,
          //       size: 20,
          //       color: Colors.red,
          //     ),
          //   ),
          // )
        ]));
  }
}
