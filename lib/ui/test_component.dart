import 'package:flutter/material.dart';
import 'package:widgetscomponent/ui/list_switch.dart';
import 'package:widgetscomponent/ui/swiper_screen.dart';
import 'package:widgetscomponent/widgets/button_widget.dart';

class TestComponent extends StatelessWidget {
  const TestComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
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
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
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
        ));
  }
}
